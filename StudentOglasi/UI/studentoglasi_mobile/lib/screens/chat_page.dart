import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:studentoglasi_mobile/models/Student/student.dart';
import 'package:studentoglasi_mobile/providers/studenti_provider.dart';
import 'package:studentoglasi_mobile/services/database_service.dart';
import 'package:studentoglasi_mobile/services/storage_service.dart';
import 'package:studentoglasi_mobile/utils/util.dart';
import '../models/Chat/chat.dart';
import '../models/Message/message.dart';
import '../services/media_service.dart';

class ChatScreen extends StatefulWidget {
  final Student chatUser;

  const ChatScreen({super.key, required this.chatUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GetIt _getIt = GetIt.instance;
  late Student currentStudent;
  late DatabaseService _databaseService;
  late MediaService _mediaService;
  late StudentiProvider _userProvider;
  late StorageService _storageService;
  ChatUser? currentUser, otherUser;
  bool _isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<StudentiProvider>();
    _databaseService = _getIt.get<DatabaseService>();
    _mediaService = _getIt.get<MediaService>();
    _storageService = _getIt.get<StorageService>();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    try {
      currentStudent = await _userProvider.getCurrentStudent();
      currentUser = ChatUser(
        id: currentStudent.id.toString(),
        firstName: currentStudent.idNavigation.ime,
      );
      otherUser = ChatUser(
        id: widget.chatUser.id.toString(),
        firstName: widget.chatUser.idNavigation.ime,
        profileImage: widget.chatUser.idNavigation.slika,
      );
    } catch (e) {
      // Handle any errors here
      print('Error initializing chat: $e');
    } finally {
      setState(() {
        _isLoading = false; // Update loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUser.idNavigation.ime!),
      ),
      body: _isLoading ? _buildLoading() : _buildUI(), // Conditional rendering
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildUI() {
    return StreamBuilder<DocumentSnapshot<Chat>>(
      stream: _databaseService.getChatData(
        currentStudent.id.toString(),
        widget.chatUser.id.toString(),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading(); // Show loading indicator while waiting for data
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        Chat? chat = snapshot.data?.data();
        List<ChatMessage> messages = [];
        if (chat != null && chat.messages != null) {
          messages = _generateChatMessagesList(chat.messages!);
        }

        return DashChat(
          messageOptions:
              const MessageOptions(showOtherUsersAvatar: true, showTime: true),
          inputOptions: InputOptions(alwaysShowSend: true, trailing: [
            _mediaMessageButton(),
          ]),
          currentUser: currentUser!,
          onSend: _sendMessage,
          messages: messages,
        );
      },
    );
  }

  Future<void> _sendMessage(ChatMessage chatMessage) async {
    if (chatMessage.medias?.isNotEmpty ?? false) {
      if (chatMessage.medias!.first.type == MediaType.image) {
        Message message = Message(
            senderID: chatMessage.user.id,
            content: chatMessage.medias!.first.url,
            messageType: MessageType.Image,
            sentAt: Timestamp.fromDate(chatMessage.createdAt));
        try {
          await _databaseService.sendChatMessage(
            currentStudent.id.toString(),
            widget.chatUser.id.toString(),
            message,
          );
        } catch (e) {
          print('Error sending message: $e');
        }
      }
    } else {
      Message message = Message(
        senderID: currentStudent.id.toString(),
        content: chatMessage.text,
        messageType: MessageType.Text,
        sentAt: Timestamp.fromDate(chatMessage.createdAt),
      );

      try {
        await _databaseService.sendChatMessage(
          currentStudent.id.toString(),
          widget.chatUser.id.toString(),
          message,
        );
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  List<ChatMessage> _generateChatMessagesList(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((m) {
      if (m.messageType == MessageType.Image) {
        return ChatMessage(
            user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
            medias: [
              ChatMedia(url: m.content!, fileName: "", type: MediaType.image)
            ],
            createdAt: m.sentAt!.toDate());
      } else {
        return ChatMessage(
          user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
          text: m.content!,
          createdAt: m.sentAt!.toDate(),
        );
      }
    }).toList();
    chatMessages.sort((a, b) {
      return b.createdAt.compareTo(a.createdAt);
    });
    return chatMessages;
  }

  Widget _mediaMessageButton() {
    return IconButton(
      onPressed: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          String chatID =
              generateChatID(id1: currentUser!.id, id2: otherUser!.id);
          String? downloadURL = await _storageService.uploadImageToChat(
              file: file, chatID: chatID);
          if (downloadURL != null) {
            ChatMessage chatMessage = ChatMessage(
                user: currentUser!,
                createdAt: DateTime.now(),
                medias: [
                  ChatMedia(
                      url: downloadURL, fileName: "", type: MediaType.image)
                ]);
            _sendMessage(chatMessage);
          }
        }
      },
      icon: Icon(Icons.image, color: Theme.of(context).colorScheme.primary),
    );
  }
}
