import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget{
  
  const ReportScreen({Key? key}) : super(key: key);
   @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generisanje izvještaja")),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Dodaje malo razmaka od ivice
              child: ElevatedButton(
                onPressed: _kreirajIzvjestaj,
                child: Text("Generiši izvještaj"),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _kreirajIzvjestaj() {
  }
}

