import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/models/Fakultet/fakultet.dart';
import 'package:studentoglasi_admin/models/NacinStudiranja/nacin_studiranja.dart';
import 'package:studentoglasi_admin/models/Smjer/smjer.dart';
import 'package:studentoglasi_admin/models/Student/student.dart';
import 'package:studentoglasi_admin/models/Univerzitet/univerzitet.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/providers/studenti_provider.dart';

class StudentInsertDialog extends StatefulWidget {
  Student? student;
  SearchResult<Univerzitet>? univerzitetiResult;
  SearchResult<NacinStudiranja>? naciniStudiranjaResult;
  StudentInsertDialog(
      {super.key,
      this.student,
      this.univerzitetiResult,
      this.naciniStudiranjaResult});

  @override
  State<StudentInsertDialog> createState() => _StudentDetailsDialogState();
}

class _StudentDetailsDialogState extends State<StudentInsertDialog> {
  final _basicInfoFormKey = GlobalKey<FormBuilderState>();
  final _studyInfoFormKey = GlobalKey<FormBuilderState>();
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
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _studentProvider = context.read<StudentiProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Dodaj studenta'),
      content: Container(
        width: 700,
        height: _currentStep == 0 ? 600 : 520,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: Stepper(
            type: StepperType.horizontal,
            elevation: 0,
            currentStep: _currentStep,
            onStepTapped: (int step) async {
              bool canProceed = false;

              if (_currentStep == 0) {
                if (_basicInfoFormKey.currentState?.saveAndValidate() ??
                    false) {
                  var request = Map<String, dynamic>.from(
                      _basicInfoFormKey.currentState!.value);
                  final username = request['idNavigation.korisnickoIme'];
                  final isTaken =
                      await _studentProvider.isUsernameTaken(username);

                  if (isTaken) {
                    _basicInfoFormKey
                        .currentState!.fields['idNavigation.korisnickoIme']!
                        .invalidate('Korisničko ime je zauzeto!');
                  } else {
                    canProceed = true;
                  }
                }
              } else {
                canProceed = step < _currentStep;
              }

              if (canProceed) {
                setState(() {
                  _currentStep = step;
                });
              }
            },
            onStepContinue: () async {
              if (_currentStep == 0) {
                if (_basicInfoFormKey.currentState?.saveAndValidate() ??
                    false) {
                  var request = Map<String, dynamic>.from(
                      _basicInfoFormKey.currentState!.value);
                  final username = request['idNavigation.korisnickoIme'];
                  final isTaken =
                      await _studentProvider.isUsernameTaken(username);

                  if (isTaken) {
                    _basicInfoFormKey
                        .currentState!.fields['idNavigation.korisnickoIme']!
                        .invalidate('Korisničko ime je zauzeto!');
                  } else {
                    setState(() {
                      _currentStep += 1;
                    });
                  }
                }
              } else if (_currentStep == 1) {
                if (_studyInfoFormKey.currentState?.saveAndValidate() ??
                    false) {
                  var basicInfoData = _basicInfoFormKey.currentState!.value;
                  var studyInfoData = _studyInfoFormKey.currentState!.value;

                  var requestData = {...basicInfoData, ...studyInfoData};

                  try {
                    await _studentProvider.insertWithImage(requestData);
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
                  } catch (e) {
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
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_currentStep > 0)
                      ElevatedButton(
                        onPressed: details.onStepCancel,
                        child: Text('Nazad'),
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(_currentStep == 1 ? 'Sačuvaj' : 'Nastavi'),
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
              );
            },
            steps: [
              Step(
                title: Text('Osnovni podaci'),
                isActive: _currentStep >= 0,
                state:
                    _currentStep == 0 ? StepState.editing : StepState.complete,
                content: FormBuilder(
                  key: _basicInfoFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    FormBuilderField(
                                      name: 'filePath',
                                      builder: (FormFieldState<dynamic> field) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 200,
                                              height: 200,
                                              child: ClipOval(
                                                child: _filePath != null
                                                    ? Image.file(
                                                        File(_filePath!),
                                                        fit: BoxFit.cover,
                                                      )
                                                    : _imageUrl != null
                                                        ? Image.network(
                                                            _imageUrl!,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Image.asset(
                                                            'assets/images/user-icon.png',
                                                            fit: BoxFit.cover,
                                                          ),
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            ElevatedButton(
                                              onPressed: () async {
                                                FilePickerResult? result =
                                                    await FilePicker.platform
                                                        .pickFiles(
                                                  type: FileType.image,
                                                );

                                                if (result != null) {
                                                  setState(() {
                                                    _filePath = result
                                                        .files.single.path;
                                                  });
                                                  field.didChange(_filePath);
                                                }
                                              },
                                              child: Text('Odaberite sliku'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.5,
                            height: 400,
                            color: Colors.grey,
                            margin: EdgeInsets.only(left: 20, right: 40),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormBuilderTextField(
                                  name: 'idNavigation.ime',
                                  decoration: InputDecoration(
                                    labelText: 'Ime',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Ime je obavezno'),
                                    FormBuilderValidators.minLength(2,
                                        errorText:
                                            'Ime mora imati najmanje 2 znaka'),
                                    FormBuilderValidators.maxLength(50,
                                        errorText:
                                            'Ime može imati najviše 50 znakova'),
                                  ]),
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
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Prezime je obavezno'),
                                    FormBuilderValidators.minLength(2,
                                        errorText:
                                            'Prezime mora imati najmanje 2 znaka'),
                                    FormBuilderValidators.maxLength(50,
                                        errorText:
                                            'Prezime može imati najviše 50 znakova'),
                                  ]),
                                ),
                                SizedBox(height: 20),
                                FormBuilderTextField(
                                  name: 'idNavigation.email',
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'korisnik@email.com',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Email je obavezan'),
                                    FormBuilderValidators.email(
                                        errorText:
                                            'Neispravan format email adrese.\nPrimjer: korisnik@email.com'),
                                  ]),
                                ),
                                SizedBox(height: 20),
                                FormBuilderTextField(
                                  name: 'idNavigation.korisnickoIme',
                                  decoration: InputDecoration(
                                    labelText: 'Korisničko ime',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText:
                                            'Korisničko ime je obavezno'),
                                    FormBuilderValidators.minLength(5,
                                        errorText:
                                            'Korisničko ime mora imati najmanje 5 znakova'),
                                    FormBuilderValidators.maxLength(50,
                                        errorText:
                                            'Korisničko ime može imati najviše 50 znakova'),
                                  ]),
                                ),
                                SizedBox(height: 20),
                                FormBuilderTextField(
                                  name: 'idNavigation.password',
                                  decoration: const InputDecoration(
                                    labelText: 'Šifra',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    errorMaxLines: 3,
                                    suffixIcon: Tooltip(
                                      message:
                                          'Šifra mora sadržavati barem jedno veliko slovo, jedno malo slovo i jednu znamenku.',
                                      child: Icon(Icons.info_outline),
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Šifra je obavezna.'),
                                    FormBuilderValidators.minLength(8,
                                        errorText:
                                            'Šifra mora imati najmanje 8 znakova.'),
                                    FormBuilderValidators.maxLength(15,
                                        errorText:
                                            'Šifra može imati najviše 15 znakova.'),
                                    FormBuilderValidators.match(
                                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,15}$',
                                      errorText:
                                          'Šifra mora sadržavati barem jedno veliko slovo, jedno malo slovo i jednu znamenku.',
                                    ),
                                  ]),
                                ),
                                SizedBox(height: 20),
                                FormBuilderTextField(
                                  name: 'idNavigation.passwordPotvrda',
                                  decoration: InputDecoration(
                                    labelText: 'Potvrdi šifru',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Potvrda šifre je obavezna.';
                                    } else if (val !=
                                        _basicInfoFormKey
                                            .currentState
                                            ?.fields['idNavigation.password']
                                            ?.value) {
                                      return 'Šifra se ne podudara.';
                                    }
                                    return null;
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
              Step(
                title: Text('Podaci o studiju'),
                isActive: _currentStep >= 1,
                state:
                    _currentStep == 1 ? StepState.editing : StepState.complete,
                content: FormBuilder(
                  key: _studyInfoFormKey,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'brojIndeksa',
                                  decoration: InputDecoration(
                                    labelText: 'Broj indeksa',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText: 'Broj indeksa je obavezan'),
                                    FormBuilderValidators.maxLength(20,
                                        errorText:
                                            'Broj indeksa može imati najviše 20 znakova'),
                                  ]),
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: FormBuilderTextField(
                                  name: 'prosjecnaOcjena',
                                  decoration: InputDecoration(
                                    labelText: 'Prosječna ocjena',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText:
                                            'Prosječna ocjena je obavezna'),
                                    FormBuilderValidators.numeric(
                                        errorText:
                                            'Prosječna ocjena mora biti numerička vrijednost'),
                                    FormBuilderValidators.min(6.0,
                                        errorText:
                                            'Prosječna ocjena mora biti najmanje 6.0'),
                                    FormBuilderValidators.max(10.0,
                                        errorText:
                                            'Prosječna ocjena može biti najviše 10.0'),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          FormBuilderDropdown<String>(
                            name: 'univerzitetId',
                            decoration: InputDecoration(
                              labelText: 'Univerzitet',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            dropdownColor: Colors.white,
                            validator: FormBuilderValidators.required(
                                errorText: 'Univerzitet je obavezan'),
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
                                selectedUniverzitet = widget
                                    .univerzitetiResult?.result
                                    .firstWhere((univerzitet) =>
                                        univerzitet.id.toString() ==
                                        selectedUniverzitetId);
                                selectedFakultet = null;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          FormBuilderDropdown<String>(
                            name: 'fakultetId',
                            decoration: InputDecoration(
                              labelText: 'Fakultet',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            dropdownColor: Colors.white,
                            validator: FormBuilderValidators.required(
                                errorText: 'Fakultet je obavezan'),
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
                          SizedBox(height: 20),
                          FormBuilderDropdown<String>(
                            name: 'smjerId',
                            decoration: InputDecoration(
                              labelText: 'Smjer',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            dropdownColor: Colors.white,
                            validator: FormBuilderValidators.required(
                                errorText: 'Smjer je obavezan'),
                            enabled: selectedFakultet != null,
                            items: (selectedFakultet?.smjerovi ?? [])
                                    .map((Smjer smjer) => DropdownMenuItem(
                                          value: smjer.id.toString(),
                                          child: Text(smjer.naziv ?? ''),
                                        ))
                                    .toList() ??
                                [],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: FormBuilderDropdown<int>(
                                  name: 'godinaStudija',
                                  decoration: InputDecoration(
                                    labelText: 'Godina studija',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  dropdownColor: Colors.white,
                                  validator: FormBuilderValidators.required(
                                      errorText: 'Godina studija je obavezna'),
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
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: FormBuilderDropdown<String>(
                                  name: 'nacinStudiranjaId',
                                  decoration: InputDecoration(
                                    labelText: 'Način studiranja',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  dropdownColor: Colors.white,
                                  validator: FormBuilderValidators.required(
                                      errorText:
                                          'Način studiranja je obavezan'),
                                  items: widget.naciniStudiranjaResult?.result
                                          .map((NacinStudiranja
                                                  nacinStudiranja) =>
                                              DropdownMenuItem(
                                                value: nacinStudiranja.id
                                                    .toString(),
                                                child: Text(
                                                    nacinStudiranja.naziv ??
                                                        ''),
                                              ))
                                          .toList() ??
                                      [],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
