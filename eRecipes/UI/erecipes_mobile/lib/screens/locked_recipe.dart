import 'package:erecipes_mobile/providers/auth_provider.dart';
import 'package:erecipes_mobile/providers/korisnik_provider.dart';
import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/custom_snack_bar.dart';
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
  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
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
      CustomSnackBar.showSuccessSnackBar(context, 'Plaćanje uspješno!');

      int korisnikId = AuthProvider.korisnik!.korisnikId ?? 0;
      if (korisnikId != 0) {
        await _korisnikProvider!.updateUserRole(korisnikId, 3);
        var azuriraniKorisnik = await _korisnikProvider!.getById(korisnikId);
        AuthProvider.korisnik = azuriraniKorisnik;

        Navigator.pop(context, azuriraniKorisnik);
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
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
              'Bearer sk_test_51QwgmK2VrW2Cys4yWURyrZrauPqzzle6mgBxxqUUH33i8VprWUExv5k11WiBhynV9e6JfhQpPHpnfSS4BD7qgOYK009qcmbjvU', // Tvoj Stripe Secret Key
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
