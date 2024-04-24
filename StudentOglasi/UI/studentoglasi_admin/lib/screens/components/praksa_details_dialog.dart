// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Oglas/oglas.dart';
import 'package:studentoglasi_admin/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/models/StatusOglasi/statusoglasi.dart';
import 'package:studentoglasi_admin/providers/prakse_provider.dart';
import 'package:studentoglasi_admin/widgets/master_screen.dart';

import '../../models/search_result.dart';

class PraksaDetailsDialog extends StatefulWidget {
  Praksa? praksa;
  SearchResult<StatusOglasi>? statusResult;
   SearchResult<Organizacije>? organizacijeResult;
    SearchResult<Oglas>? oglasiResult;
  PraksaDetailsDialog({Key? key, this.praksa,this.organizacijeResult,this.statusResult, this.oglasiResult}) : super(key: key);

  @override
  State<PraksaDetailsDialog> createState() => _PraksaDetailsDialogState();
}

class _PraksaDetailsDialogState extends State<PraksaDetailsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue ={};
  late PraksaProvider _PraksaProvider;
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _PraksaProvider=context.read<PraksaProvider>();
    
    _initialValue ={
    'pocetakPrakse': widget.praksa?.pocetakPrakse,
    'krajPrakse': widget.praksa?.krajPrakse,
    'kvalifikacije': widget.praksa?.kvalifikacije,
    'benefiti': widget.praksa?.benefiti,
    'placena': widget.praksa?.placena,
    'idNavigation.id':widget.praksa?.idNavigation?.id.toString(),
    'idNavigation.naslov':widget.praksa?.idNavigation?.naslov, 
    'idNavigation.opis':widget.praksa?.idNavigation?.opis, 
    'idNavigation.rokPrijave':widget.praksa?.idNavigation?.rokPrijave, 
    'idNavigation.slika':widget.praksa?.idNavigation?.slika, 
    'idNavigation.vrijemeObjave':widget.praksa?.idNavigation?.vrijemeObjave, 
    'statusId': widget.praksa?.status?.id.toString(),
    'organizacijaId': widget.praksa?.organizacija?.id.toString(),};
   }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

   @override
  Widget build(BuildContext context) {
   return AlertDialog(
      title: Text('Dodaj praksu'),
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
                        name: 'benefiti',
                        decoration: InputDecoration(
                          labelText: 'Benefiti',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
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
                              .map((Organizacije organizacija) => DropdownMenuItem(
                                    value: organizacija.id.toString(),
                                    child: Text(organizacija.naziv ?? ''),
                                  ))
                              .toList() ??
                          [],
                    ),
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
              decoration: InputDecoration(labelText: 'Vrijeme objave'),
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
              decoration: InputDecoration(labelText: 'Početak prakse'),
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
                      child:FormBuilderTextField(
                name: 'idNavigation.opis',
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Opis',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
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
                      child:Text('Otkaži'),
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontWeight: FontWeight.bold)),
          ),
                    ),
         ] ),
        ElevatedButton(
          onPressed: () async {
            _formKey.currentState?.saveAndValidate();
            var request = Map.from(_formKey.currentState!.value);
            try {
              widget.praksa == null
                  ? await _PraksaProvider.insert(request)
                  : await _PraksaProvider.update(widget.praksa!.id!, request);

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