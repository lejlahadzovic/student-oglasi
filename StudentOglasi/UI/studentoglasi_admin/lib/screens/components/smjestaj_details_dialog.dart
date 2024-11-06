// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Grad/grad.dart';
import 'package:studentoglasi_admin/models/Slike/slike.dart';
import 'package:studentoglasi_admin/models/Smjestaj/smjestaj.dart';
import 'package:studentoglasi_admin/models/SmjestajnaJedinica/smjestajna_jedinica.dart';
import 'package:studentoglasi_admin/models/TipSmjestaja/tip_smjestaja.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/slike_provider.dart';
import 'package:studentoglasi_admin/providers/smjestaji_provider.dart';
import 'package:studentoglasi_admin/providers/smjestajna_jedinica_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:studentoglasi_admin/screens/smjestajna_jedinica_details_dialog.dart';
import 'package:studentoglasi_admin/utils/util.dart';

class SmjestajDetailsDialog extends StatefulWidget {
  SearchResult<Grad>? gradoviResult;
  SearchResult<TipSmjestaja>? tipoviSmjestajaResult;
  Smjestaj? smjestaj;
  String? title;
  SmjestajDetailsDialog(
      {Key? key,
      this.gradoviResult,
      this.tipoviSmjestajaResult,
      this.smjestaj,
      this.title})
      : super(key: key);

  @override
  State<SmjestajDetailsDialog> createState() => _SmjestajDetailsDialogState();
}

