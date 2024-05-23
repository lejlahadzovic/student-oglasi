import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Fakultet/fakultet.dart';
import 'package:studentoglasi_admin/models/NacinStudiranja/nacin_studiranja.dart';
import 'package:studentoglasi_admin/models/Smjer/smjer.dart';
import 'package:studentoglasi_admin/models/Student/student.dart';
import 'package:studentoglasi_admin/models/Univerzitet/univerzitet.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/studenti_provider.dart';
import 'package:studentoglasi_admin/utils/util.dart';

class StudentUpdateDialog extends StatefulWidget {
  Student? student;
  SearchResult<Univerzitet>? univerzitetiResult;
  SearchResult<NacinStudiranja>? naciniStudiranjaResult;
  StudentUpdateDialog({super.key, this.student, this.univerzitetiResult, this.naciniStudiranjaResult});

  @override
  State<StudentUpdateDialog> createState() => _StudentDetailsDialogState();
}

class _StudentDetailsDialogState extends State<StudentUpdateDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late StudentiProvider _studentProvider;
  String? _filePath;
  String? _imageUrl;
  Univerzitet? selectedUniverzitet;
  Fakultet? selectedFakultet;
  final List<int> godine = [1, 2, 3, 4];
  int? selectedGodina;
  final List<Map<String, dynamic>> statusStudenta = [
    {'value': true, 'label': 'Aktivan'},
    {'value': false, 'label': 'Neaktivan'},
  ];
  bool? selectedStatus;

  @override
  void initState() {
    super.initState();
    _studentProvider = context.read<StudentiProvider>();

    if (widget.univerzitetiResult != null && widget.student != null) {
    selectedUniverzitet = widget.univerzitetiResult!.result.firstWhere(
      (univerzitet) => univerzitet.id == widget.student!.fakultet.univerzitetId,
    );
    selectedFakultet = selectedUniverzitet!.fakultetis?.firstWhere(
      (fakultet) => fakultet.id == widget.student?.fakultet.id,
    );
    if (widget.student!.idNavigation.slika != null) {
      _imageUrl = FilePathManager.constructUrl(widget.student!.idNavigation.slika!);
    }
  }

    _initialValue = {
      'idNavigation.ime': widget.student?.idNavigation.ime,
      'idNavigation.prezime': widget.student?.idNavigation.prezime,
      'idNavigation.email': widget.student?.idNavigation.email,
      'univerzitetId': widget.student?.fakultet.univerzitetId.toString(),
      'smjerId': widget.student?.smjer.id.toString(),
      'nacinStudiranjaId': widget.student?.nacinStudiranja.id.toString(),
      'fakultetId':widget.student?.fakultet.id.toString(),
      'godinaStudija':widget.student?.godinaStudija,
      'status':widget.student?.status,
      'prosjecnaOcjena':widget.student?.prosjecnaOcjena.toString()
    };
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Detalji studenta'),
      content: SingleChildScrollView(
        child: Container(
          width: 700,
          child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          FormBuilderField(
                            name: 'filePath',
                            builder: (FormFieldState<dynamic> field) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Stack(
                                      children: [
                                        _filePath != null
                                            ? Image.file(
                                                File(_filePath!),
                                                width: 300,
                                                height: 300,
                                                fit: BoxFit.cover,
                                              )
                                            : _imageUrl != null
                                                ? Image.network(
                                                    _imageUrl!,
                                                    width: 300,
                                                    height: 300,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.asset(
                                                    'assets/images/user-icon.png',
                                                    width: 300,
                                                    height: 300,
                                                    fit: BoxFit.cover,
                                                  ),
                                        Positioned(
                                          bottom: 10,
                                          right: 10,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                          type: FileType.image);

                                              if (result != null) {
                                                setState(() {
                                                  _filePath =
                                                      result.files.single.path;
                                                });
                                                field.didChange(_filePath);
                                              }
                                            },
                                            child: Text('Odaberite sliku'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          FormBuilderTextField(
                            name: 'idNavigation.ime',
                            decoration: InputDecoration(
                              labelText: 'Ime',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: 'idNavigation.prezime',
                            decoration: InputDecoration(
                              labelText: 'Prezime',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: 'idNavigation.email',
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: 'prosjecnaOcjena',
                            decoration: InputDecoration(
                              labelText: 'Prosječna ocjena',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          FormBuilderDropdown<String>(
                            name: 'univerzitetId',
                            decoration: InputDecoration(
                              labelText: 'Univerzitet',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: widget.univerzitetiResult?.result
                                    .map((Univerzitet univerzitet) =>
                                        DropdownMenuItem(
                                          value: univerzitet.id.toString(),
                                          child: Text(univerzitet.naziv ?? ''),
                                        ))
                                    .toList() ??
                                [],
                            onChanged: (selectedUniverzitetId) {
                              setState(() {
                                selectedUniverzitet = widget.univerzitetiResult?.result
                                    .firstWhere((univerzitet) =>
                                        univerzitet.id.toString() ==
                                        selectedUniverzitetId);
                                selectedFakultet = null;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          FormBuilderDropdown<String>(
                            name: 'smjerId',
                            decoration: InputDecoration(
                              labelText: 'Smjer',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            enabled: selectedFakultet != null,
                            items: (selectedFakultet?.smjerovi ?? [])
                                    .map((Smjer smjer) => DropdownMenuItem(
                                          value: smjer.id.toString(),
                                          child: Text(smjer.naziv ?? ''),
                                        ))
                                    .toList() ??
                                [],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderDropdown<String>(
                            name: 'nacinStudiranjaId',
                            decoration: InputDecoration(
                              labelText: 'Način studiranja',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: widget.naciniStudiranjaResult?.result
                                    .map((NacinStudiranja nacinStudiranja) =>
                                        DropdownMenuItem(
                                          value: nacinStudiranja.id.toString(),
                                          child:
                                              Text(nacinStudiranja.naziv ?? ''),
                                        ))
                                    .toList() ??
                                [],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          FormBuilderDropdown<String>(
                            name: 'fakultetId',
                            decoration: InputDecoration(
                              labelText: 'Fakultet',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            enabled: selectedUniverzitet != null,
                            items: (selectedUniverzitet?.fakultetis ?? [])
                                    .map(
                                        (Fakultet fakultet) => DropdownMenuItem(
                                              value: fakultet.id.toString(),
                                              child: Text(fakultet.naziv ?? ''),
                                            ))
                                    .toList() ??
                                [],
                            onChanged: (selectedFakultetId) {
                              setState(() {
                                selectedFakultet =
                                    selectedUniverzitet?.fakultetis?.firstWhere(
                                  (fakultet) =>
                                      fakultet.id.toString() ==
                                      selectedFakultetId,
                                );
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderDropdown<int>(
                            name: 'godinaStudija',
                            decoration: InputDecoration(
                              labelText: 'Godina studija',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: godine
                                .map((godina) => DropdownMenuItem<int>(
                                      value: godina,
                                      child: Text('$godina. godina'),
                                    ))
                                .toList(),
                            onChanged: (selectedValue) {
                              setState(() {
                                selectedGodina = selectedValue;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          FormBuilderDropdown<bool>(
                            name: 'status',
                            decoration: InputDecoration(
                              labelText: 'Status studenta',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: statusStudenta
                                .map((status) => DropdownMenuItem<bool>(
                                      value: status['value'] as bool,
                                      child: Text(status['label'] as String),
                                    ))
                                .toList(),
                            onChanged: (selectedValue) {
                              setState(() {
                                selectedStatus = selectedValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
              await _studentProvider.updateWithImage(widget.student!.id!, request);
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
