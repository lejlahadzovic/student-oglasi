import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
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
  
  // Variables to hold form data
  Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    _prijavaPraksaProvider = context.read<PrijavePraksaProvider>();
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
        'praksaId': widget.internship.id,
        'propratnoPismo':_formData['propratnoPismo'],
        'dokumentacija': _formData['dokumentacija'],
        'cv': _formData['cv'] ?? '', // Default to empty string if null
      };

      _sendDataToApi(requestData);
    } else {
      print('Form is not valid');
    }
  }

  void _sendDataToApi(Map<String, dynamic> formData) async {
    print('Sending data to API: $formData');
    try {
      await _prijavaPraksaProvider.insertJsonData(formData);

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
        title: Text('Apply for Internship'),
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
                name: 'propratnoPismo',
                decoration: InputDecoration(labelText: 'PropratnoPismo'),
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