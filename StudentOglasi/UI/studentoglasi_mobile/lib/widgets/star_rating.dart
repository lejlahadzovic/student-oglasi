import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Ocjena/ocjena_insert.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';

class StarRatingWidget extends StatefulWidget {
  final int postId;
  final ItemType postType;
  final double initialRating;
  final Function onRatingChanged;
  final double iconSize;

  const StarRatingWidget({
    Key? key,
    required this.postId,
    required this.postType,
    this.initialRating = 0.0,
    required this.onRatingChanged,
    this.iconSize = 40.0,
  }) : super(key: key);


  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  double _currentRating = 0.0;
  late OcjeneProvider _ocjeneProvider;

  @override
  void initState() {
    super.initState();
    _ocjeneProvider = context.read<OcjeneProvider>();
    _loadInitialRating();
  }

  Future<void> _loadInitialRating() async {
    try {
      var currentStudent =
          Provider.of<StudentiProvider>(context, listen: false).currentStudent;

      if (currentStudent == null || currentStudent.id == null) {
        throw Exception("Current student or student ID is null");
      }

      var ocjena = await _ocjeneProvider.getUserOcjena(
          widget.postId, widget.postType.toShortString(), currentStudent.id!);

      setState(() {
        _currentRating = ocjena?.ocjena ?? widget.initialRating;
      });
    } catch (e) {
      print('Failed to load initial rating: $e');
    }
  }

  Future<void> _submitRating(double rating) async {
    try {
      var currentStudent =
          Provider.of<StudentiProvider>(context, listen: false).currentStudent;
      if (currentStudent == null || currentStudent.id == null) {
        throw Exception("Current student or student ID is null");
      }
      var ratingModel = OcjenaInsert(
        widget.postId,
        widget.postType.toShortString(),
        currentStudent.id!,
        rating,
      );

      bool isSuccess = await _ocjeneProvider.insertOcjena(ratingModel);
      if (isSuccess) {
        print('Rating submitted successfully');
         widget.onRatingChanged();
      } else {
        print('Failed to submit rating');
      }
    } catch (e) {
      print('Failed to submit rating: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: _currentRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: widget.iconSize,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _currentRating = rating;
        });
        _submitRating(rating);
      },
    );
  }
}
