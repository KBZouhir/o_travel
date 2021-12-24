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

  Future<Stream<QuerySnapshot>> getUsers() async {
    String myid= await SharedPreferenceHelper().getUserId();
    return FirebaseFirestore.instance
        .collection("users").where('userID',isNotEqualTo: myid)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserByTyp(bool type) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("isCompany", isEqualTo: type)
        .snapshots();
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

  createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
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

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String userId = await SharedPreferenceHelper().getUserId();
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: userId)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }
}
