import 'package:flutter/material.dart';
import 'package:studentoglasi_mobile/models/Objava/objava.dart';
import 'package:studentoglasi_mobile/utils/util.dart';

class ObjavaDetailsScreen extends StatelessWidget {
  final Objava objava;

  const ObjavaDetailsScreen({Key? key, required this.objava}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(objava.naslov ?? 'News Details'),
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
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Handle like button press
                  },
                ),
                SizedBox(width: 8),
                
              ],
            ),
            SizedBox(height: 16),
            Text(
              objava.naslov ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              objava.sadrzaj ?? 'No Description',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}