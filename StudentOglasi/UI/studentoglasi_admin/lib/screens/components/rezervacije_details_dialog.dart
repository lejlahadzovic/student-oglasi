// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Oglas/oglas.dart';
import 'package:studentoglasi_admin/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/models/PrijavePraksa/prijave_praksa.dart';
import 'package:studentoglasi_admin/models/Rezervacije/rezervacije.dart';
import 'package:studentoglasi_admin/models/StatusOglasi/statusoglasi.dart';
import 'package:studentoglasi_admin/providers/prakse_provider.dart';
import 'package:studentoglasi_admin/providers/prijavepraksa_provider.dart';
import 'package:studentoglasi_admin/providers/rezervacije_provider.dart';

import '../../models/search_result.dart';

class RezervacijeDetailsDialog extends StatefulWidget {
  String? title;
  Rezervacije? rezervacija;
  RezervacijeDetailsDialog({
    Key? key,
    this.title,
    this.rezervacija,
  }) : super(key: key);

  @override
  State<RezervacijeDetailsDialog> createState() =>
      _RezervacijeDetailsDialogState();
}

class _RezervacijeDetailsDialogState extends State<RezervacijeDetailsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late RezervacijeProvider _RezervacijeProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _RezervacijeProvider = context.read<RezervacijeProvider>();
    /*  int? studentId;
  int? smjestajnaJedinicaId;
  DateTime? datumPrijave;
  DateTime? datumOdjave;
  int? brojOsoba;
  String? napomena;
  int? statusId;
  SmjestajnaJedinica? smjestajnaJedinica;
  SmjestajBasic? smjestaj;
  StatusPrijave? status;
  Student? student;*/
    _initialValue = {
      'datumPrijave': widget.rezervacija?.datumPrijave != null
          ? DateFormat('dd.MM.yyyy').format(widget.rezervacija!.datumPrijave!)
          : '',
      'datumOdjave': widget.rezervacija?.datumOdjave != null
          ? DateFormat('dd.MM.yyyy').format(widget.rezervacija!.datumOdjave!)
          : '',
      'brojOsoba': widget.rezervacija?.brojOsoba.toString(),
      'napomena': widget.rezervacija?.napomena,
      'cijena': widget.rezervacija?.cijena.toString(),
      'student.brojIndeksa': widget.rezervacija?.student?.brojIndeksa,
      'student.fakultet': widget.rezervacija?.student?.fakultet.naziv,
      'student.imePrezime':
          '${widget.rezervacija?.student?.idNavigation.ime} ${widget.rezervacija?.student?.idNavigation.prezime}',
      'student.email': widget.rezervacija?.student?.idNavigation.email,
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
            'Naziv smještaja: ${widget.rezervacija?.smjestaj?.naziv}',
            style: TextStyle(
              fontSize: 18.0, // Adjust the font size as needed
              color: Colors.blue, // Adjust the color as needed
            ),
          ),
          SizedBox(
              height: 8.0), // Add some space between the title and subtitle
          Text(
            'Smještajna jedinica: ${widget.rezervacija?.smjestajnaJedinica?.naziv}',
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
                        name: 'student.imePrezime',
                        decoration: InputDecoration(
                          labelText: 'Ime i prezime',
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
                        name: 'datumPrijave',
                        decoration: InputDecoration(
                          labelText: 'Datum prijave',
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
                        name: 'datumOdjave',
                        decoration: InputDecoration(
                          labelText: 'Datum odjave',
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
                        name: 'brojOsoba',
                        decoration: InputDecoration(
                          labelText: 'Broj osoba',
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
                        name: 'cijena',
                        decoration: InputDecoration(
                          labelText: 'Cijena',
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
              SizedBox(height: 20),
              FormBuilderTextField(
                name: 'napomena',
                decoration: InputDecoration(
                  labelText: 'Napomena/zahtjevi',
                  labelStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                enabled: false,
                style: TextStyle(color: Colors.black),
                maxLines: 3,
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
                onPressed: () async {
                  await _RezervacijeProvider.cancel(
                      widget.rezervacija?.studentId,
                      entityId: widget.rezervacija?.smjestajnaJedinicaId);
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
            await _RezervacijeProvider.approve(widget.rezervacija?.studentId,
                entityId: widget.rezervacija?.smjestajnaJedinicaId);
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
