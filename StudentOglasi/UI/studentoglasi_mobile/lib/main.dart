import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/screens/login_screen.dart';
import 'providers/kategorije_provider.dart';
import 'providers/objave_provider.dart';
import 'screens/objave_screen.dart';
import 'widgets/menu.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObjaveProvider()),
        ChangeNotifierProvider(create: (_) => KategorijaProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Oglasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => ObjavaListScreen(),
        '/profile':(context) => ProfileScreen(),
        '/logout':(context) => LoginScreen(),
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text('Welcome to the Profile Screen'),
      ),
    );
  }
}
