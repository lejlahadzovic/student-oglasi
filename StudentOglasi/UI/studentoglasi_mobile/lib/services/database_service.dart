import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentoglasi_mobile/models/Chat/chat.dart';
import 'package:studentoglasi_mobile/utils/util.dart';

import '../models/Korisnik/korisnik.dart';
import '../models/Message/message.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? _usersCollection;
  CollectionReference? _chatCollection;

  DatabaseService() {}

  Future<void> createUserProfile({required Korisnik korisnik}) async {
    await _usersCollection?.doc(korisnik.id.toString()).set(korisnik);
  }

  Future<bool> checkChatExists(String id1, String id2) async {
     _chatCollection = _firebaseFirestore
        .collection('chats')
        .withConverter<Chat>(
            fromFirestore: (snapshots, _) => Chat.fromJson(snapshots.data()!),
            toFirestore: (chat, _) => chat.toJson());
    String chatID = generateChatID(id1: id1, id2: id2);
    final result = await _chatCollection?.doc(chatID).get();
    if (result != null) {
      return result.exists;
    }
    else {
      return false;
    }
  }

  Future<void> createNewChat(String id1, String id2) async {
    String chatID = generateChatID(id1: id1, id2: id2);
    final docRef = _chatCollection?.doc(chatID);
    final chat = Chat(
      id: chatID,
      participants: [id1, id2],
      messages: [],
    );
    await docRef?.set(chat);
  }

  Future<void> sendChatMessage(String id1, String id2, Message message) async {
    String chatID = generateChatID(id1: id1, id2: id2);
    final docRef = _chatCollection?.doc(chatID);
    await docRef?.update({
      "messages": FieldValue.arrayUnion(
        [
          message.toJson(),
        ],
      )
    });
  }

  Stream<DocumentSnapshot<Chat>> getChatData (String id1, String id2) {
    String chatID = generateChatID(id1: id1, id2: id2);
    return  _chatCollection?.doc(chatID).snapshots() 
    as Stream<DocumentSnapshot<Chat>>;
  }
}
