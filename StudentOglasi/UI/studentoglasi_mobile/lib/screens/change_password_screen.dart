import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/utils/util.dart';

class ChangePasswordScreen extends StatefulWidget {
  final int? userId;

  ChangePasswordScreen({Key? key, this.userId}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _changePassword() async {
    if (_formKey.currentState!.saveAndValidate()) {
      var values = _formKey.currentState!.value;
      var userId = widget.userId;

      var request = {
        'currentPassword': values['currentPassword'],
        'newPassword': values['newPassword'],
        'confirmPassword': values['confirmPassword'],
      };

      if (userId != null) {
        try {
          await context.read<StudentiProvider>().changePassword(userId, request);
              
          Authorization.password = values['newPassword'];

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Šifra je uspješno promijenjena!'),
            backgroundColor: Colors.lightGreen,
          ));
          Navigator.pop(context);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Promjena šifre nije uspjela. Molimo provjerite vašu trenutnu šifru i pokušajte ponovo.'),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promjena šifre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'currentPassword',
                decoration: InputDecoration(
                  labelText: 'Stara šifra',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16),
              FormBuilderTextField(
                name: 'newPassword',
                decoration: InputDecoration(
                  labelText: 'Nova šifra',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16),
              FormBuilderTextField(
                name: 'confirmPassword',
                decoration: InputDecoration(
                  labelText: 'Potvrdite novu šifru',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
                validator: (val) {
                  if (val !=
                      _formKey.currentState?.fields['newPassword']?.value) {
                    return 'Šifre se ne poklapaju';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _changePassword,
                child: Text('Promijeni šifru'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
