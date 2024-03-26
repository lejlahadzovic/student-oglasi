// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Objava/objava.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/objave_provider.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

class ObjaveListScreen extends StatefulWidget {
  const ObjaveListScreen({super.key});

  @override
  State<ObjaveListScreen> createState() => _ObjaveListScreenState();
}

class _ObjaveListScreenState extends State<ObjaveListScreen> {
  late ObjaveProvider _objaveProvider;
  SearchResult<Objava>? result;
  TextEditingController _naslovController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _objaveProvider = context.read<ObjaveProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text("Objave"),
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
          child: TextField(
            decoration: InputDecoration(labelText: "Naslov"),
            controller: _naslovController,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        ElevatedButton(
            onPressed: () async {
              print("login proceed");
              // Navigator.of(context).pop();

              var data = await _objaveProvider
                  .get(filter: {'naslov': _naslovController.text});
              setState(() {
                result = data;
              });
              print("data: ${data.result[0].naslov}");
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
                  'Sadrzaj',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            )
          ],
          rows: result?.result
                  .map((Objava e) => DataRow(cells: [
                        DataCell(Text(e.id?.toString() ?? "")),
                        DataCell(Text(e.naslov ?? "")),
                        DataCell(Text(e.sadrzaj ?? ""))
                      ]))
                  .toList() ??
              []),
    ));
  }
}
