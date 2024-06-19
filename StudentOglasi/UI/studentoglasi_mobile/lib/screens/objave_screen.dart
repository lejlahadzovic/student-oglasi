import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/providers/objave_provider.dart';
import '../models/Kategorija/kategorija.dart';
import '../models/Objava/objava.dart';
import '../providers/kategorije_provider.dart';
import '../search_result.dart';
import '../widgets/menu.dart';

class ObjavaListScreen extends StatefulWidget {
  @override
  _ObjavaListScreenState createState() => _ObjavaListScreenState();
}

class _ObjavaListScreenState extends State<ObjavaListScreen> {
  late ObjaveProvider _objaveProvider;
  late KategorijaProvider _kategorijeProvider;
  Kategorija? selectedKategorija;
  bool _isLoading = true;
  bool _hasError = false;
  SearchResult<Objava>? _objave;
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

  Future<void> _fetchData() async {
    try {
      var data = await _objaveProvider.get(filter: {
        'naslov': _naslovController.text,
        'kategorijaID': selectedKategorija?.id,
      });
      setState(() {
        _objave = data;
        _isLoading = false;
      });
      print("Data fetched successfully: ${_objave?.count} items.");
    } catch (error) {
      print("Error fetching data");
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  void _fetchKategorije() async {
    var kategorijeData = await _kategorijeProvider.get();
    setState(() {
      kategorijeResult = kategorijeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ), 
      drawer: DrawerMenu(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(
                  child: Text('Failed to load data. Please try again later.'))
              : _objave?.count == 0
                  ? Center(child: Text('No data available.'))
                  : ListView.builder(
                      itemCount: _objave?.count,
                      itemBuilder: (context, index) {
                        final objava = _objave!.result[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    objava.naslov ?? 'No title',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    objava.sadrzaj ?? 'No content',
                                    style: TextStyle(fontSize: 16),
                                    softWrap: true,
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.comment),
                                      SizedBox(width: 8),
                                      Text('Comment'),
                                      SizedBox(width: 16),
                                      Icon(Icons.favorite),
                                      SizedBox(width: 8),
                                      Text('Like'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
