import 'package:flutter/material.dart';
import 'package:studentoglasi_mobile/models/Objava/objava.dart';
import 'package:studentoglasi_mobile/screens/components/comments_screen.dart';
import 'package:studentoglasi_mobile/widgets/like_button.dart';
import 'package:studentoglasi_mobile/utils/item_type.dart';
import 'package:studentoglasi_mobile/utils/util.dart';

class ObjavaDetailsScreen extends StatelessWidget {
  final Objava objava;

  const ObjavaDetailsScreen({Key? key, required this.objava}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          objava.naslov ?? 'Detalji objava',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            objava.slika != null
                ? Image.network(
                    FilePathManager.constructUrl(objava.slika!),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(
                    height: 200,
                    child: Center(
                      child: Text('Nema dostupne slike'),
                    ),
                  ),
            SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.comment, color: Colors.blue), // Blue comment icon
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsScreen(
                          postId: objava.id!,
                          postType: ItemType.news,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 8),
                LikeButton(
                  itemId: objava.id!,
                  itemType: ItemType.news,
                ),
              ],
            ),
            SizedBox(height: 16),

            // Title of the news
            Text(
              objava.naslov ?? 'Nema naziva',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),

            // News content
            Text(
              objava.sadrzaj ?? 'Nema opisa',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
