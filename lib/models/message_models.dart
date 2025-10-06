import 'package:chat_app/constants.dart';

class MessageModels {
  final String message;
  final String id;
  const MessageModels({required this.message, required this.id});

  factory MessageModels.fromJson(var jsonData) {
    return MessageModels(message: jsonData[kMessage], id: jsonData['id']);
  }
}
