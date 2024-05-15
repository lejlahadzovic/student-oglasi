import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Kategorija/kategorija.dart';
import 'package:studentoglasi_admin/models/Objava/objava.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/kategorije_provider.dart';
import 'package:studentoglasi_admin/providers/objave_provider.dart';
import 'package:studentoglasi_admin/utils/util.dart';

class ObjaveDetailsDialog extends StatefulWidget {
  String? title;
  Objava? objava;
  SearchResult<Kategorija>? kategorijeResult;
  ObjaveDetailsDialog(
      {super.key, this.title, this.objava, this.kategorijeResult});

  @override
  _ObjaveDetailsDialogState createState() => _ObjaveDetailsDialogState();
}

class _ObjaveDetailsDialogState extends State<ObjaveDetailsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  // TextEditingController _naslovController = TextEditingController();
  // TextEditingController _sadrzajController = TextEditingController();
  // late KategorijaProvider _kategorijeProvider;
  // Kategorija? _selectedKategorija;
  late ObjaveProvider _objaveProvider;
  String? _filePath;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _objaveProvider = context.read<ObjaveProvider>();
    // _kategorijeProvider = context.read<KategorijaProvider>();

    // if (widget.objava != null) {
    //   _naslovController.text = widget.objava!.naslov ?? '';
    //   _sadrzajController.text = widget.objava!.sadrzaj ?? '';
    //   if (widget.kategorijeResult != null &&
    //       widget.kategorijeResult!.result.isNotEmpty) {
    //     _selectedKategorija = widget.kategorijeResult!.result.firstWhere(
    //       (kategorija) => kategorija.id == widget.objava!.kategorija?.id
    //     );
    //   }
    // }
    if (widget.objava != null && widget.objava!.slika != null) {
      _imageUrl = FilePathManager.constructUrl(widget.objava!.slika!);
    }

    _initialValue = {
      'naslov': widget.objava?.naslov,
      'sadrzaj': widget.objava?.sadrzaj,
      'kategorijaId': widget.objava?.kategorijaId.toString(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? ''),
      content: SingleChildScrollView(
        child: FormBuilder(
          key: _formKey,
          initialValue: _initialValue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderField(
                name: 'filePath',
                builder: (FormFieldState<dynamic> field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: _filePath != null
                            ? Image.file(
                                File(_filePath!),
                                fit: BoxFit.cover,
                                width: 800,
                              )
                            : _imageUrl != null
                                ? Image.network(
                                    _imageUrl!,
                                    fit: BoxFit.cover,
                                    width: 800,
                                  )
                                : Text(''),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _filePath != null
                                  ? _filePath!
                                  : (_imageUrl != null
                                      ? ''
                                      : 'Nema odabrane slike'),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.image);

                              if (result != null) {
                                setState(() {
                                  _filePath = result.files.single.path;
                                });
                                field.didChange(_filePath);
                              }
                            },
                            child: Text('Odaberite sliku'),
                          ),
                        ],
                      ),
                      if (field.errorText != null)
                        Text(
                          field.errorText!,
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                        name: 'naslov',
                        decoration: InputDecoration(
                          labelText: 'Naslov',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: FormBuilderDropdown<String>(
                      name: 'kategorijaId',
                      decoration: InputDecoration(
                        labelText: 'Kategorija',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: widget.kategorijeResult?.result
                              .map((Kategorija kategorija) => DropdownMenuItem(
                                    value: kategorija.id.toString(),
                                    child: Text(kategorija.naziv ?? ''),
                                  ))
                              .toList() ??
                          [],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              FormBuilderTextField(
                name: 'sadrzaj',
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Sadržaj',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Otkaži'),
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ]),
        ElevatedButton(
          onPressed: () async {
            _formKey.currentState?.saveAndValidate();
            var request =
                Map<String, dynamic>.from(_formKey.currentState!.value);

            try {
              widget.objava == null
                  ? await _objaveProvider.insertWithImage(request)
                  : await _objaveProvider.updateWithImage(
                      widget.objava!.id!, request);

              Navigator.pop(context, true);
            } on Exception catch (e) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("Error"),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"))
                        ],
                      ));
            }
          },
          child: Text('Sačuvaj'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blue.shade800),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
