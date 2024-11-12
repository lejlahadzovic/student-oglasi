import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/models/PrijavePraksa/prijave_praksa.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/prijavepraksa_provider.dart';
import 'package:provider/provider.dart';

class PrijavePrakseReportDialog extends StatefulWidget {
  final List<Praksa> prakse;

  PrijavePrakseReportDialog({required this.prakse});

  @override
  _PrijavePrakseReportDialogState createState() =>
      _PrijavePrakseReportDialogState();
}

class _PrijavePrakseReportDialogState extends State<PrijavePrakseReportDialog> {
  Praksa? selectedPraksa;
  late PrijavePraksaProvider _prijavaPraksaProvider;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prijavaPraksaProvider = context.read<PrijavePraksaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Generiši izvještaj'),
      content: Container(
        width: 600,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Naziv prakse'),
                          SizedBox(height: 8),
                          DropdownButtonFormField<Praksa>(
                            decoration: InputDecoration(
                              labelText: 'Praksa',
                              border: OutlineInputBorder(),
                            ),
                            value: selectedPraksa,
                            onChanged: (Praksa? newValue) {
                              setState(() {
                                selectedPraksa = newValue;
                              });
                            },
                            items: widget.prakse.map((Praksa praksa) {
                              return DropdownMenuItem<Praksa>(
                                value: praksa,
                                child: Text(praksa.idNavigation?.naslov ?? ''),
                              );
                            }).toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Molimo odaberite praksu.';
                              }
                              return null;
                            },
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
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await _prijavaPraksaProvider.printReport(
                  selectedPraksa!.id!, context);
            }
          },
          child: Icon(Icons.print),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                final file = await _prijavaPraksaProvider.downloadReport(
                    selectedPraksa!.id!, context);

                if (file != null) {
                  OpenFile.open(file.path);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preuzimanje izvještaja nije uspjelo')));
              }
            }
          },
          child: Icon(Icons.download),
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
            if (_formKey.currentState!.validate()) {
              var reportData =
                  await _fetchReportData(context.read<PrijavePraksaProvider>());
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
            }
          },
        ),
      ],
    );
  }

  Future<SearchResult<PrijavePraksa>?> _fetchReportData(
      PrijavePraksaProvider prijaveProvider) async {
    var reportData = await prijaveProvider.get(filter: {
      'praksa': selectedPraksa!.id,
    });
    return reportData;
  }

  Widget _buildReportDataTable(SearchResult<PrijavePraksa> reportData) {
    // Calculate total revenue
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
                  'Naziv prakse: ${selectedPraksa?.idNavigation?.naslov ?? ''}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Naziv organizacije: ${selectedPraksa?.organizacija?.naziv ?? ''}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Početak prakse: ${DateFormat('dd.MM.yyyy').format(selectedPraksa?.pocetakPrakse ?? DateTime.now())}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Kraj prakse: ${DateFormat('dd.MM.yyyy').format(selectedPraksa?.krajPrakse ?? DateTime.now())}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          if (reportData.count == 0)
            Expanded(
              child: Center(
                child: Text(
                  'Nema prijava za odabranu praksu.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
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
                          .map((PrijavePraksa e) => DataRow(cells: [
                                DataCell(Center(
                                    child: Text(e.student?.brojIndeksa ?? ""))),
                                DataCell(Center(
                                    child: Text(
                                        '${e.student?.idNavigation?.ime} ${e.student?.idNavigation?.prezime}'))),
                                DataCell(Center(child: Text(e.cv ?? ""))),
                                DataCell(
                                    Center(child: Text(e.certifikati ?? ""))),
                                DataCell(Center(
                                    child: Text(e.propratnoPismo ?? ""))),
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
