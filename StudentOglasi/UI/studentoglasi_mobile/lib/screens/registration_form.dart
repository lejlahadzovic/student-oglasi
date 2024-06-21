import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Fakultet/fakultet.dart';
import 'package:studentoglasi_mobile/models/NacinStudiranja/nacin_studiranja.dart';
import 'package:studentoglasi_mobile/models/Smjer/smjer.dart';
import 'package:studentoglasi_mobile/models/Univerzitet/univerzitet.dart';
import 'package:studentoglasi_mobile/models/search_result.dart';
import 'package:studentoglasi_mobile/providers/nacin_studiranja_provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/providers/univerziteti_provider.dart';
import 'package:studentoglasi_mobile/screens/objave_screen.dart';
import 'package:studentoglasi_mobile/utils/util.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _userFormKey = GlobalKey<FormBuilderState>();
  final _studentFormKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;
  SearchResult<Univerzitet>? univerziteti;
  SearchResult<NacinStudiranja>? naciniStudiranjaResult;
  late UniverzitetiProvider _univerzitetiProvider;
  late NacinStudiranjaProvider _nacinStudiranjaProvider;
  late StudentiProvider _studentiProvider;

  Univerzitet? selectedUniverzitet;
  Fakultet? selectedFakultet;
  List<Smjer> smjerovi = [];

  // Variables to hold form data
  Map<String, dynamic> _userFormData = {};
  Map<String, dynamic> _studentFormData = {};

  @override
  void initState() {
    super.initState();
    _univerzitetiProvider = context.read<UniverzitetiProvider>();
    _nacinStudiranjaProvider = context.read<NacinStudiranjaProvider>();
    _studentiProvider = context.read<StudentiProvider>();
    _fetchUniverziteti();
    _fetchNacinStudiranja();
  }

  Future<void> _fetchUniverziteti() async {
    try {
      var result = await _univerzitetiProvider.get();
      setState(() {
        univerziteti = result;
      });
    } catch (e) {
      print("Error fetching universities: $e");
    }
  }

  Future<void> _fetchNacinStudiranja() async {
    var naciniStudiranjaData = await _nacinStudiranjaProvider.get();
    setState(() {
      naciniStudiranjaResult = naciniStudiranjaData;
    });
  }

  void _saveUserForm() {
    if (_userFormKey.currentState?.saveAndValidate() ?? false) {
      _userFormData = _userFormKey.currentState?.value ?? {};
    }
  }

  void _saveStudentForm() {
    if (_studentFormKey.currentState?.saveAndValidate() ?? false) {
      _studentFormData = _studentFormKey.currentState?.value ?? {};
    }
  }

  void _loadUserForm() {
    _userFormKey.currentState?.reset();
    _userFormKey.currentState?.patchValue(_userFormData);
  }

  void _loadStudentForm() {
    _studentFormKey.currentState?.reset();
    _studentFormKey.currentState?.patchValue(_studentFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registracija korisnika'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            if (_currentStep == 0) {
              _saveUserForm();
              if (_userFormKey.currentState?.saveAndValidate() ?? false) {
                _currentStep = step;
                _loadStudentForm();
              }
            } else {
              _saveStudentForm();
              _currentStep = step;
              _loadStudentForm();
            }
          });
        },
        onStepContinue: () {
          setState(() {
            if (_currentStep == 0) {
              _saveUserForm();
              if (_userFormKey.currentState?.saveAndValidate() ?? false) {
                _currentStep += 1;
                _loadStudentForm();
              }
            } else if (_currentStep == 1) {
              _saveStudentForm();
              if (_studentFormKey.currentState?.saveAndValidate() ?? false) {
                // Handle form submission here
                print('User Form Values: $_userFormData');
                print('Student Form Values: $_studentFormData');

                // Prepare data to send to API
                var formData = {
                  'idNavigation.ime': _userFormData['ime'],
                  'idNavigation.prezime': _userFormData['prezime'],
                  'idNavigation.email': _userFormData['email'],
                  'idNavigation.korisnickoIme': _userFormData['korisnickoIme'],
                  'idNavigation.password': _userFormData['password'],
                  'idNavigation.passwordPotvrda':
                      _userFormData['passwordPotvrda'],
                  'brojIndeksa': _studentFormData['brojIndeksa'],
                  'godinaStudija': _studentFormData['godinaStudija'],
                  'prosjecnaOcjena': double.tryParse(
                      _studentFormData['prosjecnaOcjena'].toString()),
                  'fakultetId': selectedFakultet?.id,
                  'smjerId': (_studentFormData['smjer'] as Smjer).id,
                  'slika': null,
                  'nacinStudiranjaId':
                      (_studentFormData['nacinStudiranja'] as NacinStudiranja)
                          .id,
                };

                // Send formData to API
                _sendDataToApi(formData);
              }
            }
          });
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
              _loadUserForm();
            });
          }
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            children: <Widget>[
              if (_currentStep == 1)
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text('Sačuvaj'),
                )
              else
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text('Nastavi'),
                ),
              if (_currentStep > 0)
                TextButton(
                  onPressed: details.onStepCancel,
                  child: Text('Nazad'),
                ),
            ],
          );
        },
        steps: [
          Step(
            title: Text('Korisnički podaci'),
            isActive: _currentStep == 0,
            content: FormBuilder(
              key: _userFormKey,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'ime',
                    decoration: InputDecoration(labelText: 'Ime'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                      FormBuilderValidators.maxLength(50),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'prezime',
                    decoration: InputDecoration(labelText: 'Prezime'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(3),
                      FormBuilderValidators.maxLength(50),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                  ),
                  FormBuilderTextField(
                    name: 'korisnickoIme',
                    decoration: InputDecoration(labelText: 'Korisničko Ime'),
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderTextField(
                    name: 'password',
                    decoration: InputDecoration(labelText: 'Lozinka'),
                    obscureText: true,
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderTextField(
                    name: 'passwordPotvrda',
                    decoration: InputDecoration(labelText: 'Potvrdite lozinku'),
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      (val) {
                        if (_userFormKey
                                .currentState?.fields['password']?.value !=
                            val) {
                          return "Lozinke se ne podudaraju";
                        }
                        return null;
                      },
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text('Podaci o studentu'),
            isActive: _currentStep == 1,
            content: FormBuilder(
              key: _studentFormKey,
              onChanged: () {
                _studentFormData = _studentFormKey.currentState?.value ?? {};
              },
              child: Column(
                children: [
                  FormBuilderDropdown<Univerzitet>(
                    name: 'univerzitet',
                    decoration: InputDecoration(labelText: 'Univerzitet'),
                    validator: FormBuilderValidators.required(),
                    onChanged: (Univerzitet? newValue) {
                      setState(() {
                        selectedUniverzitet = newValue;
                        selectedFakultet = null;
                        smjerovi = [];
                      });
                    },
                    items: univerziteti?.result
                            .map((univerzitet) => DropdownMenuItem<Univerzitet>(
                                  value: univerzitet,
                                  child: Text(univerzitet.naziv ?? ''),
                                ))
                            .toList() ??
                        [],
                  ),
                  FormBuilderDropdown<Fakultet>(
                    name: 'fakultet',
                    decoration: InputDecoration(labelText: 'Fakultet'),
                    validator: FormBuilderValidators.required(),
                    onChanged: (Fakultet? newValue) {
                      setState(() {
                        selectedFakultet = newValue;
                        smjerovi = newValue?.smjerovi ?? [];
                      });
                    },
                    items: selectedUniverzitet?.fakultetis
                            ?.map((fakultet) => DropdownMenuItem<Fakultet>(
                                  value: fakultet,
                                  child: Text(fakultet.naziv ?? ''),
                                ))
                            .toList() ??
                        [],
                  ),
                  FormBuilderDropdown<Smjer>(
                    name: 'smjer',
                    decoration: InputDecoration(labelText: 'Smjer'),
                    validator: FormBuilderValidators.required(),
                    items: smjerovi
                        .map((smjer) => DropdownMenuItem<Smjer>(
                              value: smjer,
                              child: Text(smjer.naziv ?? ''),
                            ))
                        .toList(),
                  ),
                  FormBuilderDropdown<NacinStudiranja>(
                    name: 'nacinStudiranja',
                    decoration: InputDecoration(labelText: 'Način Studiranja'),
                    validator: FormBuilderValidators.required(),
                    items: naciniStudiranjaResult?.result
                            .map((nacinStudiranja) =>
                                DropdownMenuItem<NacinStudiranja>(
                                  value: nacinStudiranja,
                                  child: Text(nacinStudiranja.naziv ?? ''),
                                ))
                            .toList() ??
                        [],
                  ),
                  FormBuilderTextField(
                    name: 'brojIndeksa',
                    decoration: InputDecoration(labelText: 'Broj Indeksa'),
                    validator: FormBuilderValidators.required(),
                  ),
                  FormBuilderDropdown<int>(
                    name: 'godinaStudija',
                    decoration: InputDecoration(labelText: 'Godina Studija'),
                    validator: FormBuilderValidators.required(),
                    items: [1, 2, 3, 4]
                        .map((year) => DropdownMenuItem<int>(
                              value: year,
                              child: Text('$year. godina'),
                            ))
                        .toList(),
                  ),
                  FormBuilderTextField(
                    name: 'prosjecnaOcjena',
                    decoration: InputDecoration(labelText: 'Prosječna Ocjena'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.min(5.0),
                      FormBuilderValidators.max(10.0),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendDataToApi(Map<String, dynamic> formData) async {
    print('Sending data to API: $formData');
    try {
      await _studentiProvider.insertMultipartData(formData);

      Authorization.username = formData['idNavigation.korisnickoIme'];
      Authorization.password = formData['idNavigation.password'];

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ObjavaListScreen(),
        ),
      );
    } catch (e) {
      print('Error inserting student: $e');
    }
  }
}
