import 'package:flutter/material.dart';
import 'package:studentoglasi_admin/models/Rezervacije/rezervacije.dart';
import 'package:studentoglasi_admin/models/Smjestaj/smjestaj.dart';
import 'package:studentoglasi_admin/models/SmjestajnaJedinica/smjestajna_jedinica.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/rezervacije_provider.dart';
import 'package:provider/provider.dart';

class RezervacijeReportDialog extends StatefulWidget {
  final List<Smjestaj> smjestaji;

  RezervacijeReportDialog({required this.smjestaji});

  @override
  _RezervacijeReportDialogState createState() =>
      _RezervacijeReportDialogState();
}

class _RezervacijeReportDialogState extends State<RezervacijeReportDialog> {
  Smjestaj? selectedSmjestaj;
  SmjestajnaJedinica? selectedSmjestajnaJedinica;
  DateTime? startDate;
  DateTime? endDate;

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
                        Text('Naziv smještaja'),
                        SizedBox(height: 8),
                        DropdownButtonFormField<Smjestaj>(
                          decoration: InputDecoration(
                            labelText: 'Smještaj',
                            border: OutlineInputBorder(),
                          ),
                          value: selectedSmjestaj,
                          onChanged: (Smjestaj? newValue) {
                            setState(() {
                              selectedSmjestaj = newValue;
                              selectedSmjestajnaJedinica = null;
                            });
                          },
                          items: widget.smjestaji.map((Smjestaj smjestaj) {
                            return DropdownMenuItem<Smjestaj>(
                              value: smjestaj,
                              child: Text(smjestaj.naziv ?? ''),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Smještajna jedinica'),
                        SizedBox(height: 8),
                        DropdownButtonFormField<SmjestajnaJedinica>(
                          decoration: InputDecoration(
                            labelText: 'Smještajna jedinica (opcionalno)',
                            border: OutlineInputBorder(),
                          ),
                          value: selectedSmjestajnaJedinica,
                          onChanged: (SmjestajnaJedinica? newValue) {
                            setState(() {
                              selectedSmjestajnaJedinica = newValue;
                            });
                          },
                          items: selectedSmjestaj?.smjestajnaJedinicas
                              ?.map((SmjestajnaJedinica jedinica) {
                            return DropdownMenuItem<SmjestajnaJedinica>(
                              value: jedinica,
                              child: Text(jedinica.naziv ?? ''),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(),
              Text('Period od - do'),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'startDate',
                      inputType: InputType.date,
                      format: DateFormat('dd.MM.yyyy'),
                      decoration: InputDecoration(
                        labelText: 'Početni datum',
                        border: OutlineInputBorder(),
                      ),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      onChanged: (val) {
                        setState(() {
                          startDate = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FormBuilderDateTimePicker(
                      name: 'endDate',
                      inputType: InputType.date,
                      format: DateFormat('dd.MM.yyyy'),
                      decoration: InputDecoration(
                        labelText: 'Krajnji datum',
                        border: OutlineInputBorder(),
                      ),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      onChanged: (val) {
                        setState(() {
                          endDate = val;
                        });
                      },
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
            if (selectedSmjestaj != null &&
                startDate != null &&
                endDate != null) {
              var reportData =
                  await _fetchReportData(context.read<RezervacijeProvider>());
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

  Future<SearchResult<Rezervacije>?> _fetchReportData(
      RezervacijeProvider rezervacijeProvider) async {
    var reportData = await rezervacijeProvider.get(filter: {
      'smjestajId': selectedSmjestaj!.id,
      'smjestajnaJedinicaId': selectedSmjestajnaJedinica?.id,
      'pocetniDatum': DateFormat('yyyy-MM-dd').format(startDate!),
      'krajnjiDatum': DateFormat('yyyy-MM-dd').format(endDate!),
    });
    return reportData;
  }

  Widget _buildReportDataTable(SearchResult<Rezervacije> reportData) {
    // Calculate total revenue
    double totalRevenue = reportData.result
        .map((e) => e.cijena ?? 0.0)
        .reduce((value, element) => value + element);

    return Container(
      width: 794,
      height: 1123,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          Text(
            'Naziv smještaja: ${selectedSmjestaj?.naziv ?? ''}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (selectedSmjestajnaJedinica != null)
            Text(
              'Smještajna jedinica: ${selectedSmjestajnaJedinica?.naziv ?? ''}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          Text(
            'Period: ${DateFormat('dd.MM.yyyy').format(startDate!)} - ${DateFormat('dd.MM.yyyy').format(endDate!)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
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
                              'Datum prijave',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Datum odjave',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Cijena',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                    rows: reportData.result
                        .map((Rezervacije e) => DataRow(cells: [
                              DataCell(Center(
                                  child: Text(e.student?.brojIndeksa ?? ""))),
                              DataCell(Center(
                                  child: Text(
                                      '${e.student?.idNavigation.ime} ${e.student?.idNavigation.prezime}'))),
                              DataCell(Center(
                                  child: Text(e.datumPrijave != null
                                      ? DateFormat('dd.MM.yyyy')
                                          .format(e.datumPrijave!)
                                      : ''))),
                              DataCell(Center(
                                  child: Text(e.datumOdjave != null
                                      ? DateFormat('dd.MM.yyyy')
                                          .format(e.datumOdjave!)
                                      : ''))),
                              DataCell(Center(
                                  child: Text(e.cijena != null
                                      ? '${e.cijena!.toStringAsFixed(2)} KM'
                                      : ''))),
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
                  'Ukupan broj rezervacija: ${reportData.count}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Ukupna zarada: ${totalRevenue.toStringAsFixed(2)} KM',
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
