import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/providers/prijavestipendija_provider.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import '../models/Oglas/oglas.dart';
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
  
  // Variables to hold form data
  Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    _prijaveStipendijaProvider = context.read<PrijaveStipendijaProvider>();
  }

  void _saveForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      _formData = _formKey.currentState?.value ?? {};
    }
  }

  void _loadForm() {
    _formKey.currentState?.reset();
    _formKey.currentState?.patchValue(_formData);
  }

  void _submitForm() async {
    _saveForm();  // Save the form data
    
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final requestData = {
        'stipendijaId': widget.scholarship.id,
        'dokumentacija': _formData['dokumentacija'],
        'cv': _formData['cv'] ?? '', // Default to empty string if null
        'prosjekOcjena': double.tryParse(_formData['prosjekOcjena'] ?? '') ?? 0.0,
      };

      _sendDataToApi(requestData);
    } else {
      print('Form is not valid');
    }
  }

  void _sendDataToApi(Map<String, dynamic> formData) async {
    print('Sending data to API: $formData');
    try {
      await _prijaveStipendijaProvider.insertJsonData(formData);

      // Assuming that the Authorization and other details will be handled here if necessary
      Authorization.username = 'your_username'; // Example usage
      Authorization.password = 'your_password'; // Example usage

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ObjavaListScreen(),
        ),
      );
    } catch (e) {
      print('Error inserting scholarship application: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting application: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply for Scholarship'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'dokumentacija',
                decoration: InputDecoration(labelText: 'Dokumentacija'),
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'cv',
                decoration: InputDecoration(labelText: 'CV'),
              ),
              FormBuilderTextField(
                name: 'prosjekOcjena',
                decoration: InputDecoration(labelText: 'Prosjek Ocjena'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(5.0),
                  FormBuilderValidators.max(10.0),
                ]),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}