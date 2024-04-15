// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Kategorija/kategorija.dart';
import 'package:studentoglasi_admin/models/Objava/objava.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/kategorije_provider.dart';
import 'package:studentoglasi_admin/providers/objave_provider.dart';
import 'package:studentoglasi_admin/screens/components/objave_details_dialog.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';
import 'package:intl/intl.dart';

class ObjaveListScreen extends StatefulWidget {
  const ObjaveListScreen({super.key});

  @override
  State<ObjaveListScreen> createState() => _ObjaveListScreenState();
}

class _ObjaveListScreenState extends State<ObjaveListScreen> {
  late ObjaveProvider _objaveProvider;
  late KategorijaProvider _kategorijeProvider;
  Kategorija? selectedKategorija;
  SearchResult<Objava>? result;
  SearchResult<Kategorija>? kategorijeResult;
  TextEditingController _naslovController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _objaveProvider = context.read<ObjaveProvider>();
    _kategorijeProvider = context.read<KategorijaProvider>();
    _fetchData();
    _fetchKategorije();
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   _objaveProvider = context.read<ObjaveProvider>();
  // }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      //title_widget: Text("Novosti"),
      title: "Novosti",
      addButtonLabel: "Dodaj objavu",
      onAddButtonPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => ObjaveDetailsDialog(
                  objava: null,
                  kategorijeResult: kategorijeResult,
                )).then((value) {
          if (value != null && value) {
            _fetchData();
          }
        });
      },
      child: Container(
        child: Column(
          children: [_buildSearch(), _buildDataListView()],
        ),
      ),
    );
  }

  Future<void> _fetchData() async {
    var data = await _objaveProvider.get(filter: {
      'naslov': _naslovController.text,
      'kategorijaID': selectedKategorija?.id
    });
    setState(() {
      result = data;
    });
  }

  void _fetchKategorije() async {
    var kategorijeData = await _kategorijeProvider.get();
    setState(() {
      kategorijeResult = kategorijeData;
    });
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Naslov",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
                controller: _naslovController,
              ),
            ),
          ),
          SizedBox(width: 30.0),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: DropdownButton2<Kategorija>(
                isExpanded: true,
                hint: Text(
                  'Kategorija',
                ),
                value: selectedKategorija,
                onChanged: (Kategorija? newValue) {
                  setState(() {
                    selectedKategorija = newValue;
                  });
                },
                items: kategorijeResult?.result.map((Kategorija kategorija) {
                      return DropdownMenuItem<Kategorija>(
                        value: kategorija,
                        child: Text(kategorija.naziv ?? ''),
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
                    child: Text('Naslov',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Datum objave',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Kategorija',
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
                      .map((Objava e) => DataRow(cells: [
                            DataCell(Center(
                                child: Text(
                              e.naslov ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                            DataCell(Center(
                                child: Text(e.vrijemeObjave != null
                                    ? DateFormat('dd.MM.yyyy')
                                        .format(e.vrijemeObjave!)
                                    : ''))),
                            DataCell(
                                Center(child: Text(e.kategorija?.naziv ?? ""))),
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
                                              ObjaveDetailsDialog(
                                                objava: e,
                                                kategorijeResult:
                                                    kategorijeResult,
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
                                      await _objaveProvider.delete(e.id);
                                      await _fetchData();
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
