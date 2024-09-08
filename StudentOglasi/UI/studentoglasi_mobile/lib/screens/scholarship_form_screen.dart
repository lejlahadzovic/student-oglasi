import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../models/Oglas/oglas.dart';
import '../providers/prijavestipendija_provider.dart';
import '../screens/main_screen.dart';

class PrijavaStipendijaFormScreen extends StatefulWidget {
  final Oglas scholarship;

  const PrijavaStipendijaFormScreen({Key? key, required this.scholarship}) : super(key: key);

  @override
  _PrijavaStipendijaFormScreenState createState() => _PrijavaStipendijaFormScreenState();
}

class _PrijavaStipendijaFormScreenState extends State<PrijavaStipendijaFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late PrijaveStipendijaProvider _prijaveStipendijaProvider;

  Map<String, dynamic> _formData = {};

  final TextEditingController _cvController = TextEditingController();
  final TextEditingController _dokumentacijaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _prijaveStipendijaProvider = context.read<PrijaveStipendijaProvider>();
  }

  @override
  void dispose() {
    _cvController.dispose();
    _dokumentacijaController.dispose();
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
        } else if (fieldName == 'dokumentacija') {
          _dokumentacijaController.text = fileName;
          _formData['dokumentacija'] = filePath;
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
        'dokumentacija': _formData['dokumentacija'],
      };
    } else {
      print('Form validation failed');
    }
  }

  void _submitForm() async {
    _saveForm();

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final requestData = {
        'stipendijaId': widget.scholarship.id,
        'dokumentacija': _formData['dokumentacija'],
        'cv': _formData['cv'] ?? '',
        'prosjekOcjena': double.tryParse(_formData['prosjekOcjena'].toString()),
      };

      _sendDataToApi(requestData);
    } else {
      print('Form is not valid');
    }
  }

  void _sendDataToApi(Map<String, dynamic> formData) async {
    print('Sending data to API: $formData');
    try {
      await _prijaveStipendijaProvider.insertFileMultipartData(formData);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ObjavaListScreen(),
        ),
      );
    } catch (e) {
      print('Error submitting application: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting application: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prijavi se na stipendiju'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CV', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              FormBuilderTextField(
                name: 'cv',
                controller: _cvController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'CV',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () => _pickFile('cv'),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(errorText: 'Molimo Vas dodajte CV.'),
              ),
              SizedBox(height: 20),
              Text('Dokumentacija', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              FormBuilderTextField(
                name: 'dokumentacija',
                controller: _dokumentacijaController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Dokumentacija',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: () => _pickFile('dokumentacija'),
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(errorText: 'Molimo Vas dodajte dokumentaciju.'),
              ),
              SizedBox(height: 20),
              Text('Prosjek Ocjena', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              FormBuilderTextField(
                name: 'prosjekOcjena',
                decoration: InputDecoration(
                  hintText: 'Prosjek ocjena',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: 'Prosječna ocjena je obavezna'),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(5.0, errorText: 'Ocjena mora biti najmanje 6.0'),
                  FormBuilderValidators.max(10.0, errorText: 'Ocjena može biti najviše 10.0'),
                ]),
                keyboardType: TextInputType.number,
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