class _SmjestajDetailsDialogState extends State<SmjestajDetailsDialog> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  Smjestaj _smjestaj = Smjestaj(null, '', '', '', '', false, false, false,
      false, false, null, null, [], [], []);
  late SmjestajiProvider _smjestajiProvider;
  late SlikeProvider _slikeProvider;
  List<PlatformFile>? _imageFiles;
  List<String> _newImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _smjestajiProvider = context.read<SmjestajiProvider>();
    _slikeProvider = context.read<SlikeProvider>();

    if (widget.smjestaj != null) {
      _smjestaj = widget.smjestaj!;
    }

    if (widget.smjestaj != null) {
      _initialValue = {
        'naziv': widget.smjestaj!.naziv,
        'adresa': widget.smjestaj!.adresa,
        'opis': widget.smjestaj!.opis,
        'gradId': widget.smjestaj!.grad?.id.toString(),
        'tipSmjestajaId': widget.smjestaj!.tipSmjestaja?.id.toString(),
        'restoran': widget.smjestaj!.restoran ?? false,
        'parking': widget.smjestaj!.parking ?? false,
        'fitnessCentar': widget.smjestaj!.fitnessCentar ?? false,
        'wiFi': widget.smjestaj!.wiFi ?? false,
        'uslugePrijevoza': widget.smjestaj!.uslugePrijevoza ?? false,
        'dodatneUsluge': widget.smjestaj!.dodatneUsluge,
      };

      _updateSmjestajneJediniceInInitialValue();
    }
  }

  void _updateSmjestajneJediniceInInitialValue() {
    List<Map<String, dynamic>> smjestajneJedinice = [];
    for (var jedinica in _smjestaj.smjestajnaJedinicas!) {
      Map<String, dynamic> jedinicaData = {
        'naziv': jedinica.naziv,
        'cijena': jedinica.cijena.toString(),
        'kapacitet': jedinica.kapacitet.toString(),
        'opis': jedinica.opis,
        'kuhinja': jedinica.kuhinja ?? false,
        'terasa': jedinica.terasa ?? false,
        'tv': jedinica.tv ?? false,
        'klimaUredjaj': jedinica.klimaUredjaj ?? false,
        'dodatneUsluge': jedinica.dodatneUsluge,
        'slike': jedinica.slike,
      };
      smjestajneJedinice.add(jedinicaData);
    }
    _initialValue['smjestajnaJedinica'] = smjestajneJedinice;
  }

  void _showSmjestajnaJedinicaDialog([SmjestajnaJedinica? jedinica]) async {
    SmjestajnaJedinica? result = await showDialog<SmjestajnaJedinica>(
      context: context,
      builder: (BuildContext context) {
        return SmjestajnaJedinicaDetailsDialog(jedinica: jedinica);
      },
    );

    if (result != null) {
      setState(() {
        if (jedinica == null) {
          _smjestaj.smjestajnaJedinicas!.add(result);
        } else {
          int index = _smjestaj.smjestajnaJedinicas!.indexOf(jedinica);
          _smjestaj.smjestajnaJedinicas![index] = result;
        }
      });
    }
  }

  void _addSmjestajnaJedinica() {
    setState(() {
      _smjestaj.smjestajnaJedinicas!.add(SmjestajnaJedinica(
          null, '', 0.0, 0, '', false, false, false, false, '', 0, [], []));
    });
    if (widget.smjestaj != null) {
      _updateSmjestajneJediniceInInitialValue();
    }
    _showSmjestajnaJedinicaDialog();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? ''),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 800,
          maxWidth: 800,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilder(
              key: _formKey,
              initialValue: _initialValue,
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
                          _smjestaj.slike ??= [];
                          _smjestaj.slike!
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
                          _smjestaj.slikes ?? [], _smjestaj.slike ?? []),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          name: 'naziv',
                          decoration: InputDecoration(
                            labelText: 'Naziv smještaja',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                              _smjestaj.naziv = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: FormBuilderDropdown<String>(
                          name: 'tipSmjestajaId',
                          decoration: InputDecoration(
                            labelText: 'Tip smještaja',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: FormBuilderValidators.required(
                            errorText: 'Tip smještaja je obavezan.',
                          ),
                          items: widget.tipoviSmjestajaResult?.result
                                  .map((TipSmjestaja tipSmjestaja) =>
                                      DropdownMenuItem(
                                        value: tipSmjestaja.id.toString(),
                                        child: Text(tipSmjestaja.naziv ?? ''),
                                      ))
                                  .toList() ??
                              [],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: FormBuilderTextField(
                          name: 'adresa',
                          decoration: InputDecoration(
                            labelText: 'Adresa',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Adresa je obavezna.',
                            ),
                            FormBuilderValidators.minLength(
                              5,
                              errorText:
                                  'Adresa mora imati najmanje 5 znakova.',
                            ),
                          ]),
                          onChanged: (value) {
                            setState(() {
                              _smjestaj.adresa = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: FormBuilderDropdown<String>(
                          name: 'gradId',
                          decoration: InputDecoration(
                            labelText: 'Grad',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: FormBuilderValidators.required(
                            errorText: 'Grad je obavezan.',
                          ),
                          items: widget.gradoviResult?.result
                                  .map((Grad grad) => DropdownMenuItem(
                                        value: grad.id.toString(),
                                        child: Text(grad.naziv ?? ''),
                                      ))
                                  .toList() ??
                              [],
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
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                        errorText: 'Opis smještaja je obavezan.',
                      ),
                      FormBuilderValidators.minLength(
                        10,
                        errorText:
                            'Opis smještaja mora imati najmanje 10 znakova.',
                      ),
                    ]),
                    onChanged: (value) {
                      setState(() {
                        _smjestaj.opis = value;
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
                              Text('Restoran'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Parking'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Fitness centar'),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              Switch(
                                value: _smjestaj.restoran ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    _smjestaj.restoran = value;
                                  });
                                },
                              ),
                              Switch(
                                value: _smjestaj.parking ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    _smjestaj.parking = value;
                                  });
                                },
                              ),
                              Switch(
                                value: _smjestaj.fitnessCentar ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    _smjestaj.fitnessCentar = value;
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
                              Text('Wi-Fi'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Usluge prijevoza'),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Column(
                            children: [
                              Switch(
                                value: _smjestaj.wiFi ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    _smjestaj.wiFi = value;
                                  });
                                },
                              ),
                              Switch(
                                value: _smjestaj.uslugePrijevoza ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    _smjestaj.uslugePrijevoza = value;
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
                    maxLines: 2,
                    onChanged: (value) {
                      setState(() {
                        _smjestaj.dodatneUsluge = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Smještajne jedinice',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  for (var jedinica in _smjestaj.smjestajnaJedinicas!)
                    ListTile(
                      title: Text(jedinica.naziv ?? ''),
                      subtitle: Text('Cijena: ${jedinica.cijena} KM'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () =>
                                _showSmjestajnaJedinicaDialog(jedinica),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              bool? confirmDelete = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Potvrda brisanja'),
                                    content: Text(
                                        'Da li ste sigurni da želite obrisati?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: Text('Ne'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: Text('Da'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmDelete == true) {
                                await _deleteSmjestajnaJedinica(
                                    context, jedinica);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: () => _showSmjestajnaJedinicaDialog(),
                    label: Text('Dodaj smještajnu jedinicu'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade800),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
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
        ElevatedButton(
          onPressed: _saveFormData,
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

  Future<void> _saveFormData() async {
    if (_formKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> formData = _formKey.currentState!.value;

      Map<String, dynamic> smjestajData = {
        'naziv': formData['naziv'],
        'adresa': formData['adresa'],
        'dodatneUsluge': formData['dodatneUsluge'],
        'opis': formData['opis'],
        'gradId': formData['gradId'],
        'tipSmjestajaId': formData['tipSmjestajaId'],
        'restoran': _smjestaj.restoran,
        'parking': _smjestaj.parking,
        'fitnessCentar': _smjestaj.fitnessCentar,
        'wiFi': _smjestaj.wiFi,
        'uslugePrijevoza': _smjestaj.uslugePrijevoza,
      };

      try {
        Smjestaj savedSmjestaj = widget.smjestaj == null
            ? await _smjestajiProvider.insert(smjestajData)
            : await _smjestajiProvider.update(
                widget.smjestaj!.id!, smjestajData);

        List<String> smjestajImages = _smjestaj.slike ?? [];
        for (String imageFile in smjestajImages) {
          Map<String, dynamic> slikeInsertRequest = {
            'filePath': imageFile,
            'smjestajId': savedSmjestaj.id
          };
          await _slikeProvider.insertWithImage(slikeInsertRequest);
        }

        SmjestajnaJedinicaProvider jedinicaProvider =
            SmjestajnaJedinicaProvider();

        for (int i = 0; i < _smjestaj.smjestajnaJedinicas!.length; i++) {
          Map<String, dynamic> jedinicaData = {
            'naziv': _smjestaj.smjestajnaJedinicas?[i].naziv,
            'cijena': _smjestaj.smjestajnaJedinicas?[i].cijena,
            'kapacitet': _smjestaj.smjestajnaJedinicas?[i].kapacitet,
            'opis': _smjestaj.smjestajnaJedinicas?[i].opis,
            'kuhinja': _smjestaj.smjestajnaJedinicas?[i].kuhinja,
            'terasa': _smjestaj.smjestajnaJedinicas?[i].terasa,
            'tv': _smjestaj.smjestajnaJedinicas?[i].tv,
            'klimaUredjaj': _smjestaj.smjestajnaJedinicas?[i].klimaUredjaj,
            'dodatneUsluge': _smjestaj.smjestajnaJedinicas?[i].dodatneUsluge,
            'smjestajId': savedSmjestaj.id
          };

          SmjestajnaJedinica savedJedinica =
              _smjestaj.smjestajnaJedinicas![i].id == null
                  ? await jedinicaProvider.insert(jedinicaData)
                  : await jedinicaProvider.update(
                      _smjestaj.smjestajnaJedinicas![i].id!, jedinicaData);

          List<String> jedinicaImages =
              _smjestaj.smjestajnaJedinicas![i].slike ?? [];
          for (String imageFile in jedinicaImages) {
            Map<String, dynamic> slikeInsertRequest = {
              'filePath': imageFile,
              'smjestajnaJedinicaId': savedJedinica.id
            };
            await _slikeProvider.insertWithImage(slikeInsertRequest);
          }
        }

        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Podaci su uspješno sačuvani!'),
            ],
          ),
          backgroundColor: Colors.lightGreen,
        ));
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text('Došlo je do greške. Molimo pokušajte opet!'),
            ],
          ),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }

  Future<void> _deleteSmjestajnaJedinica(
      BuildContext context, SmjestajnaJedinica jedinica) async {
    SmjestajnaJedinicaProvider smjestajnaJedinicaProvider =
        context.read<SmjestajnaJedinicaProvider>();

    bool isDeleted = await smjestajnaJedinicaProvider.delete(jedinica.id);

    if (isDeleted) {
      setState(() {
        _smjestaj.smjestajnaJedinicas!.remove(jedinica);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Brisanje smještajne jedinice nije uspjelo')),
      );
    }
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
