import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
import 'package:studentoglasi_mobile/models/Student/student.dart';
import 'package:studentoglasi_mobile/providers/univerziteti_provider.dart';
import 'package:studentoglasi_mobile/screens/change_password_screen.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import 'package:studentoglasi_mobile/widgets/menu.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  Student? _currentStudent;
  bool _isLoading = true;
  bool _isEditing = false;
  SearchResult<Univerzitet>? _univerziteti;
  SearchResult<NacinStudiranja>? _naciniStudiranja;

  late StudentiProvider _studentiProvider;
  late TabController _tabController;
  late UniverzitetiProvider _univerzitetiProvider;
  late NacinStudiranjaProvider _nacinStudiranjaProvider;

  Univerzitet? _selectedUniverzitet;
  Fakultet? _selectedFakultet;
  Smjer? _selectedSmjer;

  final List<int> godineStudija = [1, 2, 3, 4];

  String? _filePath;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _studentiProvider = context.read<StudentiProvider>();
    _univerzitetiProvider = context.read<UniverzitetiProvider>();
    _nacinStudiranjaProvider = context.read<NacinStudiranjaProvider>();
    _fetchData();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _fetchData() async {
    try {
      final student = await _studentiProvider.getCurrentStudent();
      final univerziteti = await _univerzitetiProvider.get();
      final naciniStudiranja = await _nacinStudiranjaProvider.get();
      setState(() {
        _currentStudent = student;
        _univerziteti = univerziteti;
        _naciniStudiranja = naciniStudiranja;
        _isLoading = false;

        if (_currentStudent?.fakultet != null) {
          _selectedUniverzitet = _univerziteti?.result.firstWhere(
              (u) => u.id == _currentStudent!.fakultet.univerzitetId);
          _selectedFakultet = _selectedUniverzitet?.fakultetis!
              .firstWhere((f) => f.id == _currentStudent!.fakultet.id);
          _selectedSmjer = _selectedFakultet?.smjerovi!
              .firstWhere((s) => s.id == _currentStudent!.smjer.id);
        }
        if (_currentStudent?.idNavigation.slika != null) {
          _imageUrl = FilePathManager.constructUrl(
              _currentStudent!.idNavigation.slika!);
        }
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching current student: $error");
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.saveAndValidate()) {
      var request = Map<String, dynamic>.from(_formKey.currentState!.value);

      String newUsername = request['idNavigation.korisnickoIme'];

      bool isUsernameTaken =
          await _studentiProvider.isUsernameTaken(newUsername);
      if (isUsernameTaken &&
          newUsername != _currentStudent?.idNavigation.korisnickoIme) {
        setState(() {
          _formKey.currentState!.fields['idNavigation.korisnickoIme']
              ?.invalidate('Korisničko ime je zauzeto.');
          _tabController.animateTo(0);
        });
        return;
      }

      request['brojIndeksa'] ??= _currentStudent?.brojIndeksa;
      request['godinaStudija'] ??= _currentStudent?.godinaStudija;
      request['prosjecnaOcjena'] ??=
          _currentStudent?.prosjecnaOcjena.toString();
      request['univerzitetId'] ??= _selectedUniverzitet?.id.toString();
      request['fakultetId'] ??= _selectedFakultet?.id.toString();
      request['smjerId'] ??= _selectedSmjer?.id.toString();
      request['nacinStudiranjaId'] ??=
          _currentStudent?.nacinStudiranja.id.toString();

      try {
        await _studentiProvider.updateMultipartData(
            _currentStudent!.id!, request);

        setState(() {
          Authorization.username = request['idNavigation.korisnickoIme'];
          _isEditing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Podaci su uspješno sačuvani!'),
          backgroundColor: Colors.lightGreen,
        ));
      } on Exception catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("Greška"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              )
            ],
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Molimo vas da ispravno popunite formu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moj profil'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'Osnovni podaci'), Tab(text: 'Podaci o studijama')],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
      ),
      drawer: DrawerMenu(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _currentStudent == null
              ? Center(child: Text('Failed to load student data'))
              : FormBuilder(
                  key: _formKey,
                  initialValue: {
                    'idNavigation.ime': _currentStudent?.idNavigation.ime,
                    'idNavigation.prezime':
                        _currentStudent?.idNavigation.prezime,
                    'idNavigation.korisnickoIme':
                        _currentStudent?.idNavigation.korisnickoIme,
                    'idNavigation.email': _currentStudent?.idNavigation.email,
                    'brojIndeksa': _currentStudent?.brojIndeksa,
                    'godinaStudija': _currentStudent?.godinaStudija,
                    'prosjecnaOcjena':
                        _currentStudent?.prosjecnaOcjena.toString(),
                    'univerzitetId': _selectedUniverzitet?.id.toString(),
                    'fakultetId': _selectedFakultet?.id.toString(),
                    'smjerId': _selectedSmjer?.id.toString(),
                    'nacinStudiranjaId':
                        _currentStudent?.nacinStudiranja.id.toString(),
                  },
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildBasicInfoTab(),
                      _buildStudyInfoTab(),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isEditing ? _saveChanges : _toggleEdit,
        icon: Icon(_isEditing ? Icons.check : Icons.edit),
        label: Text(_isEditing ? 'Sačuvaj' : 'Uredi'),
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          FormBuilderField(
            name: 'filePath',
            builder: (FormFieldState<dynamic> field) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _isEditing
                          ? () async {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.image);

                              if (result != null) {
                                setState(() {
                                  _filePath = result.files.single.path;
                                });
                                field.didChange(_filePath);
                              }
                            }
                          : null,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: _filePath != null
                                ? FileImage(File(_filePath!))
                                : _imageUrl != null
                                    ? NetworkImage(_imageUrl!)
                                    : AssetImage('assets/images/user_icon.png')
                                        as ImageProvider,
                          ),
                          if (_isEditing)
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  'Promijeni\nsliku',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (field.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        field.errorText ?? '',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              );
            },
          ),
          Text(
            '${_currentStudent!.idNavigation.ime} ${_currentStudent!.idNavigation.prezime}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChangePasswordScreen(userId: _currentStudent?.id)),
              );
            },
            icon: Icon(Icons.lock),
            label: Text('Promijeni šifru'),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'idNavigation.ime',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Ime',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Ime je obavezno'),
              FormBuilderValidators.minLength(2,
                  errorText: 'Ime mora imati najmanje 2 znaka'),
              FormBuilderValidators.maxLength(50,
                  errorText: 'Ime može imati najviše 50 znakova'),
            ]),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'idNavigation.prezime',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Prezime',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Prezime je obavezno'),
              FormBuilderValidators.minLength(2,
                  errorText: 'Prezime mora imati najmanje 2 znaka'),
              FormBuilderValidators.maxLength(50,
                  errorText: 'Prezime može imati najviše 50 znakova'),
            ]),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'idNavigation.korisnickoIme',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Korisničko Ime',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'Korisničko ime je obavezno'),
              FormBuilderValidators.minLength(5,
                  errorText: 'Korisničko ime mora imati najmanje 5 znakova'),
              FormBuilderValidators.maxLength(50,
                  errorText: 'Korisničko ime može imati najviše 50 znakova'),
            ]),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'idNavigation.email',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: 'Email je obavezan.',
              ),
              FormBuilderValidators.email(
                errorText: 'Unesite ispravan format email adrese.',
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyInfoTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          FormBuilderDropdown<String>(
            name: 'univerzitetId',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Univerzitet',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.required(
                errorText: 'Univerzitet je obavezan'),
            items: _univerziteti?.result
                    .map((univerzitet) => DropdownMenuItem(
                          value: univerzitet.id.toString(),
                          child: Text(univerzitet.naziv ?? ''),
                        ))
                    .toList() ??
                [],
            onChanged: (selectedUniverzitetId) {
              setState(() {
                _selectedUniverzitet = _univerziteti?.result.firstWhere(
                    (univerzitet) =>
                        univerzitet.id.toString() == selectedUniverzitetId);
                _selectedFakultet = null;
                _selectedSmjer = null;
              });
            },
          ),
          SizedBox(height: 16),
          FormBuilderDropdown<String>(
            name: 'fakultetId',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Fakultet',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.required(
                errorText: 'Fakultet je obavezan'),
            items: _selectedUniverzitet?.fakultetis
                    ?.map((fakultet) => DropdownMenuItem(
                          value: fakultet.id.toString(),
                          child: Text(fakultet.naziv ?? ''),
                        ))
                    .toList() ??
                [],
            onChanged: (selectedFakultetId) {
              setState(() {
                _selectedFakultet = _selectedUniverzitet?.fakultetis
                    ?.firstWhere((fakultet) =>
                        fakultet.id.toString() == selectedFakultetId);
                _selectedSmjer = null;
              });
            },
          ),
          SizedBox(height: 16),
          FormBuilderDropdown<String>(
            name: 'smjerId',
            enabled: _isEditing && _selectedFakultet != null,
            decoration: InputDecoration(
              labelText: 'Smjer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator:
                FormBuilderValidators.required(errorText: 'Smjer je obavezan'),
            items: _selectedFakultet?.smjerovi
                    ?.map((smjer) => DropdownMenuItem(
                          value: smjer.id.toString(),
                          child: Text(smjer.naziv ?? ''),
                        ))
                    .toList() ??
                [],
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'brojIndeksa',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Broj Indeksa',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                  errorText: 'Broj indeksa je obavezan'),
              FormBuilderValidators.maxLength(20,
                  errorText: 'Broj indeksa može imati najviše 20 znakova'),
            ]),
          ),
          SizedBox(height: 16),
          FormBuilderDropdown<int>(
            name: 'godinaStudija',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Godina Studija',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.required(
                errorText: 'Godina studija je obavezna'),
            items: godineStudija
                .map((godina) => DropdownMenuItem(
                      value: godina,
                      child: Text('$godina. godina'),
                    ))
                .toList(),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'prosjecnaOcjena',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Prosječna Ocjena',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.numeric(
                errorText: 'Unesena vrijednost mora biti numerička.',
              ),
              FormBuilderValidators.min(
                6.0,
                errorText: 'Unesena vrijednost mora biti najmanje 6.0.',
              ),
              FormBuilderValidators.max(
                10.0,
                errorText: 'Unesena vrijednost ne smije biti veća od 10.0.',
              ),
            ]),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          FormBuilderDropdown<String>(
            name: 'nacinStudiranjaId',
            enabled: _isEditing,
            decoration: InputDecoration(
              labelText: 'Način studiranja',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: FormBuilderValidators.required(
                errorText: 'Način studiranja je obavezan'),
            items: _naciniStudiranja?.result
                    .map((NacinStudiranja nacinStudiranja) => DropdownMenuItem(
                          value: nacinStudiranja.id.toString(),
                          child: Text(nacinStudiranja.naziv ?? ''),
                        ))
                    .toList() ??
                [],
          ),
        ],
      ),
    );
  }
}
