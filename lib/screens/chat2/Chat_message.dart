import 'package:flutter/cupertino.dart';

class ChatMessage{
  String messageContent;
  String voice;
  String image;
  String senderId;
  ChatMessage({required this.senderId,required this.messageContent, required this.voice, required this.image});
}