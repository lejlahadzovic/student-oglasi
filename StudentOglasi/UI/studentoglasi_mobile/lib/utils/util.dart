import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:studentoglasi_mobile/firebase_options.dart';
import 'package:studentoglasi_mobile/services/database_service.dart';
import 'package:studentoglasi_mobile/services/media_service.dart';

class Authorization {
  static String? username;
  static String? password;
}

String formatNumber(dynamic) {
  var f = NumberFormat();

  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

class FilePathManager {
  static String baseUrl =
      "https://studentoglasirs2.blob.core.windows.net/files/";

  static String constructUrl(String fileName) {
    return baseUrl + fileName;
  }
}

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
   getIt.registerSingleton<MediaService>(
    MediaService(),
  );
}

String generateChatID({required String id1, required String id2}) {
  List ids = [id1, id2];
  ids.sort();
  String chatID = ids.fold("", (prevId, id) => "$prevId$id");
  return chatID;
}
