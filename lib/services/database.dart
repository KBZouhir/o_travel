import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:o_travel/services/sheard_helper.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      {required String userID,
      required String email,
      required String username,
      required String name,
      required bool isCompany,
      required String profileUrl}) async {
   return await FirebaseFirestore.instance.collection("users").doc(userID).set({
      "userID": userID,
      "email": email,
      "username": username,
      "name": name,
      "imgUrl": profileUrl,
      'isCompany': isCompany
    });
  }

  Future<Stream<QuerySnapshot>> getUsers(userList) async {
    String myid= await SharedPreferenceHelper().getUserId();

    return FirebaseFirestore.instance
        .collection("users")
        .snapshots();
  }

  Future<List<String>> getMyChatRooms() async {
    String myid= await SharedPreferenceHelper().getUserId();
    final snapshot= FirebaseFirestore.instance
        .collection("chatrooms")
        .where("users", arrayContains: myid)
        .snapshots();
    print('-------------------------------------------------------');
    List<String> userList=[];
    snapshot.forEach((element) {
      element.docs.forEach((dc) {
        userList.add(dc.get('users')[0].toString());
        userList.add(dc.get('users')[1].toString());
      });
      print('userList $userList');

    });
return userList;
  }


  Future addMessage(String chatRoomId,  Map<String, dynamic> message) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc()
        .set(message);
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists

      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);

    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }
  Future<QuerySnapshot> getChatRoomLastMessage(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots().first;

  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String userId = await SharedPreferenceHelper().getUserId();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .where("users", arrayContains: userId)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: username)
        .get();
  }
}
