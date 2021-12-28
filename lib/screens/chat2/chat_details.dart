import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:o_travel/Models/type.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:o_travel/constants.dart';
import 'package:o_travel/screens/ads/show.dart';
import 'package:o_travel/screens/chat2/ChatUser.dart';
import 'package:o_travel/screens/chat2/Chat_message.dart';
import 'package:o_travel/services/database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatDetails extends StatefulWidget {
  final ChatUser user;
  final String myId;
  final String chatRoomId;

  const ChatDetails(
      {Key? key,
      required this.user,
      required this.myId,
      required this.chatRoomId})
      : super(key: key);

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  List<ChatMessage> messages = [];
  bool loading = true;
  late Stream<QuerySnapshot> messageStream;
  File? image1;
  final fieldMessageController = TextEditingController();
  final _fbStorage = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllMessages();
  }

  getAllMessages() async {
    DatabaseMethods().getChatRoomMessages(widget.chatRoomId).then((value) {
      setState(() {
        loading = false;
        messageStream = value;
      });
    });
  }
  bool emojiShowing = false;

  _onEmojiSelected(Emoji emoji) {
    fieldMessageController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: fieldMessageController.text.length));
  }

  _onBackspacePressed() {
    fieldMessageController
      ..text = fieldMessageController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: fieldMessageController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          toolbarHeight: 50,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.user.imageURL.isNotEmpty
                    ? widget.user.imageURL
                    : default_image_url),
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
              icon: Icon(Icons.phone_outlined),
              color: Colors.white,
            )
          ],
        ),
        body: Column(children: <Widget>[
          Expanded(child: chatMessages(),),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Theme.of(context).backgroundColor,
            height: 50,
            child: Row(
              children: [

                Expanded(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.1),
                        borderRadius:
                        BorderRadius.all(Radius.circular(50))),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                emojiShowing = !emojiShowing;
                              });
                            },
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4),
                            )),
                        Expanded(
                          child: TextField(
                            controller: fieldMessageController,
                            onSubmitted: (String str) {
                              if (str.trim().isNotEmpty) {
                                DatabaseMethods()
                                    .addMessage(widget.chatRoomId, {
                                  'senderId': widget.myId,
                                  'messageContent':
                                  '${fieldMessageController.text}',
                                  'voice': '',
                                  'image': '',
                                  'time': DateTime.now()
                                });

                                fieldMessageController.text = ' ';
                              }
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
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (fieldMessageController.text.trim().isNotEmpty) {
                      DatabaseMethods().addMessage(widget.chatRoomId, {
                        'senderId': widget.myId,
                        'messageContent': '${fieldMessageController.text}',
                        'voice': '',
                        'image': '',
                        'time': DateTime.now()
                      });

                      fieldMessageController.text = ' ';
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.1),
                        borderRadius:
                        BorderRadius.all(Radius.circular(50))),
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),Offstage(
            offstage: !emojiShowing,
            child: SizedBox(
              height: 250,
              child: EmojiPicker(
                  onEmojiSelected: (Category category, Emoji emoji) {
                    _onEmojiSelected(emoji);
                  },
                  onBackspacePressed: _onBackspacePressed,
                  config: Config(
                      columns: 7,
                      // Issue: https://github.com/flutter/flutter/issues/28894
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      initCategory: Category.RECENT,
                      bgColor: const Color(0xFFF2F2F2),
                      indicatorColor: Colors.blue,
                      iconColor: Colors.grey,
                      iconColorSelected: Colors.blue,
                      progressIndicatorColor: Colors.blue,
                      backspaceColor: Colors.blue,
                      showRecentsTab: true,
                      recentsLimit: 28,
                      noRecentsText: 'No Recents',
                      noRecentsStyle: const TextStyle(
                          fontSize: 20, color: Colors.black26),
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL)),
            ),
          )

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
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 70, top: 16),
                      itemCount: snapshot.data!.docs.length,
                      reverse: true,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];

                        return chatMessageTile(
                            ds["messageContent"],
                            widget.myId == ds["senderId"],
                            ds['image'],
                            ds['voice']);
                      })
                  : Center(child: CircularProgressIndicator());
            },
          );
  }

  Widget chatMessageTile(
      String message, bool sendByMe, String imgUrl, String voice) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
                margin: EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  right: sendByMe ? 16 : 50,
                  left: sendByMe ? 50 : 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomRight:
                        sendByMe ? Radius.circular(0) : Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomLeft:
                        sendByMe ? Radius.circular(24) : Radius.circular(0),
                  ),
                  color: sendByMe
                      ? Theme.of(context).primaryColor
                      : primaryColorLite,
                ),
                padding: EdgeInsets.all(16),
                child: (imgUrl.isNotEmpty)
                    ? imageMessage(imgUrl)
                    : Text(
                            message,
                            style: TextStyle(
                                color: sendByMe
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                                fontSize: 18),
                          ))),
      ],
    );
  }
Widget imageMessage( imageUrl){
  return  GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => DetailImageScreen(
                  imageUrl));
        },
        child: Hero(
          tag: 'offer${imageUrl}',
          child: ClipRRect(
            borderRadius:
            BorderRadius.all(Radius.circular(20)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 200,
              placeholder: (context, url) => Center(
                  child: Container(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                      ))),
              errorWidget: (context, url, error) =>
              new Icon(Icons.error),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
}
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imgTemp = File(image.path);
    setState(() {
      this.image1 = imgTemp;
      uploadImage(image1!).then((value) {
        DatabaseMethods().addMessage(widget.chatRoomId, {
          'senderId': widget.myId,
          'messageContent': '',
          'voice': '',
          'image': '$value',
          'time': DateTime.now()
        }).then((value) =>     EasyLoading.dismiss()
        )
        ;
      });
    });
  }

  Future<String> uploadImage(File image) async {
    EasyLoading.show();
    String fileName = (image.path.split("/").last);
    Reference storageRef = _fbStorage.ref().child('upload/$fileName');
    await storageRef.putFile(image);
    return await storageRef.getDownloadURL();
  }
}
