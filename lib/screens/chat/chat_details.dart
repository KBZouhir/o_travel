import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/chat/ChatUser.dart';
import 'package:o_travel/screens/chat/Chat_message.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatDetails extends StatefulWidget {
  final ChatUser user;

  const ChatDetails({Key? key, required this.user}) : super(key: key);

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  List<ChatMessage> messages = [
    ChatMessage(
        messageContent: "Hello, Will", messageType: "receiver", image: ''),
  ];
  File? image1;
  final fieldMessageController = TextEditingController();
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imgTemp = File(image.path);
    setState(() {
      this.image1 = imgTemp;
      this.messages.insert(
          0,
          new ChatMessage(
              messageContent: '', messageType: 'sender', image: image.path));
    });
  }

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
            IconButton(
                onPressed: () {
                  launch("tel://${widget.user.phone}");
                },
                icon: Icon(Icons.phone_outlined))
          ],
        ),
        body: Stack(children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            reverse: true,
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
                      color: (messages[index].messageType == "sender"
                          ? Theme.of(context).primaryColor
                          : gray228),
                    ),
                    padding: (messages[index].image != '')
                        ? EdgeInsets.all(5)
                        : EdgeInsets.all(16),
                    child: (messages[index].image != '')
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Image.file(
                              new File(messages[index].image),
                              width: 100,
                            ),
                          )
                        : Text(
                            messages[index].messageContent,
                            style: TextStyle(
                              fontSize: 15,
                              color: (messages[index].messageType == "sender"
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
                              child: TextField(
                                controller: fieldMessageController,
                                onSubmitted: (String str) {
                                  setState(() {
                                    this.messages.insert(
                                        0,
                                        new ChatMessage(
                                            messageContent: '$str',
                                            messageType: 'sender',
                                            image: ''));
                                  });
                                  fieldMessageController.clear();
                                },
                                maxLines: 1,
                                style: TextStyle(fontSize: 14),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  fillColor: Theme.of(context)
                                      .backgroundColor
                                      .withOpacity(0),
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'write your message',
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  pickImage();
                                },
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
