import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Oglas/oglas.dart';
import 'package:studentoglasi_mobile/models/StatusOglas/statusoglasi.dart';
import 'package:studentoglasi_mobile/models/Stipendija/stipendija.dart';
import 'package:studentoglasi_mobile/models/Stipenditor/stipenditor.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:studentoglasi_mobile/providers/oglasi_provider.dart';
import 'package:studentoglasi_mobile/providers/statusoglasi_provider.dart';
import 'package:studentoglasi_mobile/providers/stipendije_provider.dart';
import 'package:studentoglasi_mobile/providers/stipenditori_provider.dart';
import 'package:studentoglasi_mobile/screens/accommodations_screen.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/widgets/like_button.dart';
import 'package:studentoglasi_mobile/screens/internships_screen.dart';
import 'package:studentoglasi_mobile/screens/main_screen.dart';
import 'package:studentoglasi_mobile/screens/scholarship_details_screen.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import '../models/search_result.dart';
import '../widgets/menu.dart';

class ScholarshipsScreen extends StatefulWidget {
  @override
  _ScholarshipsScreenState createState() => _ScholarshipsScreenState();
}

class _ScholarshipsScreenState extends State<ScholarshipsScreen> {
  late StipendijeProvider _stipendijeProvider;
  late StatusOglasiProvider _statusProvider;
  late StipenditoriProvider _stipenditorProvider;
  late OglasiProvider _oglasiProvider;
  late OcjeneProvider _ocjeneProvider;
  bool _isLoading = true;
  bool _hasError = false;
  Stipenditor? selectedStipenditor;
  SearchResult<Stipendije>? _stipendije;
  SearchResult<Stipenditor>? stipenditoriResult;
  SearchResult<StatusOglasi>? statusResult;
  SearchResult<Oglas>? oglasiResult;
  Map<int, double> _averageRatings = {};
  TextEditingController _naslovController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stipendijeProvider = context.read<StipendijeProvider>();
    _statusProvider = context.read<StatusOglasiProvider>();
    _stipenditorProvider = context.read<StipenditoriProvider>();
    _oglasiProvider = context.read<OglasiProvider>();
    _ocjeneProvider = context.read<OcjeneProvider>();
    _fetchData();
    _fetchOglasi();
    _fetchStatusOglasi();
    _fetchStipenditori();
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

  void _fetchStipenditori() async {
    var stipenditoriData = await _stipenditorProvider.get();
    setState(() {
      stipenditoriResult = stipenditoriData;
    });
  }

  Future<void> _fetchAverageRatings() async {
  try {
    for (var stipendija in _stipendije?.result ?? []) {
      double averageRating = await _ocjeneProvider.getAverageOcjena(
        stipendija.id!,
        ItemType.scholarship.toShortString(),
      );
      setState(() {
        _averageRatings[stipendija.id!] = averageRating;
      });
    }
  } catch (error) {
    print("Error fetching average ratings: $error");
  }
}

  Future<void> _fetchData() async {
    try {
      var data = await _stipendijeProvider.get(filter: {
        'naslov': _naslovController.text,
        'stipenditor': selectedStipenditor?.id,
      });
      _averageRatings.clear();
      setState(() {
        _stipendije = data;
        _isLoading = false;
      });
      await _fetchAverageRatings();
      print("Data fetched successfully: ${_stipendije?.count} items.");
    } catch (error) {
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

  void _navigateToDetailsScreen(int scholarshipId, double averageRating) async {
  final shouldRefresh = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ScholarshipDetailsScreen(
        scholarship: _stipendije!.result.firstWhere((s) => s.id == scholarshipId).idNavigation!,
        averageRating: averageRating,
      ),
    ),
  );

  if (shouldRefresh == true) {
    _fetchAverageRatings();
  }
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
                      builder: (context) => ObjavaListScreen(),
                    ),
                  );
                },
                child: Text('Početna'),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccommodationsScreen(),
                    ),
                  );
                },
                child: Text('Smještaj'),
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
                    : _stipendije?.count == 0
                        ? Center(child: Text('No data available.'))
                        : ListView.builder(
                            itemCount: _stipendije?.count,
                            itemBuilder: (context, index) {
                              final stipendije = _stipendije!.result[index];
                              final averageRating = _averageRatings[stipendije.id] ?? 0.0;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Card(
                                  child: InkWell(
                                    onTap: () {
                                      _navigateToDetailsScreen(stipendije.id!, averageRating);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          stipendije.idNavigation?.slika != null
                                              ? Image.network(
                                                  FilePathManager.constructUrl(
                                                      stipendije.idNavigation!
                                                          .slika!),
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
                                            stipendije.idNavigation?.naslov ??
                                                'No title',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            stipendije.idNavigation?.opis ??
                                                'Nema sadržaja',
                                            style: TextStyle(fontSize: 16),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                          ),
                                          SizedBox(height: 8),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CommentsScreen(
                                                        postId: stipendije.id!,
                                                        postType: ItemType.scholarship,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.comment,
                                                      color: Colors.purple[900],
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text('Komentari'),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                              LikeButton(
                                                itemId: stipendije.id!,
                                                itemType: ItemType.scholarship,
                                              ),
                                              SizedBox(width: 8),
                                              Text('Sviđa mi se'),
                                              SizedBox(width: 16),
                                              Row(
                                                children: [
                                                  Icon(Icons.star, color: Colors.amber),
                                                  SizedBox(width: 4),
                                                  Text(averageRating == 0.0 ? 'N/A' : averageRating.toStringAsFixed(1)),
                                                ],
                                              ),
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
