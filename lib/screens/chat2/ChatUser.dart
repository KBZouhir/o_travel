import 'package:flutter/cupertino.dart';

class ChatUser{
  String userId;
  String name;
  String messageText;
  String imageURL;
  String phone;
  String time;
  ChatUser({required this.userId,required this.name,required this.messageText,required this.imageURL,required this.time,required this.phone});
}