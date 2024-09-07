import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/models/Student/student.dart';
import 'package:studentoglasi_mobile/screens/main_screen.dart';
import 'package:studentoglasi_mobile/screens/registration_form.dart';

import '../utils/util.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late StudentiProvider _studentProvider;
  Student? student;

  Future<void> _login() async {
    var username = _usernameController.text;
    var password = _passwordController.text;

    Authorization.username = username;
    Authorization.password = password;

    try {
      await _studentProvider.getCurrentStudent();

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ObjavaListScreen()),
      );
    } on Exception {
      String error = "Pogrešno korisničko ime ili lozinka";
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Greška"),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _studentProvider = context.read<StudentiProvider>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('StudentOglasi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25, 
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, 
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100), 
              Icon(Icons.school,
                  size: 80, color: Colors.blueAccent),
              SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Korisničko ime',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Lozinka',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Prijavi se', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegistrationForm()),
                  );
                },
                child: Text(
                  'Nemaš korisnički račun? Kreiraj novi račun.',
                  style: TextStyle(color: Colors.blueAccent), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
