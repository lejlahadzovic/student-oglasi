  import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/PrijavePraksa/prijave_praksa.dart';
import 'package:studentoglasi_admin/models/Student/student.dart';
import 'package:studentoglasi_admin/providers/prijavepraksa_provider.dart';
import 'package:studentoglasi_admin/providers/statusprijave_provider.dart';
import 'package:studentoglasi_admin/providers/studenti_provider.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

import '../models/StatusPrijave/statusprijave.dart';
import '../models/search_result.dart';

class PrijavePraksaListScreen extends StatefulWidget {
  const PrijavePraksaListScreen({super.key});

  @override
  State<PrijavePraksaListScreen> createState() => _PrijavePraksaListScreen();
}

class _PrijavePraksaListScreen extends State<PrijavePraksaListScreen> {
  late PrijavePraksaProvider _prijavePraksaProvider;
  late StatusPrijaveProvider _statusProvider;
  late StudentiProvider _studentProvider;
    SearchResult<PrijavePraksa>? result;
  SearchResult<StatusPrijave>? statusResult;
  SearchResult<Student>? studentResult;
  StatusPrijave? selectedStatusPrijave;
  TextEditingController _statusController = new TextEditingController();
  TextEditingController _brojIndeksaController = new TextEditingController();
  TextEditingController _imeController = new TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prijavePraksaProvider = context.read<PrijavePraksaProvider>();
    _statusProvider = context.read<StatusPrijaveProvider>();
    _studentProvider = context.read<StudentiProvider>();
       _fetchData();
    _fetchStatusPrijave();
    _fetchStudenti();
  }

   @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Prijave praksa",
      child: Container(
        child: Column(
          children: [ _buildSearch(),_buildDataListView()],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    print("login proceed");
    // Navigator.of(context).pop();

    var data = await _prijavePraksaProvider.get(filter: {
      'ime': _imeController.text,
      'brojIndeksa': _brojIndeksaController.text,
      'status': _statusController.text,
    });
    setState(() {
      result = data;
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
                  hint: Text(
                    'Status prijave',
                  ),
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
            ElevatedButton(
                onPressed: () async {
                  await _fetchData();
                },
                child: Text("Filtriraj")),
            SizedBox(
              height: 8,
            ),
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
                              'Ime i prezime',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
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
                              'Certifikati',
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
                              'Naziv prakse',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                      rows: result?.result
                              .map((PrijavePraksa e) => DataRow(cells: [
                                    DataCell(Center(
                                        child: Text(
                                            "${e.student?.idNavigation.ime?? ""}  ${e.student?.idNavigation.prezime?? ""}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)))),
                                    DataCell(Center(
                                        child: Text(e.student?.brojIndeksa?? ""))),
                                    DataCell(Center(
                                        child: Text(e.certifikati ?? ""))),
                                    DataCell(Center(
                                        child: Text(e.status?.naziv ?? ""))),
                                    DataCell(Center(
                                        child:
                                            Text(e.praksa?.idNavigation?.naslov?? ""))),
                                    /* DataCell(
                                     Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          
                                          
                                        ],
                                      ),
                                    ),*/
                                  ]))
                              .toList() ??
                          []),
                ))));
  }
}