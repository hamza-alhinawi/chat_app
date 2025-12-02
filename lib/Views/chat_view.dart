import 'package:chat_app/Views/loading_view.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_models.dart';
import 'package:chat_app/widgets/custom_chat_bubul.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  static String id = 'ChatViews';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final controller2 = ScrollController();

  // final String email ;
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollections,
  );

  TextEditingController controller = TextEditingController();

  // final String color;
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAdd, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModels> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(MessageModels.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,

              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(kLogo, height: 50),
                  Text('Scohlar Chat', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controller2,
                    itemCount: messagesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return messagesList[index].id == email
                          ? CustomChatBubul(message: messagesList[index])
                          : CustomChatBubulForFriend(
                              message: messagesList[index],
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAdd: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      controller2.animateTo(
                        controller2.position.minScrollExtent,
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.send, color: kPrimaryColor),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return LoadingView();
        }
      },
    );
  }
}
