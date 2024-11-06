// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Oglas/oglas.dart';
import 'package:studentoglasi_admin/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/models/StatusOglasi/statusoglasi.dart';
import 'package:studentoglasi_admin/providers/prakse_provider.dart';
import 'package:studentoglasi_admin/utils/util.dart';

import '../../models/search_result.dart';

class PraksaDetailsDialog extends StatefulWidget {
  String? title;
  Praksa? praksa;
  SearchResult<StatusOglasi>? statusResult;
  SearchResult<Organizacije>? organizacijeResult;
  SearchResult<Oglas>? oglasiResult;
  PraksaDetailsDialog(
      {Key? key,
      this.title,
      this.praksa,
      this.organizacijeResult,
      this.statusResult,
      this.oglasiResult})
      : super(key: key);

  @override
  State<PraksaDetailsDialog> createState() => _PraksaDetailsDialogState();
}

class _PraksaDetailsDialogState extends State<PraksaDetailsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late PraksaProvider _PraksaProvider;
  String? _filePath;
  String? _imageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _PraksaProvider = context.read<PraksaProvider>();

    if (widget.praksa != null && widget.praksa!.idNavigation?.slika != null) {
      _imageUrl =
          FilePathManager.constructUrl(widget.praksa!.idNavigation!.slika!);
    }

    _initialValue = {
      'pocetakPrakse': widget.praksa?.pocetakPrakse,
      'krajPrakse': widget.praksa?.krajPrakse,
      'kvalifikacije': widget.praksa?.kvalifikacije,
      'benefiti': widget.praksa?.benefiti,
      'placena': widget.praksa?.placena ?? false,
      'idNavigation.id': widget.praksa?.idNavigation?.id.toString(),
      'idNavigation.naslov': widget.praksa?.idNavigation?.naslov,
      'idNavigation.opis': widget.praksa?.idNavigation?.opis,
      'idNavigation.rokPrijave': widget.praksa?.idNavigation?.rokPrijave,
      'idNavigation.slika': widget.praksa?.idNavigation?.slika,
      'idNavigation.vrijemeObjave': widget.praksa?.idNavigation?.vrijemeObjave,
      'statusId': widget.praksa?.status?.id.toString(),
      'organizacijaId': widget.praksa?.organizacija?.id.toString(),
    };
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
              SizedBox(height: 10),
              FormBuilderField(
                name: 'filePath',
                builder: (FormFieldState<dynamic> field) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Slika',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          errorText: field.errorText,
                        ),
                        child: Center(
                          child: _filePath != null
                              ? Image.file(
                                  File(_filePath!),
                                  fit: BoxFit.cover,
                                  width: 800,
                                  height: 450,
                                )
                              : _imageUrl != null
                                  ? Image.network(
                                      _imageUrl!,
                                      fit: BoxFit.cover,
                                      width: 800,
                                      height: 450,
                                    )
                                  : SizedBox(
                                      width: 800,
                                      height: 450,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image,
                                            size: 200,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            'Nema dostupne slike',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _filePath != null ? _filePath! : '',
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
                          name: 'idNavigation.naslov',
                          decoration: InputDecoration(
                            labelText: 'Naslov',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: validateText),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderCheckbox(
                        name: 'placena',
                        initialValue: _initialValue['placena'],
                        title: Text('Placena'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                          name: 'kvalifikacije',
                          decoration: InputDecoration(
                            labelText: 'Kvalifikacije',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: validateText),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                          name: 'benefiti',
                          decoration: InputDecoration(
                            labelText: 'Benefiti',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: validateText),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown<String>(
                        name: 'organizacijaId',
                        decoration: InputDecoration(
                          labelText: 'Organizacija',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: widget.organizacijeResult?.result
                                .map((Organizacije organizacija) =>
                                    DropdownMenuItem(
                                      value: organizacija.id.toString(),
                                      child: Text(organizacija.naziv ?? ''),
                                    ))
                                .toList() ??
                            [],
                        validator: validateText),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: FormBuilderDropdown<String>(
                        name: 'statusId',
                        decoration: InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: widget.statusResult?.result
                                .map((StatusOglasi status) => DropdownMenuItem(
                                      value: status.id.toString(),
                                      child: Text(status.naziv ?? ''),
                                    ))
                                .toList() ??
                            [],
                        validator: validateText),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderDateTimePicker(
                        name: 'idNavigation.vrijemeObjave',
                        inputType: InputType.date,
                        format: DateFormat('dd.MM.yyyy.'),
                        decoration:
                            InputDecoration(labelText: 'Vrijeme objave'),
                        validator: (value) {
                          if (value == null) {
                            return 'Izaberite datum';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderDateTimePicker(
                        name: 'idNavigation.rokPrijave',
                        inputType: InputType.date,
                        format: DateFormat('dd.MM.yyyy.'),
                        decoration: InputDecoration(labelText: 'Rok prijave'),
                        validator: (value) {
                          if (value == null) {
                            return 'Izaberite datum';
                          } else if (_formKey
                                  .currentState
                                  ?.fields['idNavigation.vrijemeObjave']
                                  ?.value !=
                              null) {
                            DateTime vrijemeObjave = _formKey.currentState
                                ?.fields['idNavigation.vrijemeObjave']?.value;
                            if (value.isBefore(vrijemeObjave)) {
                              return 'Izabrani datum mora biti poslije vremena objave';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderDateTimePicker(
                        name: 'pocetakPrakse',
                        inputType: InputType.date,
                        format: DateFormat('dd.MM.yyyy.'),
                        decoration:
                            InputDecoration(labelText: 'Početak prakse'),
                        validator: (value) {
                          if (value == null) {
                            return 'Izaberite datum';
                          } else if (_formKey.currentState
                                  ?.fields['idNavigation.rokPrijave']?.value !=
                              null) {
                            DateTime rokPrijave = _formKey.currentState
                                ?.fields['idNavigation.rokPrijave']?.value;
                            if (value.isBefore(rokPrijave)) {
                              return 'Izabrani datum mora biti poslije roka prijave';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderDateTimePicker(
                        name: 'krajPrakse',
                        inputType: InputType.date,
                        format: DateFormat('dd.MM.yyyy.'),
                        decoration: InputDecoration(labelText: 'Kraj prakse'),
                        validator: (value) {
                          if (value == null) {
                            return 'Izaberite datum';
                          } else if (_formKey.currentState
                                  ?.fields['pocetakPrakse']?.value !=
                              null) {
                            DateTime pocetakPrakse = _formKey
                                .currentState?.fields['pocetakPrakse']?.value;
                            if (value.isBefore(pocetakPrakse)) {
                              return 'Izabrani datum mora biti poslije početka prakse';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                          name: 'idNavigation.opis',
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Opis',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          validator: validateText),
                    ),
                  ),
                ],
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
            if (_formKey.currentState!.saveAndValidate()) {
              var request =
                  Map<String, dynamic>.from(_formKey.currentState!.value);

              try {
                if (widget.praksa == null) {
                  await _PraksaProvider.insertWithImage(request);
                } else {
                  await _PraksaProvider.updateWithImage(
                      widget.praksa!.id!, request);
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

String? validateText(String? value) {
  if (value == null || value.isEmpty) {
    return 'Unesite vrijednost u polje.';
  }
  return null;
}
