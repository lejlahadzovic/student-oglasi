import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Rezervacije/rezervacije.dart';
import 'package:studentoglasi_admin/models/Smjestaj/smjestaj.dart';
import 'package:studentoglasi_admin/models/Student/student.dart';
import 'package:studentoglasi_admin/providers/rezervacije_provider.dart';
import 'package:studentoglasi_admin/providers/smjestaji_provider.dart';
import 'package:studentoglasi_admin/providers/statusprijave_provider.dart';
import 'package:studentoglasi_admin/providers/studenti_provider.dart';
import 'package:studentoglasi_admin/screens/components/rezervacije_details_dialog.dart';
import 'package:studentoglasi_admin/screens/components/rezervacije_report_dialog.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

import '../models/StatusPrijave/statusprijave.dart';
import '../models/search_result.dart';
import 'components/costum_paginator.dart';

class RezervacijeListScreen extends StatefulWidget {
  const RezervacijeListScreen({super.key});

  @override
  State<RezervacijeListScreen> createState() => _RezervacijeListScreen();
}

class _RezervacijeListScreen extends State<RezervacijeListScreen> {
  late RezervacijeProvider _rezervacijeProvider;
  late StatusPrijaveProvider _statusProvider;
  late StudentiProvider _studentProvider;
  late SmjestajiProvider _smjestajiProvider;
  SearchResult<Rezervacije>? result;
  SearchResult<StatusPrijave>? statusResult;
  SearchResult<Student>? studentResult;
  SearchResult<Smjestaj>? smjestajiResult;
  StatusPrijave? selectedStatusPrijave;
  TextEditingController _brojIndeksaController = new TextEditingController();
  TextEditingController _imeController = new TextEditingController();
  int _currentPage = 0;
  int _totalItems = 0;
  late NumberPaginatorController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rezervacijeProvider = context.read<RezervacijeProvider>();
    _statusProvider = context.read<StatusPrijaveProvider>();
    _studentProvider = context.read<StudentiProvider>();
    _smjestajiProvider = context.read<SmjestajiProvider>();
    _pageController = NumberPaginatorController();
    _fetchData();
    _fetchStatusPrijave();
    _fetchStudenti();
    _fetchSmjestaji();
  }

  int calculateNumberPages(int totalItems, int pageSize) {
    return (totalItems / pageSize).ceil();
  }

  @override
  Widget build(BuildContext context) {
    int numberPages = calculateNumberPages(_totalItems, 5);
    return MasterScreenWidget(
      title: "Rezervacije",
      addButtonLabel: 'Generiši izvještaj',
      addButtonIcon: Icons.description,
      onAddButtonPressed: () async {
        if (smjestajiResult != null) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return RezervacijeReportDialog(
                smjestaji: smjestajiResult!.result,
              );
            },
          );
        }
      },
      child: Container(
        child: Column(
          children: [
            _buildSearch(),
            _buildDataListView(),
            if (_currentPage >= 0 && numberPages - 1 >= _currentPage)
              CustomPaginator(
                numberPages: numberPages,
                initialPage: _currentPage,
                onPageChange: (int index) {
                  setState(() {
                    _currentPage = index;
                    _fetchData();
                  });
                },
                pageController: _pageController,
                fetchData: _fetchData,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    var data = await _rezervacijeProvider.get(filter: {
      'ime': _imeController.text,
      'brojIndeksa': _brojIndeksaController.text,
      'status': selectedStatusPrijave?.id,
      'page': _currentPage + 1,
      'pageSize': 5,
    });
    setState(() {
      result = data;
      _totalItems = data.count;
      int numberPages = calculateNumberPages(_totalItems, 5);
      if (_currentPage >= numberPages) {
        _currentPage = numberPages - 1;
      }
      if (_currentPage < 0) {
        _currentPage = 0;
      }
      print(
          "Total items: $_totalItems, Number of pages: $numberPages, Current page after fetch: $_currentPage");
    });
  }

  void _fetchStatusPrijave() async {
    var statusData = await _statusProvider.get();
    setState(() {
      statusResult = statusData;
    });
  }

  void _fetchStudenti() async {
    var studentData = await _studentProvider.get();
    setState(() {
      studentResult = studentData;
    });
  }

  void _fetchSmjestaji() async {
    var smjestajiData = await _smjestajiProvider.get();
    setState(() {
      smjestajiResult = smjestajiData;
    });
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: "Ime i prezime"),
                controller: _imeController,
              ),
            ),
          ),
          SizedBox(width: 30.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(labelText: "Broj indeksa"),
                controller: _brojIndeksaController,
              ),
            ),
          ),
          SizedBox(width: 30.0),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: DropdownButton2<StatusPrijave>(
                isExpanded: true,
                hint: Text('Status prijave'),
                value: selectedStatusPrijave,
                onChanged: (StatusPrijave? newValue) {
                  setState(() {
                    selectedStatusPrijave = newValue;
                  });
                },
                items: statusResult?.result.map((StatusPrijave status) {
                      return DropdownMenuItem<StatusPrijave>(
                        value: status,
                        child: Text(status.naziv ?? ''),
                      );
                    }).toList() ??
                    [],
              ),
            ),
          ),
          SizedBox(width: 30.0),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: ElevatedButton(
              onPressed: () async {
                await _fetchData();
              },
              child: Text("Filtriraj"),
            ),
          ),
          SizedBox(width: 20.0), 
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: ElevatedButton(
              onPressed: () {
                // Clear filters logic
                _imeController.clear();
                _brojIndeksaController.clear();
                setState(() {
                  selectedStatusPrijave = null;
                });
                _fetchData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 240, 92, 92),
                foregroundColor: Colors.white,
              ),
              child: Text("Očisti filtere"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(100, 30, 100, 0),
                child: IntrinsicWidth(
                  stepWidth: double.infinity,
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
                              'Naziv smještaja',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Smještajna jedinica',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Status',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Akcije',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                      rows: result?.result
                              .map((Rezervacije e) => DataRow(cells: [
                                    DataCell(Center(
                                        child: Text(
                                      e.student?.brojIndeksa ?? "",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))),
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
                                        child: Text(e.smjestaj?.naziv ?? ""))),
                                    DataCell(Center(
                                        child: Text(
                                            e.smjestajnaJedinica?.naziv ??
                                                ""))),
                                    DataCell(Center(
                                        child: Text(e.status?.naziv ?? ""))),
                                    DataCell(
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      RezervacijeDetailsDialog(
                                                        title: 'Rezervacija',
                                                        rezervacija: e,
                                                      )).then((value) {
                                                if (value != null && value) {
                                                  _fetchData();
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]))
                              .toList() ??
                          []),
                ))));
  }
}
