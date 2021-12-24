import 'package:flutter/material.dart';
import 'package:o_travel/Models/type.dart';
import 'package:o_travel/api/CONFIG.dart';
import 'package:o_travel/screens/chat2/ChatUser.dart';
import 'package:o_travel/screens/chat2/chat_details.dart';
import 'package:o_travel/services/database.dart';

class ConversationItem extends StatefulWidget{
  final ChatUser user;
  final bool isMessageRead;
  final String myId;
  ConversationItem({required this.user,required this.isMessageRead, required this.myId});
  @override
  _ConversationItemState createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
late String chatRoomId;

@override
void initState() {
  // TODO: implement initState
  super.initState();
  print("userId ${widget.user.userId}\     myId ${widget.myId}");
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
  });
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Map<String, dynamic> chatRoomInfoMap = {
          "users": [widget.myId, widget.user.userId]
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatDetails(user: widget.user,myId:widget.myId)));
      },
      child: Container(
        color: widget.isMessageRead?Theme.of(context).primaryColor.withOpacity(0.04):Colors.white,
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.imageURL.isNotEmpty?widget.user.imageURL:default_image_url),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.user.name, style: TextStyle(fontSize: 16,color:Theme.of(context).accentColor.withOpacity(1) ),),
                          SizedBox(height: 6,),
                          Text(widget.user.messageText,style: TextStyle(fontSize: 13,color: Theme.of(context).accentColor.withOpacity(0.8),
                              fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(widget.user.time,style: TextStyle(fontSize: 12,color: Theme.of(context).accentColor.withOpacity(1),
                fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),),
          ],
        ),
      ),
    );
  }
}