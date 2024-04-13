// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Prakse"),
      child: Container(
        child: Column(
          children: [_buildSearch(), _buildDataListView()],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Row(
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
        ), Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Organizacija"),
              controller: _organizacijaController,
            ),
          ),
        ), Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Status"),
              controller: _statusController,
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              print("login proceed");
              // Navigator.of(context).pop();

              var data = await _prakseProvider
                  .get(filter: 
                  {'naslov': _naslovController.text,
                  'organizacija':_organizacijaController.text,
                  'status':_statusController.text,
                  });
              setState(() {
                result = data;
              });
              print("data: ${data.result[0].idNavigation?.naslov}");
            },
            child: Text("Pretraga")),
             SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: [
            const DataColumn(
              label: Expanded(
                child: Text(
                  'ID',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Naslov',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Opis',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Benifiti',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
               const DataColumn(
              label: Expanded(
                child: Text(
                  'Početak prakse',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
               const DataColumn(
              label: Expanded(
                child: Text(
                  'Kvalifikacije',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Status',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Organizacija',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
                        const DataColumn(
              label: Expanded(
                child: Text(
                  'Akcije',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],

          rows: result?.result
                  .map((Praksa e) => DataRow(cells: [
                        DataCell(Text(e.id?.toString() ?? "")),
                         DataCell(Text(e.idNavigation?.naslov??"")),
                         DataCell(Text(e.idNavigation?.opis??"")),
                        DataCell(Text(e.benefiti ?? "")),
                        DataCell(Text(e.pocetakPrakse.toString())),
                        DataCell(Text(e.kvalifikacije ?? "")),
                        DataCell(Text(e.status?.naziv ?? "")),
                        DataCell(Text(e.organizacija?.naziv ?? "")),
                         DataCell( IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _prakseProvider.delete(e.id),
            )),
                      ]))
                  .toList() ??
              []),
    ));
  }
}