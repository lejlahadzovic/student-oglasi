import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Oglas/oglas.dart';
import 'package:studentoglasi_mobile/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_mobile/models/Praksa/praksa.dart';
import 'package:studentoglasi_mobile/models/StatusOglas/statusoglasi.dart';
import 'package:studentoglasi_mobile/providers/oglasi_provider.dart';
import 'package:studentoglasi_mobile/providers/organizacije_provider.dart';
import 'package:studentoglasi_mobile/providers/prakse_provider.dart';
import 'package:studentoglasi_mobile/providers/statusoglasi_provider.dart';
import 'package:studentoglasi_mobile/screens/accommodations_screen.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/screens/components/like_button.dart';
import 'package:studentoglasi_mobile/screens/internship_details_screen.dart';
import 'package:studentoglasi_mobile/screens/main_screen.dart';
import 'package:studentoglasi_mobile/screens/scholarships_screen.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import '../models/search_result.dart';
import '../widgets/menu.dart';

class InternshipsScreen extends StatefulWidget {
  @override
  _InternshipsScreenState createState() => _InternshipsScreenState();
}

class _InternshipsScreenState extends State<InternshipsScreen> {
  late PraksaProvider _prakseProvider;
  late StatusOglasiProvider _statusProvider;
  late OrganizacijeProvider _organizacijeProvider;
  late OglasiProvider _oglasiProvider;
  Organizacije? selectedOrganizacije;
  StatusOglasi? selectedStatusOglasi;
  bool _isLoading = true;
  bool _hasError = false;
  SearchResult<Organizacije>? organizacijeResult;
  SearchResult<StatusOglasi>? statusResult;
  SearchResult<Oglas>? oglasiResult;
  SearchResult<Praksa>? _praksa;
  TextEditingController _naslovController = new TextEditingController();
  @override
  void initState() {
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

  Future<void> _fetchData() async {
    try {
      var data = await _prakseProvider.get(filter: {
        'naslov': _naslovController.text,
        'organizacija': selectedOrganizacije?.id,
      });
      setState(() {
        _praksa = data;
        _isLoading = false;
      });
      print("Data fetched successfully: ${_praksa?.count} items.");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _naslovController,
                decoration: const InputDecoration(
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
                ? const Center(child: CircularProgressIndicator())
                : _hasError
                    ? const Center(
                        child: Text(
                            'Failed to load data. Please try again later.'))
                    : _praksa?.count == 0
                        ? const Center(child: Text('No data available.'))
                        : ListView.builder(
                            itemCount: _praksa?.count,
                            itemBuilder: (context, index) {
                              final praksa = _praksa!.result[index];
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
                                              InternshipDetailsScreen(
                                            internship: praksa.idNavigation!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          praksa.idNavigation?.slika != null
                                              ? Image.network(
                                                  FilePathManager.constructUrl(
                                                      praksa.idNavigation!
                                                          .slika!),
                                                  height: 200,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                )
                                              : const SizedBox(
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
                                            praksa.idNavigation?.naslov ??
                                                'No title',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            praksa.idNavigation?.opis ??
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
                                                        postId: praksa.id!,
                                                        postType: ItemType.internship,
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
                                                itemId: praksa.id!,
                                                itemType: ItemType.internship,
                                              ),
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
