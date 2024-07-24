import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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

      try {
        await _studentiProvider.updateMultipartData(
            _currentStudent!.id!, request);

        Authorization.username = request['idNavigation.korisnickoIme'];

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
                child: Text("OK"),
              )
            ],
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete the form properly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'Osnovni podaci'), Tab(text: 'Podaci o studijama')],
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
                MaterialPageRoute(builder: (context) => ChangePasswordScreen(userId: _currentStudent?.id)),
              );
            },
            icon: Icon(Icons.lock),
            label: Text('Promijeni šifru'),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'idNavigation.ime',
            readOnly: !_isEditing,
            decoration: InputDecoration(
              labelText: 'Ime',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'idNavigation.prezime',
            readOnly: !_isEditing,
            decoration: InputDecoration(
              labelText: 'Prezime',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'idNavigation.korisnickoIme',
            readOnly: !_isEditing,
            decoration: InputDecoration(
              labelText: 'Korisničko Ime',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 16),
          FormBuilderTextField(
            name: 'idNavigation.email',
            readOnly: !_isEditing,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
            readOnly: !_isEditing,
            decoration: InputDecoration(
              labelText: 'Broj Indeksa',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
            readOnly: !_isEditing,
            decoration: InputDecoration(
              labelText: 'Prosječna Ocjena',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 16),
          FormBuilderDropdown<String>(
            name: 'nacinStudiranjaId',
            decoration: InputDecoration(
              labelText: 'Način studiranja',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
