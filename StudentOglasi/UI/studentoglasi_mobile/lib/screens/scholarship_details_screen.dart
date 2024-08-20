import 'package:flutter/material.dart';
import 'package:studentoglasi_mobile/models/Oglas/oglas.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/widgets/like_button.dart';
import 'package:studentoglasi_mobile/screens/scholarship_form_screen.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import 'package:studentoglasi_mobile/widgets/star_rating.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:provider/provider.dart';

class ScholarshipDetailsScreen extends StatefulWidget {
  final Oglas scholarship;
  final double averageRating;

  const ScholarshipDetailsScreen(
      {Key? key, required this.scholarship, required this.averageRating})
      : super(key: key);

  @override
  _ScholarshipDetailsScreenState createState() => _ScholarshipDetailsScreenState();
}

class _ScholarshipDetailsScreenState extends State<ScholarshipDetailsScreen> {
  late double _averageRating;
  late OcjeneProvider _ocjeneProvider;

  @override
  void initState() {
    super.initState();
    _averageRating = widget.averageRating;
    _ocjeneProvider = Provider.of<OcjeneProvider>(context, listen: false);
  }

  Future<void> _fetchAverageRatings() async {
    try {
      double newAverageRating = await _ocjeneProvider.getAverageOcjena(
        widget.scholarship.id!,
        ItemType.scholarship.toShortString(),
      );
      setState(() {
        _averageRating = newAverageRating;
      });
    } catch (error) {
      print("Error fetching average ratings: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.scholarship.naslov ?? 'Scholarship Details'),
        leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context, true); // Signal za osvježavanje
    },
  ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.scholarship.slika != null
                ? Image.network(
                    FilePathManager.constructUrl(widget.scholarship.slika!),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text('No Image Available'),
                    ),
                  ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.comment, color: Colors.purple[900]),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsScreen(
                          postId: widget.scholarship.id!,
                          postType: ItemType.scholarship,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 8),
                LikeButton(
                  itemId: widget.scholarship.id!,
                  itemType: ItemType.scholarship,
                ),
                Spacer(),
                SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      SizedBox(width: 4),
                      Text(
                        _averageRating > 0
                            ? _averageRating.toStringAsFixed(1)
                            : "N/A",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              widget.scholarship.naslov ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              widget.scholarship.opis ?? 'No Description',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Row(children: [
              Expanded(
                child: StarRatingWidget(
                    postId: widget.scholarship.id!,
                    postType: ItemType.scholarship,
                    onRatingChanged: _fetchAverageRatings),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                   onPressed: () {
                  // Handle apply button press
                  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PrijavaStipendijaFormScreen(
                                            scholarship:
                                                widget.scholarship,
                                          ),
                                        ),
                                      );
                },
                  child: Text('Prijavi se'),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}