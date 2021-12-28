import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:o_travel/screens/chat2/ChatUser.dart';
import 'package:o_travel/screens/chat2/chat_details.dart';
import 'package:o_travel/services/database.dart';

import '../../constants.dart';

class ConversationItem extends StatefulWidget {
  final ChatUser user;
  final String myId;

  ConversationItem({required this.user, required this.myId});

  @override
  _ConversationItemState createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  late String chatRoomId;
  late String lastMessage = '';
  late String time = '';

  getChatRoomIdById(String a, String b) {
    setState(() {
      List<String> keyList = [a, b];
      keyList.sort();
      chatRoomId = '${keyList[0]}_${keyList[1]}';

      DatabaseMethods().getChatRoomLastMessage(chatRoomId).then((value) {
        if (value.docs.isNotEmpty) {
          DocumentSnapshot ds = value.docs[0];
          setState(() {
            lastMessage = ds['messageContent'];
            Timestamp timestamp = ds['time'];
            time = '${timestamp.toDate()}';
            print(time);
          });
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("userId ${widget.user.userId}\     myId ${widget.myId}");
    getChatRoomIdById(widget.myId, widget.user.userId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [widget.myId, widget.user.userId]
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatDetails(
                    user: widget.user,
                    myId: widget.myId,
                    chatRoomId: chatRoomId)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                left: BorderSide(
                    color: widget.user.isCompany ? green : blue, width: 8))),
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        widget.user.imageURL.isNotEmpty
                            ? widget.user.imageURL
                            : default_image_url),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.user.name.length>15?widget.user.name.substring(0,15)+'...':widget.user.name,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .colorScheme.secondary
                                    .withOpacity(1),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            lastMessage,
                            style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .colorScheme.secondary
                                    .withOpacity(0.8),
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
