import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Grad/grad.dart';
import 'package:studentoglasi_admin/models/Smjestaj/smjestaj.dart';
import 'package:studentoglasi_admin/models/TipSmjestaja/tip_smjestaja.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/gradovi_provider.dart';
import 'package:studentoglasi_admin/providers/smjestaji_provider.dart';
import 'package:studentoglasi_admin/providers/tip_smjestaja_provider.dart';
import 'package:studentoglasi_admin/screens/components/costum_paginator.dart';
import 'package:studentoglasi_admin/screens/components/smjestaj_details_dialog.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

class SmjestajiListScreen extends StatefulWidget {
  const SmjestajiListScreen({super.key});

  @override
  State<SmjestajiListScreen> createState() => _SmjestajiListScreenState();
}

class _SmjestajiListScreenState extends State<SmjestajiListScreen> {
  late SmjestajiProvider _smjestajiProvider;
  late GradoviProvider _gradoviProvider;
  late TipSmjestajaProvider _tipSmjestajaProvider;
  SearchResult<Smjestaj>? result;
  SearchResult<Grad>? gradoviResult;
  SearchResult<TipSmjestaja>? tipoviSmjestajaResult;
  TextEditingController _nazivController = new TextEditingController();
  Grad? selectedGrad;
  TipSmjestaja? selectedTipSmjestaja;
   int _currentPage = 0;
  int _totalItems = 0;
  late NumberPaginatorController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _smjestajiProvider = context.read<SmjestajiProvider>();
    _gradoviProvider = context.read<GradoviProvider>();
    _tipSmjestajaProvider = context.read<TipSmjestajaProvider>();
    _pageController = NumberPaginatorController(); _fetchData();
    _fetchGradovi();
    _fetchTipoviSmjestaja();
  }

  Future<void> _fetchData() async {
    var data = await _smjestajiProvider.get(filter: {
      'naziv': _nazivController.text,
      'gradID': selectedGrad?.id,
      'tipSmjestajaID': selectedTipSmjestaja?.id,
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

  Future<void> _fetchGradovi() async {
    var data = await _gradoviProvider.get();
    setState(() {
      gradoviResult = data;
    });
  }

   Future<void> _fetchTipoviSmjestaja() async {
    var data = await _tipSmjestajaProvider.get();
    setState(() {
      tipoviSmjestajaResult = data;
    });
  }

  int calculateNumberPages(int totalItems, int pageSize) {
    return (totalItems / pageSize).ceil();
  }
  
  @override
  Widget build(BuildContext context) {
    int numberPages = calculateNumberPages(_totalItems, 5);
    return MasterScreenWidget(
      title: 'Smještaji',
      addButtonLabel: 'Dodaj smještaj',
      onAddButtonPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => SmjestajDetailsDialog(
                  gradoviResult: gradoviResult,
                  tipoviSmjestajaResult: tipoviSmjestajaResult,
                  title: 'Dodaj smještaj',
                )).then((value) {
          if (value != null && value) {
            _fetchData();
          }
        });
      },
      child: Container(
        child: Column(
          children: [_buildSearch(), _buildDataListView(), if(_currentPage>=0 && numberPages-1>=_currentPage)
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
                    ),],
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
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(labelText: "Naziv"),
                  controller: _nazivController,
                ),
              ),
            ),
            SizedBox(width: 30.0),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: DropdownButton2<Grad>(
                  isExpanded: true,
                  hint: Text(
                    'Grad',
                  ),
                  value: selectedGrad,
                  onChanged: (Grad? newValue) {
                    setState(() {
                      selectedGrad = newValue;
                    });
                  },
                  items: gradoviResult?.result.map((Grad status) {
                        return DropdownMenuItem<Grad>(
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
                child: DropdownButton2<TipSmjestaja>(
                  isExpanded: true,
                  hint: Text(
                    'Tip smještaja',
                  ),
                  value: selectedTipSmjestaja,
                  onChanged: (TipSmjestaja? newValue) {
                    setState(() {
                      selectedTipSmjestaja = newValue;
                    });
                  },
                  items: tipoviSmjestajaResult?.result
                          .map((TipSmjestaja organizacija) {
                        return DropdownMenuItem<TipSmjestaja>(
                          value: organizacija,
                          child: Text(organizacija.naziv ?? ''),
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
                    child: Text('Naziv',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Lokacija',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Adresa',
                        style: TextStyle(fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                  ),
                ),
                const DataColumn(
                  label: Expanded(
                    child: Text('Tip smještaja',
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
                      .map((Smjestaj e) => DataRow(cells: [
                            DataCell(Center(
                                child: Text(
                              e.naziv ?? "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                            DataCell(Center(child: Text(e.grad?.naziv ?? ""))),
                            DataCell(Center(child: Text(e.adresa ?? ""))),
                            DataCell(Center(child: Text(e.tipSmjestaja?.naziv ?? ""))),
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
                                              SmjestajDetailsDialog(
                                                gradoviResult: gradoviResult,
                                                tipoviSmjestajaResult: tipoviSmjestajaResult,
                                                smjestaj: e,
                                                title: 'Detalji smještaja',
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
                                      await _smjestajiProvider.delete(e.id);
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
