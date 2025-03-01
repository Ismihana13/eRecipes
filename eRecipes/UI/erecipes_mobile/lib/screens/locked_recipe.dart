import 'package:erecipes_mobile/widgets/app_bar.dart';
import 'package:erecipes_mobile/widgets/welcome_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


class LockedRecipeScreen extends StatefulWidget {
  static const String routeName = "/omiljeniRecept";

  const LockedRecipeScreen({Key? key}) : super(key: key);

  @override
  State<LockedRecipeScreen> createState() => _LockedRecipeState();
}

class _LockedRecipeState extends State<LockedRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(naslov: 'eRecipes'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                WelcomeRow(),
              ],
            ),
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
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, 
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Nazad'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Dodaj logiku za kupovinu
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


Future<void> makePayment(BuildContext context) async {
  try {
    // Zatraži client_secret sa backenda
   // final response = await http.post(
    //  Uri.parse('https://tvoj-backend.com/create-payment-intent'), // Tvoj backend URL
     // headers: {'Content-Type': 'application/json'},
     // body: jsonEncode({'amount': 1000, 'currency': 'bam'}), // 10 KM = 1000 BAM
   // );

   // if (response.statusCode == 200) {
     // final paymentIntent = jsonDecode(response.body);

      // Inicijaliziraj Stripe payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
         // paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'eRecipes',
        ),
      );

      // Prikazivanje payment sheet-a
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Plaćanje uspješno!")),
      );
      Navigator.pop(context);  // Vrati korisnika nazad
   
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Greška pri plaćanju: $e")),
    );
  }
}
}
