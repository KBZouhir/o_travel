import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o_travel/Models/type.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/chat2/ChatUser.dart';
import 'package:o_travel/screens/chat2/Chat_message.dart';
import 'package:o_travel/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatDetails extends StatefulWidget {
  final ChatUser user;
  final String myId;

  const ChatDetails({Key? key, required this.user, required this.myId})
      : super(key: key);

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  List<ChatMessage> messages = [];
  late String chatRoomId;
  bool loading = true;
  late Stream<QuerySnapshot> messageStream;
  File? image1;
  final fieldMessageController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.user.phone);
    getChatroomId();
  }
getChatroomId(){
  UserType.getType().then((value){
    setState(() {
      if(value)
        chatRoomId= "${widget.user.userId}\_${widget.myId}";
      else
        chatRoomId="${widget.myId}\_${widget.user.userId}";
    });
    getAllMessages();
  });
}

  getAllMessages() async {
print(chatRoomId);
    DatabaseMethods().getChatRoomMessages(chatRoomId).then((value) {
      setState(() {
        loading = false;
        messageStream = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.imageURL.isNotEmpty?widget.user.imageURL:default_image_url),
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
          chatMessages(),
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
                                            senderId: widget.myId,
                                            messageContent: '$str',
                                            voice: '',
                                            image: ''));

                                    DatabaseMethods().addMessage(chatRoomId, {
                                      'senderId': widget.myId,
                                      'messageContent': '$str',
                                      'voice': '',
                                      'image': '',
                                      'time': DateTime.now()
                                    });
                                  });
                                  fieldMessageController.text=' ';

                                },
                                maxLines: 1,
                                style: TextStyle(fontSize: 16),
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

  Widget chatMessages() {
    return (loading)
        ? GFLoader()
        : StreamBuilder<QuerySnapshot>(
            stream: messageStream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      padding: EdgeInsets.only(bottom: 70, top: 16),
                      itemCount: snapshot.data!.docs.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return chatMessageTile(
                            ds["messageContent"], widget.myId == ds["senderId"]);
                      })
                  : Center(child: CircularProgressIndicator());
            },
          );
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe ? Theme.of(context).primaryColor : primaryColorLite,
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: sendByMe? Colors.white:Theme.of(context).primaryColor,fontSize: 18),
              )),
        ),
      ],
    );
  }


  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imgTemp = File(image.path);
    setState(() {
      this.image1 = imgTemp;
      this.messages.insert(
          0,
          new ChatMessage(
              senderId: widget.myId,
              messageContent: '',
              voice: '',
              image: image.path));
    });
  }


  String basename(path) {
    return '';
  }
}
