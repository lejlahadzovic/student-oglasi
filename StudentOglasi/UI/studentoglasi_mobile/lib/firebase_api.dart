import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final List<RemoteMessage> _notifications = [];

  List<RemoteMessage> get notifications => _notifications;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.instance.subscribeToTopic("news");
  }
}