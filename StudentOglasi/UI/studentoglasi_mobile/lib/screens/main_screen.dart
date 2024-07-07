import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/providers/objave_provider.dart';
import 'package:studentoglasi_mobile/screens/internships_screen.dart';
import 'package:studentoglasi_mobile/screens/news_details_screen.dart';
import 'package:studentoglasi_mobile/screens/scholarships_screen.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import '../models/Kategorija/kategorija.dart';
import '../models/Objava/objava.dart';
import '../providers/kategorije_provider.dart';
import '../models/search_result.dart';
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
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _naslovController,
                decoration: InputDecoration(
                  hintText: 'Pretraži...',
                  border: InputBorder.none,
                ),
                onChanged: (text) => _onSearchChanged(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.purple[900]),
              onPressed: _onSearchChanged,
            ),
          ],
        ),
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScholarshipsScreen(),
                    ),
                  );
                },
                child: Text('Stipendije'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InternshipsScreen(),
                    ),
                  );
                },
                child: Text('Prakse'),
              ),
              ElevatedButton(
                onPressed: () => (),
                child: Text('Smjestaj'),
              ),
            ],
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _hasError
                    ? Center(
                        child: Text(
                            'Failed to load data. Please try again later.'))
                    : _objave?.count == 0
                        ? Center(child: Text('No data available.'))
                        : ListView.builder(
                            itemCount: _objave?.count,
                            itemBuilder: (context, index) {
                              final objava = _objave!.result[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Card(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ObjavaDetailsScreen(
                                                  objava: objava),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          objava.slika != null
                                              ? Image.network(
                                                  FilePathManager.constructUrl(
                                                      objava.slika!),
                                                  height: 200,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                )
                                              : SizedBox(
                                                  width: 800,
                                                  height: 450,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.image,
                                                        size: 200,
                                                        color: Colors.grey,
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                        'Nema dostupne slike',
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                          SizedBox(height: 8),
                                          Text(
                                            objava.naslov ?? 'Bez naslova',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            objava.sadrzaj ?? 'Nema sadržaja',
                                            style: TextStyle(fontSize: 16),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.comment,
                                                  color: Colors.purple[900]),
                                              SizedBox(width: 8),
                                              Text('Komentari'),
                                              SizedBox(width: 16),
                                              Icon(Icons.favorite,
                                                  color: Colors.purple[900]),
                                              SizedBox(width: 8),
                                              Text('Sviđa mi se'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
