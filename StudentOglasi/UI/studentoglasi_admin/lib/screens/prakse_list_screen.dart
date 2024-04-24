// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Oglas/oglas.dart';
import 'package:studentoglasi_admin/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/models/StatusOglasi/statusoglasi.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/oglasi_provider.dart';
import 'package:studentoglasi_admin/providers/organizacije_provider.dart';
import 'package:studentoglasi_admin/providers/prakse_provider.dart';
import 'package:studentoglasi_admin/providers/statusoglasi_provider.dart';
import 'package:studentoglasi_admin/screens/components/praksa_details_dialog.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

class PrakseListScreen extends StatefulWidget {
  const PrakseListScreen({super.key});

  @override
  State<PrakseListScreen> createState() => _PrakseListScreenState();
}

class _PrakseListScreenState extends State<PrakseListScreen> {
  late PraksaProvider _prakseProvider;
  late StatusOglasiProvider _statusProvider;
  late OrganizacijeProvider _organizacijeProvider;
  late OglasiProvider _oglasiProvider;
  Organizacije? selectedOrganizacije;
  StatusOglasi? selectedStatusOglasi;
  SearchResult<Organizacije>? organizacijeResult;
  SearchResult<StatusOglasi>? statusResult;
  SearchResult<Oglas>? oglasiResult;
  SearchResult<Praksa>? result;
  TextEditingController _naslovController = new TextEditingController();
  TextEditingController _organizacijaController = new TextEditingController();
  TextEditingController _statusController = new TextEditingController();

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   _prakseProvider = context.read<PraksaProvider>();

  //   _fetchData();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prakseProvider = context.read<PraksaProvider>();
    _statusProvider = context.read<StatusOglasiProvider>();
    _organizacijeProvider = context.read<OrganizacijeProvider>();
    _oglasiProvider = context.read<OglasiProvider>();
    _fetchData();
    _fetchOglasi();
    _fetchStatusOglasi();
    _fetchOrganizacije();
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
 
  void _fetchOrganizacije() async {
    var organizacijeData = await _organizacijeProvider.get();
    setState(() {
      organizacijeResult = organizacijeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title: "Prakse",
      addButtonLabel: "Dodaj praksu",
       onAddButtonPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => PraksaDetailsDialog(
                  praksa: null,
                   statusResult: statusResult,
                   organizacijeResult: organizacijeResult,
                   oglasiResult:oglasiResult
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
        SizedBox(width: 30.0),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: DropdownButton2<StatusOglasi>(
                isExpanded: true,
                hint: Text(
                  'Status oglasa',
                ),
                value: selectedStatusOglasi,
                onChanged: (StatusOglasi? newValue) {
                  setState(() {
                    selectedStatusOglasi = newValue;
                  });
                },
                items: statusResult?.result.map((StatusOglasi status) {
                      return DropdownMenuItem<StatusOglasi>(
                        value: status,
                        child: Text(status.naziv ?? ''),
                      );
                    }).toList() ??
                    [],
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: DropdownButton2<Organizacije>(
                isExpanded: true,
                hint: Text(
                  'Organizacija',
                ),
                value: selectedOrganizacije,
                onChanged: (Organizacije? newValue) {
                  setState(() {
                    selectedOrganizacije = newValue;
                  });
                },
                items: organizacijeResult?.result.map((Organizacije organizacija) {
                      return DropdownMenuItem<Organizacije>(
                        value: organizacija,
                        child: Text(organizacija.naziv ?? ''),
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              PraksaDetailsDialog(
                                                praksa: e,
                                                statusResult: statusResult,
                                                organizacijeResult: organizacijeResult,
                                                oglasiResult:oglasiResult
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
