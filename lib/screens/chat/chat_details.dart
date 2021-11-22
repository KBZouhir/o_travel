import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/chat/ChatUser.dart';
import 'package:o_travel/screens/chat/Chat_message.dart';

class ChatDetails extends StatefulWidget {
  final ChatUser user;

  const ChatDetails({Key? key, required this.user}) : super(key: key);

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(
        messageContent:
            "How have you been?How have you been?How have you been?How have you been?How have you been?How have you been?How have you been?How have you been?How have you been?How have you been?How have you been?",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "Hey Kriss, I am doing fine dude. wbu?",
        messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(
        messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.imageURL),
                maxRadius: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.user.name,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.phone_outlined))
          ],
        ),
        body: Stack(children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 50),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Theme.of(context).primaryColor
                          : gray228),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(
                        fontSize: 15,
                        color: (messages[index].messageType == "receiver"
                            ? Colors.white
                            : Colors.black87),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: Theme.of(context).backgroundColor,
                height: 50,
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Icon(
                        Icons.keyboard_voice_rounded,
                        color: Theme.of(context).accentColor.withOpacity(0.4),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.4),
                                )),
                            Expanded(
                              child:TextField(
                              maxLines: 1,
                              style: TextStyle(fontSize: 14),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                                fillColor: Theme.of(context).backgroundColor.withOpacity(0),
                                contentPadding: EdgeInsets.zero,
                                hintText: 'write your message',
                              ),
                            ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.4),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ]));
  }
}
