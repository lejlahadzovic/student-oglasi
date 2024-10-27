// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Oglas/oglas.dart';
import 'package:studentoglasi_admin/models/StatusOglasi/statusoglasi.dart';
import 'package:studentoglasi_admin/models/Stipendija/stipendija.dart';
import 'package:studentoglasi_admin/models/Stipenditor/stipenditor.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/oglasi_provider.dart';
import 'package:studentoglasi_admin/providers/statusoglasi_provider.dart';
import 'package:studentoglasi_admin/providers/stipendije_provider.dart';
import 'package:studentoglasi_admin/screens/components/costum_paginator.dart';
import 'package:studentoglasi_admin/utils/util.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

import '../providers/stipenditori_provider.dart';
import 'components/stipendije_details_dialog.dart';

class StipendijeListScreen extends StatefulWidget {
  const StipendijeListScreen({super.key});

  @override
  State<StipendijeListScreen> createState() => _StipendijeListScreenState();
}

class _StipendijeListScreenState extends State<StipendijeListScreen> {
  late StipendijeProvider _stipendijeProvider;
  late StatusOglasiProvider _statusProvider;
  late StipenditoriProvider _stipenditorProvider;
  late OglasiProvider _oglasiProvider;
  Stipenditor? selectedStipenditor;
  SearchResult<Stipendije>? result;
  SearchResult<Stipenditor>? stipenditoriResult;
  SearchResult<StatusOglasi>? statusResult;
  SearchResult<Oglas>? oglasiResult;
  TextEditingController _naslovController = new TextEditingController();
  int _currentPage = 0;
  int _totalItems = 0;
  late NumberPaginatorController _pageController;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _stipendijeProvider = context.read<StipendijeProvider>();
    _oglasiProvider = context.read<OglasiProvider>();
    _statusProvider = context.read<StatusOglasiProvider>();
    _stipenditorProvider = context.read<StipenditoriProvider>();
    _pageController = NumberPaginatorController();
    _fetchData();
    _fetchOglasi();
    _fetchStatusOglasi();
    _fetchStipenditori();
  }

  void _fetchStatusOglasi() async {
    var statusData = await _statusProvider.get();
    setState(() {
      statusResult = statusData;
    });
  }

  void _fetchOglasi() async {
    var oglasData = await _oglasiProvider.get();
    setState(() {
      oglasiResult = oglasData;
    });
  }

  void _fetchStipenditori() async {
    var stipenditoriData = await _stipenditorProvider.get();
    setState(() {
      stipenditoriResult = stipenditoriData;
    });
  }

  @override
  Widget build(BuildContext context) {
    int numberPages = calculateNumberPages(_totalItems, 5);
    return MasterScreenWidget(
      title: "Stipendije",
      addButtonLabel: "Dodaj stipendiju",
      onAddButtonPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => StipendijeDetailsDialog(
                stipendija: null,
                statusResult: statusResult,
                stipenditoriResult: stipenditoriResult,
                oglasiResult: oglasiResult)).then((value) {
          if (value != null && value) {
            _fetchData();
          }
        });
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
    print("login proceed");
    // Navigator.of(context).pop();

    var data = await _stipendijeProvider.get(filter: {
      'naslov': _naslovController.text,
      'stipenditor': selectedStipenditor?.id,
      'page': _currentPage + 1, // pages are 1-indexed in the backend
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
    print("data: ${data.result[0].id}");
  }

  int calculateNumberPages(int totalItems, int pageSize) {
    return (totalItems / pageSize).ceil();
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
                  decoration: InputDecoration(labelText: "Naziv stipendije"),
                  controller: _naslovController,
                ),
              ),
            ),
            SizedBox(width: 30.0),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: DropdownButton2<Stipenditor>(
                  isExpanded: true,
                  hint: Text(
                    'Stipenditor',
                  ),
                  value: selectedStipenditor,
                  onChanged: (Stipenditor? newValue) {
                    setState(() {
                      selectedStipenditor = newValue;
                    });
                  },
                  items:
                      stipenditoriResult?.result.map((Stipenditor stipenditor) {
                            return DropdownMenuItem<Stipenditor>(
                              value: stipenditor,
                              child: Text(stipenditor.naziv ?? ''),
                            );
                          }).toList() ??
                          [],
                ),
              ),
            ),
            SizedBox(height: 8, width: 30.0),
            ElevatedButton(
                onPressed: () async {
                  await _fetchData();
                },
                child: Text("Filtriraj"))
          ],
        ));
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
                              'Naslov',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Iznos',
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
                              'Izvor',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Nivo obrazovanja',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Broj stipendista',
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
                              .map((Stipendije e) => DataRow(cells: [
                                    DataCell(Center(
                                        child: Text(
                                            e.idNavigation?.naslov ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                    DataCell(Center(
                                        child: Text(
                                            '${formatNumber(e.iznos)} KM'))),
                                    DataCell(Center(
                                        child: Text(e.status?.naziv ?? ""))),
                                    DataCell(
                                        Center(child: Text(e.izvor ?? ""))),
                                    DataCell(Center(
                                        child: Text(e.nivoObrazovanja ?? ""))),
                                    DataCell(Center(
                                        child: Text(
                                            formatNumber(e.brojStipendisata)))),
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
                                                      StipendijeDetailsDialog(
                                                          stipendija: e,
                                                          statusResult:
                                                              statusResult,
                                                          stipenditoriResult:
                                                              stipenditoriResult,
                                                          oglasiResult:
                                                              oglasiResult)).then(
                                                  (value) {
                                                if (value != null && value) {
                                                  _fetchData();
                                                }
                                              });
                                            },
                                          ),
                                         IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      bool confirmDelete = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Potvrda brisanja"),
                                                IconButton(
                                                  icon: Icon(Icons.close),
                                                  onPressed: () {
                                                    Navigator.of(context).pop(
                                                        false); 
                                                  },
                                                ),
                                              ],
                                            ),
                                            content: Text(
                                                "Da li ste sigurni da želite izbrisati?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(
                                                      false); 
                                                },
                                                child: Text("Ne"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(
                                                      true);  
                                                },
                                                child: Text("Da"),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      if (confirmDelete == true) {
                                        await _stipendijeProvider.delete(e.id);
                                        await _fetchData();
                                      }
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
