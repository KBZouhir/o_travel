import 'package:flutter/material.dart';
import 'package:o_travel/screens/chat/ChatUser.dart';
import 'package:o_travel/screens/chat/chat_details.dart';

class ConversationItem extends StatefulWidget{
  final ChatUser user;
  final bool isMessageRead;
  ConversationItem({required this.user,required this.isMessageRead});
  @override
  _ConversationItemState createState() => _ConversationItemState();
}

class _ConversationItemState extends State<ConversationItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatDetails(user: widget.user,)));
      },
      child: Container(
        color: widget.isMessageRead?Theme.of(context).primaryColor.withOpacity(0.04):Theme.of(context).accentColor.withOpacity(0),
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.imageURL),
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