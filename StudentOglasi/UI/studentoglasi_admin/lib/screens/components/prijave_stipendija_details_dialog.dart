// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../models/PrijaveStipendija/prijave_stipendija.dart';
import '../../providers/prijavestipendija_provider.dart';

class PrijavaStipendijaDetailsDialog extends StatefulWidget {
  String? title;
  PrijaveStipendija? prijaveStipendija;
  PrijavaStipendijaDetailsDialog({
    Key? key,
    this.title,
    this.prijaveStipendija,
  }) : super(key: key);

  @override
  State<PrijavaStipendijaDetailsDialog> createState() =>
      _PrijavaStipendijaDetailsDialogState();
}

class _PrijavaStipendijaDetailsDialogState
    extends State<PrijavaStipendijaDetailsDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late PrijaveStipendijaProvider _PrijavaStipendijaProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _PrijavaStipendijaProvider = context.read<PrijaveStipendijaProvider>();

    _initialValue = {
      'dokumentacija': widget.prijaveStipendija?.dokumentacija,
      'cv': widget.prijaveStipendija?.cv,
      'prosjekOcjena': widget.prijaveStipendija?.prosjekOcjena.toString(),
      'student.brojIndeksa': widget.prijaveStipendija?.student?.brojIndeksa,
      'student.fakultet': widget.prijaveStipendija?.student?.fakultet?.naziv,
      'student.ime': widget.prijaveStipendija?.student?.idNavigation?.ime,
      'student.prezime':
          widget.prijaveStipendija?.student?.idNavigation?.prezime,
      'student.email': widget.prijaveStipendija?.student?.idNavigation?.email,
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
            'Praksa: ${widget.prijaveStipendija?.stipendija?.idNavigation?.naslov}',
            style: TextStyle(
              fontSize: 18.0, // Adjust the font size as needed
              color: Colors.blue, // Adjust the color as needed
            ),
          ),
          SizedBox(
              height: 8.0), // Add some space between the title and subtitle
          Text(
            'Status prijave: ${widget.prijaveStipendija?.status?.naziv}',
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
                        name: 'dokumentacija',
                        decoration: InputDecoration(
                          labelText: 'Dokumentacija',
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
                        name: 'prosjekOcjena',
                        decoration: InputDecoration(
                          labelText: 'Prosjek Ocjena',
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
                  await _PrijavaStipendijaProvider.cancel(
                      widget.prijaveStipendija?.studentId,
                      entityId: widget.prijaveStipendija?.stipendijaId);
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
            await _PrijavaStipendijaProvider.approve(
                widget.prijaveStipendija?.studentId,
                entityId: widget.prijaveStipendija?.stipendijaId);
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
