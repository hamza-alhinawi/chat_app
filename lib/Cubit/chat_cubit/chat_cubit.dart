import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollections,
  );

  void sendMessage({required String message, required var email}) {
    try {
      messages.add({
        kMessage: message,
        kCreatedAdd: DateTime.now(),
        'id': email,
      });
    } catch (e) {
      debugPrint(e as String);
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAdd, descending: true).snapshots().listen((event) {
      List<MessageModels> messagesList = [];

      for (var doc in event.docs) {
        messagesList.add(MessageModels.fromJson(doc));
        debugPrint(doc.data() as String?);
      }
      emit(ChatSuccess(messageList: messagesList));
    });
  }
}
