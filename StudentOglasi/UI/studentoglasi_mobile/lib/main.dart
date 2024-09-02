import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/providers/komentari_provider.dart';
import 'package:studentoglasi_mobile/providers/like_provider.dart';
import 'package:studentoglasi_mobile/providers/ocjene_provider.dart';
import 'package:studentoglasi_mobile/providers/oglasi_provider.dart';
import 'package:studentoglasi_mobile/providers/organizacije_provider.dart';
import 'package:studentoglasi_mobile/providers/prakse_provider.dart';
import 'package:studentoglasi_mobile/providers/rezervacije_provider.dart';
import 'package:studentoglasi_mobile/providers/smjestaji_provider.dart';
import 'package:studentoglasi_mobile/providers/prijavestipendija_provider.dart';
import 'package:studentoglasi_mobile/providers/statusoglasi_provider.dart';
import 'package:studentoglasi_mobile/providers/statusprijave_provider.dart';
import 'package:studentoglasi_mobile/providers/stipendije_provider.dart';
import 'package:studentoglasi_mobile/providers/stipenditori_provider.dart';
import 'package:studentoglasi_mobile/screens/applications_screen.dart';
import 'package:studentoglasi_mobile/screens/users_list_screen.dart';
import 'package:studentoglasi_mobile/screens/login_screen.dart';
import 'package:studentoglasi_mobile/screens/profile_screen.dart';
import 'package:studentoglasi_mobile/services/database_service.dart';
import 'package:studentoglasi_mobile/services/media_service.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import 'providers/kategorije_provider.dart';
import 'providers/objave_provider.dart';
import 'providers/prijavepraksa_provider.dart';
import 'screens/main_screen.dart';
import 'package:studentoglasi_mobile/providers/nacin_studiranja_provider.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/providers/univerziteti_provider.dart';

import 'services/storage_service.dart';

void main() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton<DatabaseService>(() => DatabaseService());
  getIt.registerLazySingleton<MediaService>(() => MediaService());
  getIt.registerLazySingleton<StorageService>(() => StorageService());
  await setup();
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
        ChangeNotifierProvider(create: (context) => SmjestajiProvider()),
        ChangeNotifierProvider(create: (context) => LikeProvider()),
        ChangeNotifierProvider(create: (context) => KomentariProvider()),
        ChangeNotifierProvider(create: (context) => OcjeneProvider()),
        ChangeNotifierProvider(create: (context) => StatusPrijaveProvider()),
        ChangeNotifierProvider(create: (context) => PrijaveStipendijaProvider()),
        ChangeNotifierProvider(create: (context) => PrijavePraksaProvider()),
        ChangeNotifierProvider(create: (context) => RezervacijeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
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
        '/prijave':(context) => ApplicationsScreen(),
        '/chat':(context)=>UsersListScreen(),
      },
    );
  }
}
