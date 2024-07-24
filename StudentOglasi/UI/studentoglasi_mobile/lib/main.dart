import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/providers/oglasi_provider.dart';
import 'package:studentoglasi_mobile/providers/organizacije_provider.dart';
import 'package:studentoglasi_mobile/providers/prakse_provider.dart';
import 'package:studentoglasi_mobile/providers/statusoglasi_provider.dart';
import 'package:studentoglasi_mobile/providers/stipendije_provider.dart';
import 'package:studentoglasi_mobile/providers/stipenditori_provider.dart';
import 'package:studentoglasi_mobile/screens/login_screen.dart';
import 'package:studentoglasi_mobile/screens/profile_screen.dart';
import 'providers/kategorije_provider.dart';
import 'providers/objave_provider.dart';
import 'screens/main_screen.dart';
import 'package:studentoglasi_mobile/providers/nacin_studiranja_provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/providers/univerziteti_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ObjaveProvider()),
        ChangeNotifierProvider(create: (_) => KategorijaProvider()),
        ChangeNotifierProvider(create: (context) => UniverzitetiProvider()),
        ChangeNotifierProvider(create: (context) => NacinStudiranjaProvider()),
        ChangeNotifierProvider(create: (context) => StudentiProvider()),
        ChangeNotifierProvider(create: (context) => StipendijeProvider()),
        ChangeNotifierProvider(create: (context) => OglasiProvider()),
        ChangeNotifierProvider(create: (context) => StatusOglasiProvider()),
        ChangeNotifierProvider(create: (context) => StipenditoriProvider()),
         ChangeNotifierProvider(create: (context) => PraksaProvider()),
        ChangeNotifierProvider(create: (context) => OrganizacijeProvider()),
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
        '/profile': (context) => ProfileScreen(),
        '/logout': (context) => LoginScreen(),
      },
    );
  }
}
