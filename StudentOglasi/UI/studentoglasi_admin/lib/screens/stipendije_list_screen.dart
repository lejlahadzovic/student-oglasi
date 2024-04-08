// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Stipendija/stipendija.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/stipendije_provider.dart';
import 'package:studentoglasi_admin/utils/util.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

class StipendijeListScreen extends StatefulWidget {
  const StipendijeListScreen({super.key});

  @override
  State<StipendijeListScreen> createState() => _StipendijeListScreenState();
}

class _StipendijeListScreenState extends State<StipendijeListScreen> {
  late StipendijeProvider _stipendijeProvider;
  SearchResult<Stipendije>? result;
  TextEditingController _naslovController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _stipendijeProvider = context.read<StipendijeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Stipendije"),
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
              decoration: InputDecoration(labelText: "Naziv stipendije"),
              controller: _naslovController,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ElevatedButton(
            onPressed: () async {
              print("login proceed");
              // Navigator.of(context).pop();

              var data = await _stipendijeProvider
                  .get(filter: {'naslov': _naslovController.text});
              setState(() {
                result = data;
              });
              print("data: ${data.result[0].id}");
            },
            child: Text("Pretraga"))
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
                  'Uslovi',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
               const DataColumn(
              label: Expanded(
                child: Text(
                  'Iznos',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
               const DataColumn(
              label: Expanded(
                child: Text(
                  'Kriterij',
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
                  'Potrebna dokumentacija',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Izvor',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Nivo obrazovanja',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Broj stipendista',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
          rows: result?.result
                  .map((Stipendije e) => DataRow(cells: [
                        DataCell(Text(e.id?.toString() ?? "")),
                        DataCell(Text(e.idNavigation?.naslov ?? "")),
                        DataCell(Text(e.idNavigation?.opis ?? "")),
                         DataCell(Text(e.uslovi??"")),
                         DataCell(Text(formatNumber(e.iznos))),
                        DataCell(Text(formatNumber(e.kriterij))),
                        DataCell(Text(e.status?.naziv ?? "")),
                        DataCell(Text(e.potrebnaDokumentacija?? "")),
                        DataCell(Text(e.izvor ?? "")),
                        DataCell(Text(e.nivoObrazovanja ?? "")),
                        DataCell(Text(formatNumber(e.brojStipendisata))),
                        DataCell( IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _stipendijeProvider.delete(e.id),
               )),
                    ]))
                  .toList() ??
              []),
    ));
  }
}

