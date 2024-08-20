import 'package:flutter/material.dart';
import 'package:studentoglasi_mobile/models/Oglas/oglas.dart';
import 'package:studentoglasi_mobile/screens/components/like_button.dart';
import 'package:studentoglasi_mobile/screens/scholarship_form_screen.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ScholarshipDetailsScreen extends StatelessWidget {
  final Oglas scholarship;

  const ScholarshipDetailsScreen({Key? key, required this.scholarship})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scholarship.naslov ?? 'Scholarship Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            scholarship.slika != null
                ? Image.network(
                    FilePathManager.constructUrl(scholarship.slika!),
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
                  icon: Icon(Icons.comment),
                  onPressed: () {
                    // Handle comment button press
                  },
                ),
                SizedBox(width: 8),
                LikeButton(
                  itemId: scholarship.id!,
                  itemType: ItemType.scholarship,
                ),
                SizedBox(width: 8),
              ],
            ),
            SizedBox(height: 16),
            Text(
              scholarship.naslov ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              scholarship.opis ?? 'No Description',
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
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
                                              PrijavaStipendijaFormScreen(
                                            scholarship:
                                                scholarship,
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