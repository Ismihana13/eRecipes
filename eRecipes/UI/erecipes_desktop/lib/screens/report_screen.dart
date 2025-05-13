import 'dart:convert';
import 'dart:typed_data';
import 'package:erecipes_desktop/main.dart';
import 'package:erecipes_desktop/modal/izvjestaj_modal.dart';
import 'package:erecipes_desktop/models/izvjestaj.dart';
import 'package:erecipes_desktop/providers/izvjestaj_provider.dart';
import 'package:erecipes_desktop/providers/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool isLoading = false;
  late IzvjestajProvider _izvjestajProvider;
  List<Izvjestaj>? izvjestajData;
  Izvjestaj? selectedIzvjestaj;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _izvjestajProvider = context.read<IzvjestajProvider>();
    _fetchData();
  }

  void openIzvjestajModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return IzvjestajModal(
          onCancelPressed: () {
            Navigator.pop(context);
          },
          onReportCreated: () {
            setState(() {
              _fetchData();
            });
          },
        );
      },
    );
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var data = await _izvjestajProvider.getSve(filter: {"Naziv": ""});
      setState(() {
        izvjestajData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Greška: ${e.toString()}")),
      );
    }
  }

  Future<void> _generateAndDownloadPDF(Izvjestaj izvjestaj) async {
    final pdf = pw.Document();

    Uint8List? decodeBase64Image(String? base64String) {
      if (base64String == null || base64String.isEmpty) {
        return null;
      }
      return base64Decode(base64String);
    }

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          Uint8List? imageBytes;
          if (izvjestaj.recept?.slika != null &&
              izvjestaj.recept!.slika!.isNotEmpty) {
            imageBytes = base64Decode(izvjestaj.recept!.slika!);
          }
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  "Izvjestaj",
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  "Datum izvjestaja: ${formatDate(izvjestaj.datumIzvjestaja)}",
                  style: const pw.TextStyle(fontSize: 14),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (imageBytes != null)
                    pw.Container(
                      width: 100,
                      height: 100,
                      child: pw.Image(pw.MemoryImage(imageBytes)),
                    ),
                  pw.SizedBox(width: 10),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        "Naziv recepta: ${izvjestaj.recept?.naziv ?? 'N/A'}",
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold),
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text("Broj lajkova: ${izvjestaj.brojLajkova}"),
                      pw.Text("Broj omiljenih: ${izvjestaj.brojOmiljenih}"),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/izvjestaj.pdf');
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(content: Text("PDF sačuvan: ${file.path}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                openIzvjestajModal();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                minimumSize: const Size(150, 50),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text("Kreiraj izvještaj"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: _buildIzvjestajTable(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: selectedIzvjestaj == null
                  ? const Center(child: Text("Odaberite izvještaj za pregled"))
                  : _buildImprovedGraph(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIzvjestajTable() {
    if (izvjestajData == null || izvjestajData!.isEmpty) {
      return const Center(
        child: Text("Kreiraj izvještaj"),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen[100],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 15,
          border: TableBorder.all(
            color: Colors.black,
            width: 1,
          ),
          headingRowColor: MaterialStateProperty.all(Colors.green[300]),
          columns: const [
            DataColumn(
              label: Center(
                child: Text(
                  "Naziv recepta",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            DataColumn(
              label: Center(
                child: Text(
                  "Datum izvještaja",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            DataColumn(
              label: Center(
                child: Text(
                  "Pregled izvještaja",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            DataColumn(
              label: Center(
                child: Text(
                  "Pdf",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ],
          rows: izvjestajData!.map((izvjestaj) {
            return DataRow(
              color: MaterialStateProperty.all(
                  const Color.fromARGB(255, 221, 239, 199)),
              cells: [
                DataCell(Text(
                  izvjestaj.recept?.naziv ?? "N/A",
                  style: const TextStyle(fontSize: 14),
                )),
                DataCell(Text(
                  formatDate(izvjestaj.datumIzvjestaja),
                  style: const TextStyle(fontSize: 14),
                )),
                DataCell(
                  IconButton(
                    icon: Icon(
                      selectedIzvjestaj == izvjestaj
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        if (selectedIzvjestaj == izvjestaj) {
                          selectedIzvjestaj = null;
                        } else {
                          selectedIzvjestaj = izvjestaj;
                        }
                      });
                    },
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.download, color: Colors.black),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Preuzimanje izvještaja"),
                            content: const Text(
                                "Da li ste sigurni da želite preuzeti izvještaj u PDF formatu?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ne",
                                    style: TextStyle(color: Colors.red)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _generateAndDownloadPDF(izvjestaj);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                child: const Text(
                                  "Da",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildImprovedGraph() {
    return Column(
      children: [
        const Text(
          "Broj lajkovanih i omiljenih recepata",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20,
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      toY: selectedIzvjestaj?.brojLajkova!.toDouble() ?? 0,
                      color: Colors.blueAccent,
                      width: 20,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                  showingTooltipIndicators: [0],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      toY: selectedIzvjestaj?.brojOmiljenih!.toDouble() ?? 0,
                      color: Colors.orangeAccent,
                      width: 20,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                  showingTooltipIndicators: [0],
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false, reservedSize: 32),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return const Text("Lajkovi");
                        case 1:
                          return const Text("Omiljeni");
                        default:
                          return const Text("");
                      }
                    },
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black.withOpacity(0.2))),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (selectedIzvjestaj?.brojLajkova != null &&
            selectedIzvjestaj?.brojOmiljenih != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLabelWithValue(
                  "Lajkovi: ${selectedIzvjestaj?.brojLajkova ?? 0}",
                  Colors.blueAccent),
              const SizedBox(width: 20),
              _buildLabelWithValue(
                  "Omiljeni: ${selectedIzvjestaj?.brojOmiljenih ?? 0}",
                  Colors.orangeAccent),
            ],
          ),
      ],
    );
  }

  Widget _buildLabelWithValue(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style:
            TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
