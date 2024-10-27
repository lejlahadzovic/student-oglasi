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
import 'package:studentoglasi_admin/models/Stipendija/stipendija.dart';
import 'package:studentoglasi_admin/models/Stipenditor/stipenditor.dart';
import 'package:studentoglasi_admin/providers/prakse_provider.dart';
import 'package:studentoglasi_admin/providers/stipendije_provider.dart';
import 'package:studentoglasi_admin/utils/util.dart';

import '../../models/search_result.dart';

class StipendijeDetailsDialog extends StatefulWidget {
  Stipendije? stipendija;
  SearchResult<StatusOglasi>? statusResult;
  SearchResult<Stipenditor>? stipenditoriResult;
  SearchResult<Oglas>? oglasiResult;
  StipendijeDetailsDialog(
      {Key? key,
      this.stipendija,
      this.stipenditoriResult,
      this.statusResult,
      this.oglasiResult})
      : super(key: key);

  @override
  State<StipendijeDetailsDialog> createState() =>
      _StipendijeDetailsDialogState();
}

class _StipendijeDetailsDialogState extends State<StipendijeDetailsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late StipendijeProvider _StipendijaProvider;
  String? _filePath;
  String? _imageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _StipendijaProvider = context.read<StipendijeProvider>();

    if (widget.stipendija != null &&
        widget.stipendija!.idNavigation?.slika != null) {
      _imageUrl =
          FilePathManager.constructUrl(widget.stipendija!.idNavigation!.slika!);
    }

    _initialValue = {
      /*  int? id;
  String? uslovi;
  double? iznos;
  String? kriterij;
  String? potrebnaDokumentacija;
  String? izvor;
  String? nivoObrazovanja;
  int? brojStipendisata;*/
      'uslovi': widget.stipendija?.uslovi,
      'iznos': widget.stipendija?.iznos.toString(),
      'kriterij': widget.stipendija?.kriterij,
      'potrebnaDokumentacija': widget.stipendija?.potrebnaDokumentacija,
      'izvor': widget.stipendija?.izvor,
      'nivoObrazovanja': widget.stipendija?.nivoObrazovanja,
      'brojStipendisata': widget.stipendija?.brojStipendisata.toString(),
      'idNavigation.id': widget.stipendija?.idNavigation?.id.toString(),
      'idNavigation.naslov': widget.stipendija?.idNavigation?.naslov,
      'idNavigation.opis': widget.stipendija?.idNavigation?.opis,
      'idNavigation.rokPrijave': widget.stipendija?.idNavigation?.rokPrijave,
      'idNavigation.slika': widget.stipendija?.idNavigation?.slika,
      'idNavigation.vrijemeObjave':
          widget.stipendija?.idNavigation?.vrijemeObjave,
      'statusId': widget.stipendija?.status?.id.toString(),
      'stipenditorId': widget.stipendija?.stipenditor?.id.toString(),
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
      title: Text('Dodaj stipendiju'),
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
                      child: FormBuilderTextField(
                          name: 'uslovi',
                          decoration: InputDecoration(
                            labelText: 'Uslovi',
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
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                        name: 'iznos',
                        decoration: InputDecoration(
                          labelText: 'Iznos',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Unesite vrijednost u polje.'; // Field cannot be empty
                          }
                          final number = double.tryParse(value);
                          if (number == null) {
                            return 'Unesite važeći iznos'; // Enter a valid amount
                          }
                          return null;
                        },
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                          name: 'kriterij',
                          decoration: InputDecoration(
                            labelText: 'Kriterij',
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
                        name: 'stipenditorId',
                        decoration: InputDecoration(
                          labelText: 'Stipenditor',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: widget.stipenditoriResult?.result
                                .map((Stipenditor stipenditor) =>
                                    DropdownMenuItem(
                                      value: stipenditor.id.toString(),
                                      child: Text(stipenditor.naziv ?? ''),
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
                      child: FormBuilderTextField(
                          name: 'potrebnaDokumentacija',
                          decoration: InputDecoration(
                            labelText: 'Potrebna dokumentacija',
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
                          name: 'izvor',
                          decoration: InputDecoration(
                            labelText: 'Izvor',
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
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                        name: 'brojStipendisata',
                        decoration: InputDecoration(
                          labelText: 'Broj stipendisata',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Unesite vrijednost u polje.';
                          }
                          final number = int.tryParse(value);
                          if (number == null) {
                            return 'Unesite važeći broj';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                          name: 'nivoObrazovanja',
                          decoration: InputDecoration(
                            labelText: 'Nivo obrazovanja',
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
                widget.stipendija == null
                    ? await _StipendijaProvider.insertWithImage(request)
                    : await _StipendijaProvider.updateWithImage(
                        widget.stipendija!.id!, request);

                Navigator.pop(context, true);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Podaci su uspješno sačuvani!'),
                  backgroundColor: Colors.lightGreen,
                ));
              } on Exception catch (e) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          content: Text(
                              "Došlo je do greške. Molimo pokušajte opet!"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"))
                          ],
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
