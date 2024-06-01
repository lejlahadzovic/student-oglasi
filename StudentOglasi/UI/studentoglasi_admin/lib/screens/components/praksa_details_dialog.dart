// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Oglas/oglas.dart';
import 'package:studentoglasi_admin/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/models/StatusOglasi/statusoglasi.dart';
import 'package:studentoglasi_admin/providers/prakse_provider.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _PraksaProvider = context.read<PraksaProvider>();

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
                        name: 'idNavigation.slika',
                        decoration: InputDecoration(
                          labelText: 'Slika',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
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
            _formKey.currentState?.saveAndValidate();
            var request = Map.from(_formKey.currentState!.value);

            request['idNavigation'] = {
              'id': widget.praksa?.idNavigation?.id ?? 0,
              'naslov': request['idNavigation.naslov'],
              'opis': request['idNavigation.opis'],
              'rokPrijave': request['idNavigation.rokPrijave'],
              'vrijemeObjave': request['idNavigation.vrijemeObjave'],
              'slika': request['idNavigation.slika'],
            };
            request.remove('idNavigation.naslov');
            request.remove('idNavigation.opis');
            request.remove('idNavigation.rokPrijave');
            request.remove('idNavigation.vrijemeObjave');
            request.remove('idNavigation.slika');

            try {
              widget.praksa == null
                  ? await _PraksaProvider.insert(request)
                  : await _PraksaProvider.update(widget.praksa!.id!, request);

              Navigator.pop(context, true);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Podaci su uspješno sačuvani!'),
                backgroundColor: Colors.lightGreen,
              ));
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

String? validateText(String? value) {
  if (value == null || value.isEmpty) {
    return 'Unesite vrijednost u polje.';
  }
  return null;
}
