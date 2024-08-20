import 'package:flutter/material.dart';
import 'package:studentoglasi_mobile/models/Oglas/oglas.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/widgets/like_button.dart';
import 'package:studentoglasi_mobile/screens/components/like_button.dart';
import 'package:studentoglasi_mobile/screens/internship_form_screen.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import 'package:studentoglasi_mobile/widgets/star_rating.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:provider/provider.dart';

class InternshipDetailsScreen extends StatefulWidget {
  final Oglas internship;
  final double averageRating;

  const InternshipDetailsScreen({
    Key? key,
    required this.internship,
    required this.averageRating,
  }) : super(key: key);

  @override
  _InternshipDetailsScreenState createState() =>
      _InternshipDetailsScreenState();
}

class _InternshipDetailsScreenState extends State<InternshipDetailsScreen> {
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
        widget.internship.id!,
        ItemType.internship.toShortString(),
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
        title: Text(widget.internship.naslov ?? 'Internship Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.internship.slika != null
                ? Image.network(
                    FilePathManager.constructUrl(widget.internship.slika!),
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
                          postId: widget.internship.id!,
                          postType: ItemType.internship,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 8),
                LikeButton(
                  itemId: widget.internship.id!,
                  itemType: ItemType.internship,
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
              widget.internship.naslov ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              widget.internship.opis ?? 'No Description',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: StarRatingWidget(
                    postId: widget.internship.id!,
                    postType: ItemType.internship,
                    onRatingChanged: _fetchAverageRatings,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child: Text('Prijavi se'),
                  ),
                ),
              ],
            ),
            Row(children: [
              Expanded(
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // Handle rating update
                  },
                ),
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
                                              PrijavaPraksaFormScreen(
                                            internship:
                                                internship,
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
