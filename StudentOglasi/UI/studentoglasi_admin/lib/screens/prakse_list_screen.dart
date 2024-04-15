// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/prakse_provider.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

class PrakseListScreen extends StatefulWidget {
  const PrakseListScreen({super.key});

  @override
  State<PrakseListScreen> createState() => _PrakseListScreenState();
}

class _PrakseListScreenState extends State<PrakseListScreen> {
  late PraksaProvider _prakseProvider;
  SearchResult<Praksa>? result;
  TextEditingController _naslovController = new TextEditingController();
  TextEditingController _organizacijaController = new TextEditingController();
  TextEditingController _statusController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _prakseProvider = context.read<PraksaProvider>();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Prakse",
      addButtonLabel: "Dodaj praksu",
      onAddButtonPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text("Test"),
                  content: Text("Prakse klasa"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"))
                  ],
                ));
      },
      child: Container(
        child: Column(
          children: [_buildSearch(), _buildDataListView()],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    print("login proceed");
    // Navigator.of(context).pop();

    var data = await _prakseProvider.get(filter: {
      'naslov': _naslovController.text,
      'organizacija': _organizacijaController.text,
      'status': _statusController.text,
    });
    setState(() {
      result = data;
    });
    print("data: ${data.result[0].idNavigation?.naslov}");
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
              decoration: InputDecoration(labelText: "Naziv"),
              controller: _naslovController,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Organizacija"),
              controller: _organizacijaController,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Status"),
              controller: _statusController,
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
                              'Naslov',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Početak prakse',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const DataColumn(
                          label: Expanded(
                            child: Text(
                              'Kvalifikacije',
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
                              'Organizacija',
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
                              .map((Praksa e) => DataRow(cells: [
                                    DataCell(Center(
                                        child: Text(
                                            e.idNavigation?.naslov ?? "", style: TextStyle(fontWeight: FontWeight.bold)))),
                                    DataCell(Center(
                                        child: Text(e.pocetakPrakse != null
                                            ? DateFormat('dd.MM.yyyy')
                                                .format(e.pocetakPrakse!)
                                            : ''))),
                                    DataCell(Center(
                                        child: Text(e.kvalifikacije ?? ""))),
                                    DataCell(Center(
                                        child: Text(e.status?.naziv ?? ""))),
                                    DataCell(Center(
                                        child:
                                            Text(e.organizacija?.naziv ?? ""))),
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
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () async {
                                              await _prakseProvider.delete(e.id);
                                              await _fetchData();
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
