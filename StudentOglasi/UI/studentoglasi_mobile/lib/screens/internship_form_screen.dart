import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker/file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../models/Oglas/oglas.dart';
import '../providers/prijavepraksa_provider.dart';
import '../screens/main_screen.dart';

class PrijavaPraksaFormScreen extends StatefulWidget {
  final Oglas internship;

  const PrijavaPraksaFormScreen({Key? key, required this.internship}) : super(key: key);

  @override
  _PrijavaPraksaFormScreenState createState() => _PrijavaPraksaFormScreenState();
}

class _PrijavaPraksaFormScreenState extends State<PrijavaPraksaFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late PrijavePraksaProvider _prijavaPraksaProvider;

  Map<String, dynamic> _formData = {};

  final TextEditingController _cvController = TextEditingController();
  final TextEditingController _certifikatiController = TextEditingController();
  final TextEditingController _propratnoPismoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _prijavaPraksaProvider = context.read<PrijavePraksaProvider>();
  }

  @override
  void dispose() {
    _cvController.dispose();
    _certifikatiController.dispose();
    _propratnoPismoController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(String fieldName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      setState(() {
        String filePath = result.files.single.path!;
        String fileName = result.files.single.name;
        if (fieldName == 'cv') {
          _cvController.text = fileName;
          _formData['cv'] = filePath;
        } else if (fieldName == 'certifikati') {
          _certifikatiController.text = fileName;
          _formData['certifikati'] = filePath;
        } else if (fieldName == 'propratnoPismo') {
          _propratnoPismoController.text = fileName;
          _formData['propratnoPismo'] = filePath;
        }
      });
    } else {
      print('No file selected or file path is null');
    }
  }

  void _saveForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      _formData = {
        ..._formKey.currentState?.value ?? {},
        'cv': _formData['cv'],
        'certifikati': _formData['certifikati'],
        'propratnoPismo': _formData['propratnoPismo'],
      };
    } else {
      print('Form validation failed');
    }
  }

  void _submitForm() async {
    _saveForm();

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final requestData = {
        'praksaId': widget.internship.id,
        'propratnoPismo': _formData['propratnoPismo'],
        'certifikati': _formData['certifikati'],
        'cv': _formData['cv'] ?? '',
      };

      _sendDataToApi(requestData);
    } else {
      print('Form is not valid');
    }
  }

  void _sendDataToApi(Map<String, dynamic> formData) async {
    print('Sending data to API: $formData');
    try {
      await _prijavaPraksaProvider.insertFileMultipartData(formData);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ObjavaListScreen(),
        ),
      );
    } catch (e) {
      print('Error submitting application: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Greška pri slanju prijave: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prijavi se na praksu'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Certifikati', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              FormBuilderTextField(
                name: 'certifikati',
                controller: _certifikatiController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Odaberite certifikate',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () => _pickFile('certifikati'),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(errorText: 'Odaberite certifikate'),
              ),
              SizedBox(height: 20),

              Text('CV', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              FormBuilderTextField(
                name: 'cv',
                controller: _cvController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Odaberite CV dokument',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () => _pickFile('cv'),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(errorText: 'Odaberite CV dokument'),
              ),
              SizedBox(height: 20),
              Text('Propratno pismo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              FormBuilderTextField(
                name: 'propratnoPismo',
                controller: _propratnoPismoController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Odaberite propratno pismo',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () => _pickFile('propratnoPismo'),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(errorText: 'Odaberite propratno pismo'),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Prijavi se'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
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
