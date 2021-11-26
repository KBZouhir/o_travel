import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/screens/chat/ChatUser.dart';
import 'package:o_travel/screens/chat/conversation_list.dart';
import 'package:o_travel/screens/localization/const.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatUser> chatUsers = [
    ChatUser(
        name: "Zeou",
        messageText: 'Hello',
        imageURL: "https://lh3.googleusercontent.com/ogw/ADea4I4lUkNl3YkeKn0doOPO4In1EgYplXG1jBkYAG9S1Q=s83-c-mo",
        phone:'0657112980',
        time: "Now"),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'chat')),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
               itemBuilder: (context, index) {
                return ConversationItem(user: chatUsers[index],
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
