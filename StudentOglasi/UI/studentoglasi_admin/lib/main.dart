// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_admin/providers/fakulteti_provider.dart';
import 'package:studentoglasi_admin/providers/gradovi_provider.dart';
import 'package:studentoglasi_admin/providers/kategorije_provider.dart';
import 'package:studentoglasi_admin/providers/nacin_studiranja_provider.dart';
import 'package:studentoglasi_admin/providers/objave_provider.dart';
import 'package:studentoglasi_admin/providers/oglasi_provider.dart';
import 'package:studentoglasi_admin/providers/organizacije_provider.dart';
import 'package:studentoglasi_admin/providers/slike_provider.dart';
import 'package:studentoglasi_admin/providers/smjestaji_provider.dart';
import 'package:studentoglasi_admin/providers/statusoglasi_provider.dart';
import 'package:studentoglasi_admin/providers/studenti_provider.dart';
import 'package:studentoglasi_admin/providers/tip_smjestaja_provider.dart';
import 'package:studentoglasi_admin/providers/univerziteti_provider.dart';
import 'package:studentoglasi_admin/screens/login.dart';
import 'package:studentoglasi_admin/providers/prakse_provider.dart';
import 'package:studentoglasi_admin/providers/stipendije_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ObjaveProvider()),
      ChangeNotifierProvider(create: (_) => KategorijaProvider()),
      ChangeNotifierProvider(create: (context) => PraksaProvider()),
      ChangeNotifierProvider(create: (_) => StatusOglasiProvider()),
      ChangeNotifierProvider(create: (context) => OrganizacijeProvider()),
      ChangeNotifierProvider(create: (context) => StipendijeProvider()),
      ChangeNotifierProvider(create: (context) => OglasiProvider()),
      ChangeNotifierProvider(create: (context) => StudentiProvider()),
      ChangeNotifierProvider(create: (context) => FakultetiProvider()),
      ChangeNotifierProvider(create: (context) => UniverzitetiProvider()),
      ChangeNotifierProvider(create: (context) => NacinStudiranjaProvider()),
      ChangeNotifierProvider(create: (context) => SmjestajiProvider()),
      ChangeNotifierProvider(create: (context) => GradoviProvider()),
      ChangeNotifierProvider(create: (context) => TipSmjestajaProvider()),
      ChangeNotifierProvider(create: (context) => SlikeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
