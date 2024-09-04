import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Smjestaj/smjestaj.dart';
import 'package:studentoglasi_mobile/models/search_result.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:studentoglasi_mobile/providers/smjestaji_provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/screens/accommodation_details_screen.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/widgets/like_button.dart';
import 'package:studentoglasi_mobile/screens/internships_screen.dart';
import 'package:studentoglasi_mobile/screens/main_screen.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import 'package:studentoglasi_mobile/widgets/menu.dart';

class AccommodationsScreen extends StatefulWidget {
  const AccommodationsScreen({super.key});

  @override
  State<AccommodationsScreen> createState() => _AccommodationsScreenState();
}

class _AccommodationsScreenState extends State<AccommodationsScreen> {
  late SmjestajiProvider _smjestajiProvider;
  late OcjeneProvider _ocjeneProvider;
  SearchResult<Smjestaj>? smjestaji;
  TextEditingController _nazivController = TextEditingController();
  Map<int, double> _averageRatings = {};
  bool _isLoading = false;
  bool _hasError = false;
  SearchResult<Smjestaj> recommendedSmjestaji = SearchResult<Smjestaj>();

  @override
  void initState() {
    super.initState();
    _smjestajiProvider = context.read<SmjestajiProvider>();
    _ocjeneProvider = context.read<OcjeneProvider>();
    _fetchData();
    _fetchRecommendedSmjestaji();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      var data = await _smjestajiProvider.get(filter: {
        'naziv': _nazivController.text,
      });
      _averageRatings.clear();
      setState(() {
        smjestaji = data;
        _isLoading = false;
      });
      await _fetchAverageRatings();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  Future<void> _fetchAverageRatings() async {
    try {
      for (var smjestaj in smjestaji?.result ?? []) {
        double averageRating = await _ocjeneProvider.getAverageOcjena(
          smjestaj.id!,
          ItemType.accommodation.toShortString(),
        );
        setState(() {
          _averageRatings[smjestaj.id!] = averageRating;
        });
      }
    } catch (error) {
      print("Error fetching average ratings: $error");
    }
  }

  Future<void> _fetchRecommendedSmjestaji() async {
    try {
      var studentiProvider =
          Provider.of<StudentiProvider>(context, listen: false);
      var studentId = studentiProvider.currentStudent?.id;

      if (studentId == null) {
        var student = await studentiProvider.getCurrentStudent();
        studentId = student.id;
      }

      if (studentId != null) {
        recommendedSmjestaji =
            await Provider.of<SmjestajiProvider>(context, listen: false)
                .getRecommended(studentId);
        setState(() {});
      } else {
        print("Student ID is not available");
      }
    } catch (error) {
      print("Error fetching recommended internships: $error");
    }
  }

  void _onSearchChanged() {
    _fetchData();
  }

  void _navigateToDetailsScreen(
      int accommodationId, double averageRating) async {
    final shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccommodationDetailsScreen(
          smjestaj:
              smjestaji!.result.firstWhere((s) => s.id == accommodationId),
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
    final recommendedIds = recommendedSmjestaji.result.map((p) => p.id).toSet();

    final filteredSmjestaji = smjestaji?.result
            .where((p) => !recommendedIds.contains(p.id))
            .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nazivController,
                decoration: InputDecoration(
                  hintText: 'Pretraži...',
                  border: InputBorder.none,
                ),
                onChanged: (text) => _onSearchChanged(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
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
                onPressed: () => null,
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
                          'Neuspješno učitavanje podataka.',
                        ),
                      )
                    : smjestaji?.count == 0
                        ? Center(child: Text('Nema dostupnih podataka.'))
                        : ListView.builder(
                            itemCount: recommendedSmjestaji.count +
                                filteredSmjestaji.length,
                            itemBuilder: (context, index) {
                              if (index < (recommendedSmjestaji.count)) {
                                final praksa = recommendedSmjestaji.result[index];
                                return _buildPostCard(praksa,
                                    isRecommended: true);
                              } else {
                                final praksa = filteredSmjestaji[index - (recommendedSmjestaji.count)];
                                return _buildPostCard(praksa);
                              }
                            },
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Smjestaj smjestaj, {bool isRecommended = false}) {
    final averageRating = _averageRatings[smjestaj.id] ?? 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: InkWell(
          onTap: () {
            _navigateToDetailsScreen(smjestaj.id!, averageRating);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    smjestaj.slikes != null && smjestaj.slikes!.isNotEmpty
                        ? Image.network(
                            FilePathManager.constructUrl(
                                smjestaj.slikes!.first.naziv!),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Nema dostupne slike',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                    if (isRecommended)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'Preporučeno',
                            style: TextStyle(
                              color: Colors.purple[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  smjestaj.naziv ?? 'Bez naslova',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  smjestaj.grad?.naziv ?? 'Podaci o lokaciji nisu dostupni',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  smjestaj.opis ?? 'Nema sadržaja',
                  style: TextStyle(fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                              postId: smjestaj.id!,
                              postType: ItemType.accommodation,
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
                      itemId: smjestaj.id!,
                      itemType: ItemType.accommodation,
                    ),
                    SizedBox(width: 8),
                    Text('Sviđa mi se'),
                    SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(averageRating == 0.0
                            ? 'N/A'
                            : averageRating.toStringAsFixed(1)),
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
  }
}
