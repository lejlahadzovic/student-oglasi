import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/PrijaveStipendija/prijave_stipendija.dart';
import 'package:studentoglasi_admin/models/StatusPrijave/statusprijave.dart';
import 'package:studentoglasi_admin/models/Stipendija/stipendija.dart';
import 'package:studentoglasi_admin/models/Student/student.dart';
import 'package:studentoglasi_admin/providers/prijavestipendija_provider.dart';
import 'package:studentoglasi_admin/providers/statusprijave_provider.dart';
import 'package:studentoglasi_admin/providers/stipendije_provider.dart';
import 'package:studentoglasi_admin/providers/studenti_provider.dart';
import 'package:studentoglasi_admin/screens/components/costum_paginator.dart';
import 'package:studentoglasi_admin/screens/components/prijave_stipendija_details_dialog.dart';
import 'package:studentoglasi_admin/screens/components/prijave_stipendije_report_dialog.dart';
import 'package:studentoglasi_admin/utils/file_downloader.dart';
import 'package:studentoglasi_admin/utils/util.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

import '../models/search_result.dart';

class PrijaveStipendijaListScreen extends StatefulWidget {
  const PrijaveStipendijaListScreen({super.key});

  @override
  State<PrijaveStipendijaListScreen> createState() =>
      _PrijaveStipendijaListScreen();
}

class _PrijaveStipendijaListScreen extends State<PrijaveStipendijaListScreen> {
  late PrijaveStipendijaProvider _prijaveStipendijaProvider;
  late StatusPrijaveProvider _statusProvider;
  late StudentiProvider _studentProvider;
  late StipendijeProvider _stipendijaProvider;
  SearchResult<PrijaveStipendija>? result;
  SearchResult<StatusPrijave>? statusResult;
  SearchResult<Student>? studentResult;
  SearchResult<Stipendije>? stipendijaResult;
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
    _prijaveStipendijaProvider = context.read<PrijaveStipendijaProvider>();
    _statusProvider = context.read<StatusPrijaveProvider>();
    _studentProvider = context.read<StudentiProvider>();
    _stipendijaProvider = context.read<StipendijeProvider>();
    _pageController = NumberPaginatorController();
    _fetchData();
    _fetchStatusPrijave();
    _fetchStudenti();
    _fetchStipendije();
  }

  @override
  Widget build(BuildContext context) {
    int numberPages = calculateNumberPages(_totalItems, 5);
    return MasterScreenWidget(
      title: "Prijave stipendija",
      addButtonLabel: 'Generiši izvještaj',
      addButtonIcon: Icons.description,
      onAddButtonPressed: () async {
        if (stipendijaResult != null) {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return PrijaveStipendijeReportDialog(
                stipendije: stipendijaResult!.result,
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
    print("login proceed");
    // Navigator.of(context).pop();

    var data = await _prijaveStipendijaProvider.get(filter: {
      'ime': _imeController.text,
      'brojIndeksa': _brojIndeksaController.text,
      'status': selectedStatusPrijave?.id,
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
  }

  int calculateNumberPages(int totalItems, int pageSize) {
    return (totalItems / pageSize).ceil();
  }

  void _fetchStatusPrijave() async {
    var statusData = await _statusProvider.get();
    setState(() {
      statusResult = statusData;
    });
  }

  void _fetchStipendije() async {
    var stipendijeData = await _stipendijaProvider.get();
    setState(() {
      stipendijaResult = stipendijeData;
    });
  }

  void _fetchStudenti() async {
    var studentData = await _studentProvider.get();
    setState(() {
      studentResult = studentData;
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
                        child: Text(status.naziv ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14)),
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
                _imeController.clear();
                _brojIndeksaController.clear();
                setState(() {
                  selectedStatusPrijave = null;
                });
                _fetchData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 240, 92, 92),
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
                      columnSpacing: 15,
                      columns: const [
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Ime i prezime',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Broj indeksa',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Naslov',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Dokumentacija',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Status',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Prosjek ocjena',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        DataColumn(
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
                              .map((PrijaveStipendija e) => DataRow(cells: [
                                    DataCell(Text(
                                        "${e.student?.idNavigation?.ime ?? ""} ${e.student?.idNavigation?.prezime ?? ""}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold))),
                                    DataCell(Center(
                                        child: Text(
                                            e.student?.brojIndeksa ?? ""))),
                                    DataCell(
                                      Center(
                                        child: Text(
                                          (e.stipendija?.idNavigation?.naslov !=
                                                      null &&
                                                  e.stipendija!.idNavigation!
                                                          .naslov!.length >
                                                      30)
                                              ? '${e.stipendija!.idNavigation!.naslov!.substring(0, 30)}...'
                                              : e.stipendija?.idNavigation
                                                      ?.naslov ??
                                                  "",
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      InkWell(
                                        onTap: () {
                                          String fileUrl =
                                              FilePathManager.constructUrl(
                                                  e.dokumentacija ?? '');
                                          String fileName =
                                              e.dokumentacija ?? '';

                                          downloadDocument(
                                              context, fileUrl, fileName);
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Preuzmi dokument",
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(width: 8),
                                            Icon(Icons.download,
                                                color: Colors.blue),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DataCell(Center(
                                        child: Text(e.status?.naziv ?? ""))),
                                    DataCell(Center(
                                        child:
                                            Text(e.prosjekOcjena.toString()))),
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
                                                      PrijavaStipendijaDetailsDialog(
                                                        title:
                                                            'Detalji prijava stipendije',
                                                        prijaveStipendija: e,
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
