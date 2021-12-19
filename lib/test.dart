import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print(FirebaseApi.getUsers().first.toString());
}


class FirebaseApi {
  static Stream  getUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots();

}