// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/PrijavePraksa/prijave_praksa.dart';
import 'package:studentoglasi_admin/providers/prijavepraksa_provider.dart';


class PrijavaPraksaDetailsDialog extends StatefulWidget {
  String? title;
  PrijavePraksa? prijavePraksa;
  PrijavaPraksaDetailsDialog({
    Key? key,
    this.title,
    this.prijavePraksa,
  }) : super(key: key);

  @override
  State<PrijavaPraksaDetailsDialog> createState() =>
      _PrijavaPraksaDetailsDialogState();
}

class _PrijavaPraksaDetailsDialogState
    extends State<PrijavaPraksaDetailsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late PrijavePraksaProvider _PrijavePraksaProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _PrijavePraksaProvider = context.read<PrijavePraksaProvider>();
/*  int? studentId;
  int? praksaId;
  String? propratnoPismo;
  String? cv;
  String? certifikati;
  int? statusId;
  Praksa? praksa;
  StatusPrijave? status;
  Student? student;*/
    _initialValue = {
      'propratnoPismo': widget.prijavePraksa?.propratnoPismo,
      'cv': widget.prijavePraksa?.cv,
      'certifikati': widget.prijavePraksa?.certifikati,
      'student.brojIndeksa': widget.prijavePraksa?.student?.brojIndeksa,
      'student.fakultet': widget.prijavePraksa?.student?.fakultet.naziv,
      'student.ime': widget.prijavePraksa?.student?.idNavigation.ime,
      'student.prezime': widget.prijavePraksa?.student?.idNavigation.prezime,
      'student.email': widget.prijavePraksa?.student?.idNavigation.email,
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title ?? ''),
          SizedBox(
              height: 8.0), // Add some space between the title and subtitle
          Text(
            'Praksa: ${widget.prijavePraksa?.praksa?.idNavigation?.naslov}',
            style: TextStyle(
              fontSize: 18.0, // Adjust the font size as needed
              color: Colors.blue, // Adjust the color as needed
            ),
          ),
          SizedBox(
              height: 8.0), // Add some space between the title and subtitle
          Text(
            'Status prijave: ${widget.prijavePraksa?.status?.naziv}',
            style: TextStyle(
              fontSize: 18.0, // Adjust the font size as needed
              color: Colors.blue, // Adjust the color as needed
            ),
          ),
        ],
      ),
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
                        name: 'propratnoPismo',
                        decoration: InputDecoration(
                          labelText: 'Propratno pismo',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                        name: 'cv',
                        decoration: InputDecoration(
                          labelText: 'CV',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
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
                        name: 'student.brojIndeksa',
                        decoration: InputDecoration(
                          labelText: 'Broj indeksa',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                        name: 'student.fakultet',
                        decoration: InputDecoration(
                          labelText: 'Fakultet',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
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
                        name: 'student.ime',
                        decoration: InputDecoration(
                          labelText: 'Ime',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                        name: 'student.prezime',
                        decoration: InputDecoration(
                          labelText: 'Prezime',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
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
                        name: 'student.email',
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      width: 400,
                      child: FormBuilderTextField(
                        name: 'certifikati',
                        decoration: InputDecoration(
                          labelText: 'Certifikati',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        enabled: false,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
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
                onPressed: () async {
                  await _PrijavePraksaProvider.cancel(
                      widget.prijavePraksa?.studentId,
                      entityId: widget.prijavePraksa?.praksaId);
                  Navigator.pop(context, true);
                },
                child: Text('Otkaži'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ]),
        ElevatedButton(
          onPressed: () async {
            await _PrijavePraksaProvider.approve(
                widget.prijavePraksa?.studentId,
                entityId: widget.prijavePraksa?.praksaId);
            Navigator.pop(context, true);
          },
          child: Text('Odobri'),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.lightGreen),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
