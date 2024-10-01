import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<void> downloadDocument(
    BuildContext context, String fileUrl, String fileName) async {
  try {
    var response = await http.get(Uri.parse(fileUrl));

    if (response.statusCode == 200) {
      String? outputFile = await FilePicker.platform.saveFile(
        initialDirectory: (await getDownloadsDirectory())?.path,
        dialogTitle: 'Odaberite lokaciju za spremanje',
        allowedExtensions: ['*'],
        type: FileType.custom,
        lockParentWindow: true,
        fileName: fileName,
      );

      if (outputFile != null) {
        File file = File(outputFile);
        await file.writeAsBytes(response.bodyBytes);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Preuzimanje uspješno, datoteka sačuvana na lokaciji: $outputFile'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Korisnik je otkazao odabir lokacije.');
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Greška'),
            content: Text('Neuspješno preuzimanje dokumenta'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Greška'),
          content: Text('Greška tokom preuzimanja dokumenta'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
