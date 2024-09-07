import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Like/like.dart';
import 'package:studentoglasi_mobile/providers/like_provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';

class LikeButton extends StatefulWidget {
  final int itemId;
  final ItemType itemType;

  const LikeButton({
    Key? key,
    required this.itemId,
    required this.itemType,
  }) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late LikeProvider _likeProvider;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _likeProvider = context.read<LikeProvider>();
  }

  Future<void> _toggleLike(int korisnikId) async {
    final like = Like(
      korisnikId,
      widget.itemId,
      widget.itemType,
    );

    try {
      if (_likeProvider.isLiked(widget.itemId, widget.itemType.toShortString())) {
        await _likeProvider.unlikeItem(like);
      } else {
        await _likeProvider.likeItem(like);
      }
    } catch (e) {
      // Handle error if needed
      print('Error toggling like: $e');
    }
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentStudent = context.watch<StudentiProvider>().currentStudent;
    isLiked = context
        .watch<LikeProvider>()
        .isLiked(widget.itemId, widget.itemType.toShortString());
    var likesCount = context
        .watch<LikeProvider>()
        .getLikesCount(widget.itemId, widget.itemType.toShortString());

    return Row(
      children: [
        IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: Colors.blue,
          ),
          onPressed: currentStudent != null
              ? () => _toggleLike(currentStudent.id!)
              : null,
        ),
        Text('$likesCount'),
      ],
    );
  }
}
