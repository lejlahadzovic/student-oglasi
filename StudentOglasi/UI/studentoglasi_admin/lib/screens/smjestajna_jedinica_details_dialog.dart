import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:open_file/open_file.dart';
import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/models/PrijavePraksa/prijave_praksa.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:studentoglasi_admin/models/Slike/slike.dart';
import 'package:studentoglasi_admin/models/SmjestajnaJedinica/smjestajna_jedinica.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/prijavepraksa_provider.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/providers/slike_provider.dart';
import 'package:studentoglasi_admin/utils/util.dart';

class SmjestajnaJedinicaDetailsDialog extends StatefulWidget {
  final SmjestajnaJedinica? jedinica;

  SmjestajnaJedinicaDetailsDialog({Key? key, this.jedinica}) : super(key: key);

  @override
  _SmjestajnaJedinicaDetailsDialogState createState() =>
      _SmjestajnaJedinicaDetailsDialogState();
}

class _SmjestajnaJedinicaDetailsDialogState
    extends State<SmjestajnaJedinicaDetailsDialog> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late SmjestajnaJedinica _jedinica;
  late SlikeProvider _slikeProvider;

  @override
  void initState() {
    super.initState();
    _slikeProvider = context.read<SlikeProvider>();
    _jedinica = widget.jedinica ??
        SmjestajnaJedinica(
            null, '', 0.0, 0, '', false, false, false, false, '', null, [], []);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.jedinica == null
          ? 'Dodaj smještajnu jedinicu'
          : 'Uredi smještajnu jedinicu'),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 550,
          maxWidth: 750,
        ),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            initialValue: {
              'naziv': _jedinica.naziv,
              'cijena': _jedinica.cijena.toString(),
              'kapacitet': _jedinica.kapacitet.toString(),
              'opis': _jedinica.opis,
              'kuhinja': _jedinica.kuhinja ?? false,
              'terasa': _jedinica.terasa ?? false,
              'tv': _jedinica.tv ?? false,
              'klimaUredjaj': _jedinica.klimaUredjaj ?? false,
              'dodatneUsluge': _jedinica.dodatneUsluge,
              'slike': _jedinica.slike,
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.image,
                    );

                    if (result != null) {
                      setState(() {
                        // _imageFiles ??= [];
                        // _imageFiles!.addAll(result.files);
                        _jedinica.slike ??= [];
                        _jedinica.slike!
                            .addAll(result.files.map((file) => file.path!));
                      });
                    }
                  },
                  child: Container(
                    width: 800,
                    height: 400,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: _buildImageGallery(
                        _jedinica.slikes ?? [], _jedinica.slike ?? []),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        name: 'naziv',
                        decoration: InputDecoration(
                          labelText: 'Naziv',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Naziv smještaja je obavezan.',
                          ),
                          FormBuilderValidators.minLength(
                            3,
                            errorText:
                                'Naziv smještaja mora imati najmanje 3 znaka.',
                          ),
                        ]),
                        onChanged: (value) {
                          setState(() {
                            _jedinica.naziv = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FormBuilderTextField(
                        name: 'kapacitet',
                        decoration: InputDecoration(
                          labelText: 'Kapacitet',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kapacitet je obavezan.';
                          }
                          final int? kapacitet = int.tryParse(value);
                          if (kapacitet == null || kapacitet <= 0) {
                            return 'Kapacitet mora biti pozitivan broj.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _jedinica.kapacitet;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: FormBuilderTextField(
                        name: 'cijena',
                        decoration: InputDecoration(
                          labelText: 'Cijena',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Cijena je obavezna.';
                          }
                          final double? cijena = double.tryParse(value);
                          if (cijena == null || cijena <= 0) {
                            return 'Cijena mora biti pozitivan broj.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _jedinica.cijena;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'opis',
                  decoration: InputDecoration(
                    labelText: 'Opis smještaja',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Opis smještaja je obavezan.';
                    }
                    if (value.length < 10) {
                      return 'Opis smještaja mora imati najmanje 10 znakova.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _jedinica.opis = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kuhinja'),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Terasa'),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Switch(
                              value: _jedinica.kuhinja ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _jedinica.kuhinja = value;
                                });
                              },
                            ),
                            Switch(
                              value: _jedinica.terasa ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _jedinica.terasa = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                      width: 100,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TV'),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Klima uređaj'),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Switch(
                              value: _jedinica.tv ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _jedinica.tv = value;
                                });
                              },
                            ),
                            Switch(
                              value: _jedinica.klimaUredjaj ?? false,
                              onChanged: (value) {
                                setState(() {
                                  _jedinica.klimaUredjaj = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'dodatneUsluge',
                  decoration: InputDecoration(
                    labelText: 'Dodatne usluge',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      _jedinica.dodatneUsluge = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Otkaži'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.saveAndValidate()) {
              Map<String, dynamic> formData = _formKey.currentState!.value;
              setState(() {
                _jedinica.naziv = formData['naziv'];
                _jedinica.cijena = double.parse(formData['cijena']);
                _jedinica.kapacitet = int.parse(formData['kapacitet']);
                _jedinica.opis = formData['opis'];
                _jedinica.kuhinja = _jedinica.kuhinja;
                _jedinica.terasa = _jedinica.terasa;
                _jedinica.tv = _jedinica.tv;
                _jedinica.klimaUredjaj = _jedinica.klimaUredjaj;
              });
              Navigator.pop(context, _jedinica);
            }
          },
          child: Text('Dodaj smještajnu jedinicu'),
        ),
      ],
    );
  }

  Widget _buildImageGallery(List<Slike> savedImages, List<String> newImages) {
    List<Widget> imageWidgets = [];

    imageWidgets.addAll(savedImages.map((slika) {
      final imageUrl = FilePathManager.constructUrl(slika.naziv!);
      return SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                iconSize: 22,
                onPressed: () async {
                  bool success = await _slikeProvider.delete(slika.slikaId);
                  if (success) {
                    setState(() {
                      savedImages.remove(slika);
                    });
                  }
                },
              ),
            ),
          ],
        ),
      );
    }));

    imageWidgets.addAll(newImages.map((path) {
      return SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                iconSize: 20,
                onPressed: () {
                  setState(() {
                    newImages.remove(path);
                  });
                },
              ),
            ),
          ],
        ),
      );
    }));

    imageWidgets.add(SizedBox(
      width: 80,
      height: 80,
      child: Container(
        color: Colors.grey.withOpacity(0.5),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Slike',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: GridView.count(
              crossAxisCount: 5,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: imageWidgets,
            ),
          ),
        ),
      ],
    );
  }
}
