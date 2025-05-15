import 'package:erecipes_mobile/models/recept.dart';
import 'package:erecipes_mobile/models/search_result.dart';
import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/providers/recipe_provider.dart';
import 'package:erecipes_mobile/providers/uplata_provider.dart';
import 'package:erecipes_mobile/providers/utils.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/custom_snack_bar.dart';
import 'package:erecipes_mobile/widgets/custom_title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class LockedRecipeScreen extends StatefulWidget {
  static const String routeName = "/omiljeniRecept";

  const LockedRecipeScreen({super.key});

  @override
  State<LockedRecipeScreen> createState() => _LockedRecipeState();
}

class _LockedRecipeState extends State<LockedRecipeScreen> {
  Map<String, dynamic>? paymentIntent;
  KorisnikProvider? _korisnikProvider;
  UplataProvider? _uplataProvider;
  RecipeProvider? _recipeProvider;
  SearchResult<Recept>? data;

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    _recipeProvider = context.read<RecipeProvider>();
    _uplataProvider = context.read<UplataProvider>();
    loadData();
  }

  Future loadData() async {
    var filter = {
      'Status': true,
    };
    var tmpData = await _recipeProvider?.get(filter: filter);
    setState(() {
      data = tmpData!;
    });
  }

  Future<void> makePayment(BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent('10', 'bam');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'eRecipes',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      CustomSnackBar.showSuccessSnackBar(context, 'Plaćanje uspješno!');

      int korisnikId = AuthProvider.korisnik!.korisnikId ?? 0;
      if (korisnikId != 0) {
        await _korisnikProvider!.updateUserRole(korisnikId, 3);
        var azuriraniKorisnik = await _korisnikProvider!.getById(korisnikId);
        AuthProvider.korisnik = azuriraniKorisnik;
        await _uplataProvider!.insert({
          'korisnikId': korisnikId,
          'iznos': 10.0,
          'datumUplate': DateTime.now().toIso8601String(),
        });
        Navigator.pop(context, azuriraniKorisnik);
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Center(
                  child: CustomTitleText(title: 'Uspješna kupovina')),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Kupovinom ovog paketa dobili ste pristup svim premium receptima!',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      if (data != null &&
                          data!.result
                              .where((recept) => recept.premium == true)
                              .isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: data!.result
                              .where((recept) => recept.premium == true)
                              .length,
                          itemBuilder: (context, index) {
                            var recept = data!.result
                                .where((recept) => recept.premium == true)
                                .toList()[index];
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 75,
                                    child: recept.slika == null
                                        ? const Placeholder()
                                        : imageFromString(recept.slika!),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    recept.naziv ?? "Bez naziva",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      else
                        const Text('Nema premium recepata dostupnih.'),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Zatvori'),
                ),
              ],
            );
          },
        );
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      print("Greška prilikom plaćanja: $e");
      CustomSnackBar.showErrorSnackBar(context, 'Greška prilikom plaćanja!');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      final body = {
        'amount': (int.parse(amount) * 100).toString(),
        'currency': currency,
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51QwgmK2VrW2Cys4yWURyrZrauPqzzle6mgBxxqUUH33i8VprWUExv5k11WiBhynV9e6JfhQpPHpnfSS4BD7qgOYK009qcmbjvU',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (err) {
      print('Greška kod PaymentIntenta: $err');
      throw Exception(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/images.png',
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Postanite Premium Korisnik!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Ovaj recept je zaključan! Ukoliko želite kupiti recept, idite na dugme Kupi!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Kupovinom ovog recepta, postajete premium korisnik. Osim što dobijate željeni recept, dobijate besplatan pristup svim ostalim zaključanim receptima. Cijena ovog paketa je 10KM.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Nazad'),
                ),
                ElevatedButton(
                  onPressed: () {
                    makePayment(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Kupi'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
