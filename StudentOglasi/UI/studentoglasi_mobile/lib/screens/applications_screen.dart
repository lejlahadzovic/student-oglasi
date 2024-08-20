import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_mobile/models/Praksa/praksa.dart';
import 'package:studentoglasi_mobile/models/PrijavePraksa/prijave_praksa.dart';
import 'package:studentoglasi_mobile/models/StatusOglas/statusoglasi.dart';
import 'package:studentoglasi_mobile/models/StatusPrijave/statusprijave.dart';
import 'package:studentoglasi_mobile/providers/prakse_provider.dart';
import 'package:studentoglasi_mobile/providers/prijavepraksa_provider.dart';
import 'package:studentoglasi_mobile/providers/statusprijave_provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/screens/accommodations_screen.dart';
import 'package:studentoglasi_mobile/screens/main_screen.dart';
import 'package:studentoglasi_mobile/screens/scholarships_screen.dart';
import '../models/search_result.dart';
import '../widgets/menu.dart';

class ApplicationsScreen extends StatefulWidget {
  @override
  _ApplicationsScreenState createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  late PrijavePraksaProvider _prijavePrakseProvider;
  late StatusPrijaveProvider _statusProvider;
  late PraksaProvider _prakseProvider;
  late StudentiProvider _studentiProvider;
  Organizacije? selectedOrganizacije;
  StatusOglasi? selectedStatusOglasi;
  bool _isLoading = true;
  bool _hasError = false;
  List<PrijavePraksa>? prijavePrakseResult;
  SearchResult<StatusPrijave>? statusResult;
  SearchResult<Praksa>? prakseResult;
  
  
  @override
  void initState() {
    super.initState();
    _prijavePrakseProvider = context.read<PrijavePraksaProvider>();
    _statusProvider = context.read<StatusPrijaveProvider>();
    _prakseProvider = context.read<PraksaProvider>();
    _fetchData();
    _fetchPrakse();
    _fetchStatusPrijave();
  }

  void _fetchStatusPrijave() async {
    var statusData = await _statusProvider.get();
    setState(() {
      statusResult = statusData;
    });
  }

  void _fetchPrakse() async {
    var prakseData = await _prakseProvider.get();
    setState(() {
      prakseResult = prakseData;
    });
  }

  Future<void> _fetchData() async {
    try {
    final student = await _studentiProvider.getCurrentStudent();
      var data = await _prijavePrakseProvider.getPrijavePraksaByStudentId(student.id!);
       setState(() {
        prijavePrakseResult = data;
        _isLoading = false;
      });
      print("Data fetched");
      } 
      catch (error) {
      print("Error fetching data");
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _onSearchChanged() {
    setState(() {
      _isLoading = true;
    });
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applications'),
      ),
      drawer: DrawerMenu(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? const Center(child: Text('Failed to load data. Please try again later.'))
              : prijavePrakseResult == null || prijavePrakseResult!.isEmpty
                  ? const Center(child: Text('No data available.'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'ID',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Title',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Certificate',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'CV',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Cover Letter',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          rows: prijavePrakseResult!.map((prijava) {
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text(prijava.praksaId.toString())),
                                DataCell(Text(prijava.praksa?.idNavigation?.naslov ?? 'No title')),
                                DataCell(Text(prijava.certifikati ?? 'No certificate')),
                                DataCell(Text(prijava.cv ?? 'No CV')),
                                DataCell(Text(prijava.propratnoPismo ?? 'No cover letter')),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
    );
  }
}