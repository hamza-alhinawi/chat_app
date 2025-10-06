import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_models.dart';
import 'package:flutter/material.dart';

class CustomChatBubul extends StatelessWidget {
  const CustomChatBubul({super.key, required this.message});
  final MessageModels message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        margin: EdgeInsets.only(right: 150, top: 10, left: 10),
        // height: 65,
        // width: 200,
        // alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
          color: kPrimaryColor,
        ),
        child: Center(
          child: Text(message.message, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

class CustomChatBubulForFriend extends StatelessWidget {
  const CustomChatBubulForFriend({super.key, required this.message});
  final MessageModels message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        margin: EdgeInsets.only(right: 10, top: 10, left: 150),
        // height: 65,
        // width: 200,
        // alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
            bottomLeft: Radius.circular(22),
          ),
          color: Color(0xff006d84),
        ),
        child: Center(
          child: Text(message.message, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
