import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Fakultet/fakultet.dart';
import 'package:studentoglasi_admin/models/NacinStudiranja/nacin_studiranja.dart';
import 'package:studentoglasi_admin/models/Student/student.dart';
import 'package:studentoglasi_admin/models/Univerzitet/univerzitet.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/fakulteti_provider.dart';
import 'package:studentoglasi_admin/providers/nacin_studiranja_provider.dart';
import 'package:studentoglasi_admin/providers/studenti_provider.dart';
import 'package:studentoglasi_admin/providers/univerziteti_provider.dart';
import 'package:studentoglasi_admin/screens/components/StudentDialogs/student_insert_dialog.dart';
import 'package:studentoglasi_admin/screens/components/StudentDialogs/student_update_dialog.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

import 'components/costum_paginator.dart';

class StudentiListScreen extends StatefulWidget {
  const StudentiListScreen({super.key});

  @override
  State<StudentiListScreen> createState() => _StudentiListScreenState();
}

class _StudentiListScreenState extends State<StudentiListScreen> {
  late StudentiProvider _studentiProvider;
  late FakultetiProvider _fakultetiProvider;
  late UniverzitetiProvider _univerzitetiProvider;
  late NacinStudiranjaProvider _nacinStudiranjaProvider;
  Fakultet? selectedFakultet;
  SearchResult<Student>? result;
  SearchResult<Fakultet>? fakultetiResult;
  SearchResult<Univerzitet>? univerzitetiResult;
  SearchResult<NacinStudiranja>? naciniStudiranjaResult;
  TextEditingController _brojIndeksaController = new TextEditingController();
  TextEditingController _imePrezimeController = new TextEditingController();
  int _currentPage = 0;
  int _totalItems = 0;
  late NumberPaginatorController _pageController;
  final List<int> godine = [1, 2, 3, 4];
  int? selectedGodina;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _studentiProvider = context.read<StudentiProvider>();
    _fakultetiProvider = context.read<FakultetiProvider>();
    _univerzitetiProvider = context.read<UniverzitetiProvider>();
    _nacinStudiranjaProvider = context.read<NacinStudiranjaProvider>();
    _pageController = NumberPaginatorController();
    _fetchData();
    _fetchFakulteti();
    _fetchUniverziteti();
    _fetchNacinStudiranja();
  }

  Future<void> _fetchData() async {
    var data = await _studentiProvider.get(filter: {
      'brojIndeksa': _brojIndeksaController.text,
      'imePrezime': _imePrezimeController.text,
      'fakultetID': selectedFakultet?.id,
      'godinaStudija': selectedGodina,
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

  int calculateNumberPages(int totalItems, int pageSize) {
    return (totalItems / pageSize).ceil();
  }

  void _fetchFakulteti() async {
    var fakultetiData = await _fakultetiProvider.get();
    setState(() {
      fakultetiResult = fakultetiData;
    });
  }

  Future<void> _fetchUniverziteti() async {
    var univerzitetiData = await _univerzitetiProvider.get();
    setState(() {
      univerzitetiResult = univerzitetiData;
    });
  }

  Future<void> _fetchNacinStudiranja() async {
    var naciniStudiranjaData = await _nacinStudiranjaProvider.get();
    setState(() {
      naciniStudiranjaResult = naciniStudiranjaData;
    });
  }

  @override
  Widget build(BuildContext context) {
    int numberPages = calculateNumberPages(_totalItems, 5);
    return MasterScreenWidget(
      title: "Studenti",
      addButtonLabel: "Dodaj studenta",
      onAddButtonPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => StudentInsertDialog(
                  student: null,
                  univerzitetiResult: univerzitetiResult,
                  naciniStudiranjaResult: naciniStudiranjaResult,
                )).then((value) {
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

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Broj indeksa",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                controller: _brojIndeksaController,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Ime i prezime",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                controller: _imePrezimeController,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: DropdownButton2<Fakultet>(
                isExpanded: true,
                hint: Text(
                  'Fakultet',
                ),
                value: selectedFakultet,
                onChanged: (Fakultet? newValue) {
                  setState(() {
                    selectedFakultet = newValue;
                  });
                },
                items: fakultetiResult?.result.map((Fakultet fakultet) {
                      return DropdownMenuItem<Fakultet>(
                        value: fakultet,
                        child: Text(fakultet.naziv ?? ''),
                      );
                    }).toList() ??
                    [],
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: DropdownButton2<int>(
                isExpanded: true,
                hint: Text(
                  'Godina studija',
                ),
                value: selectedGodina,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedGodina = newValue;
                  });
                },
                items: godine.map((godina) {
                  return DropdownMenuItem<int>(
                    value: godina,
                    child: Text('$godina. godina'),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: ElevatedButton(
                onPressed: () async {
                  await _fetchData();
                },
                child: Text("Filtriraj")),
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
                    child: Text('Broj indeksa',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Ime i prezime',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Fakultet',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Godina studija',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Status studenta',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Akcije',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
              ],
              rows: result?.result
                      .map((Student e) => DataRow(cells: [
                            DataCell(Center(
                                child: Text(
                              e.brojIndeksa ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                            DataCell(Center(
                                child: Text(
                                    '${e.idNavigation?.ime} ${e.idNavigation?.prezime}'))),
                            DataCell(
                                Center(child: Text(e.fakultet?.naziv ?? ""))),
                            DataCell(Center(
                                child: Text('${e.godinaStudija}. godina'))),
                            DataCell(
                              Center(
                                child: Text(
                                  e.status != null
                                      ? (e.status! ? 'Aktivan' : 'Neaktivan')
                                      : '',
                                ),
                              ),
                            ),
                            DataCell(
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              StudentUpdateDialog(
                                                student: e,
                                                univerzitetiResult:
                                                    univerzitetiResult,
                                                naciniStudiranjaResult:
                                                    naciniStudiranjaResult,
                                              )).then((value) {
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
                                        await _studentiProvider.delete(e.id);
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
        ),
      ),
    ));
  }
}
