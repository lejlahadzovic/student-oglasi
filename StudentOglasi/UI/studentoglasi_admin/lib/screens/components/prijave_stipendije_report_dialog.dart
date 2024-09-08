import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studentoglasi_admin/models/PrijaveStipendija/prijave_stipendija.dart';
import 'package:studentoglasi_admin/models/Stipendija/stipendija.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/providers/prijavestipendija_provider.dart';

class PrijaveStipendijeReportDialog extends StatefulWidget {
  final List<Stipendije> stipendije;

  PrijaveStipendijeReportDialog({required this.stipendije});

  @override
  _PrijaveStipendijeReportDialogState createState() =>
      _PrijaveStipendijeReportDialogState();
}

class _PrijaveStipendijeReportDialogState
    extends State<PrijaveStipendijeReportDialog> {
  Stipendije? selectedStipendija;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Generiši izvještaj'),
      content: Container(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Naziv stipendije'),
                        SizedBox(height: 8),
                        DropdownButtonFormField<Stipendije>(
                          decoration: InputDecoration(
                            labelText: 'Stipendija',
                            border: OutlineInputBorder(),
                          ),
                          value: selectedStipendija,
                          onChanged: (Stipendije? newValue) {
                            setState(() {
                              selectedStipendija = newValue;
                            });
                          },
                          items: widget.stipendije.map((Stipendije stipendija) {
                            return DropdownMenuItem<Stipendije>(
                              value: stipendija,
                              child:
                                  Text(stipendija.idNavigation?.naslov ?? ''),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text('Otkaži'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Generiši'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blue.shade800),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontWeight: FontWeight.bold)),
          ),
          onPressed: () async {
            if (selectedStipendija != null) {
              var reportData = await _fetchReportData(
                  context.read<PrijaveStipendijaProvider>());
              if (reportData != null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Izvještaj',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      content: _buildReportDataTable(reportData),
                    );
                  },
                );
              }
            } else {
              // Show some error
            }
          },
        ),
      ],
    );
  }

  Future<SearchResult<PrijaveStipendija>?> _fetchReportData(
      PrijaveStipendijaProvider prijaveProvider) async {
    var reportData = await prijaveProvider.get(filter: {
      'stipendija': selectedStipendija!.id,
    });
    return reportData;
  }

  Widget _buildReportDataTable(SearchResult<PrijaveStipendija> reportData) {
    int countAccepted = 0;
    int countCnaceled = 0;
    if (reportData.result.map((e) => e.status?.naziv).contains("Odobrena")) {
      countAccepted++;
    } else if (reportData.result
        .map((e) => e.status?.naziv)
        .contains("Otkazana")) {
      countCnaceled++;
    }
    return Container(
      width: 794,
      height: 1123,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Naziv prakse: ${selectedStipendija?.idNavigation?.naslov ?? ''}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Naziv stipenditora: ${selectedStipendija?.stipenditor?.naziv ?? ''}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 794,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: [
                      const DataColumn(
                        label: Expanded(
                          child: Text(
                            'Broj indeksa',
                            style: TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const DataColumn(
                        label: Expanded(
                          child: Text(
                            'Ime i prezime',
                            style: TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const DataColumn(
                        label: Expanded(
                          child: Text(
                            'CV',
                            style: TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const DataColumn(
                        label: Expanded(
                          child: Text(
                            'Certifikati',
                            style: TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const DataColumn(
                        label: Expanded(
                          child: Text(
                            'Propratno pismo',
                            style: TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                    rows: reportData.result
                        .map((PrijaveStipendija e) => DataRow(cells: [
                              DataCell(Center(
                                  child: Text(e.student?.brojIndeksa ?? ""))),
                              DataCell(Center(
                                  child: Text(
                                      '${e.student?.idNavigation.ime} ${e.student?.idNavigation.prezime}'))),
                              DataCell(Center(child: Text(e.cv ?? ""))),
                              DataCell(Center(
                                  child: Text(e.prosjekOcjena.toString()))),
                              DataCell(
                                  Center(child: Text(e.dokumentacija ?? ""))),
                            ]))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ukupan broj prijava: ${reportData.count}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Ukupan broj prihvaćenih prijava: ${countAccepted.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Ukupan broj odbijenih prijava: ${countCnaceled.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Datum kreiranja izvještaja: ${DateFormat('dd.MM.yyyy').format(DateTime.now())}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
