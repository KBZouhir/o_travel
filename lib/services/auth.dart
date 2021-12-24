import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:o_travel/api/company/auth.dart';
import 'package:o_travel/screens/chat2/chat_page.dart';
import 'package:o_travel/screens/home/home.dart';
import 'package:o_travel/services/sheard_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //get current user
  getCurrentUser() async {
    return auth.currentUser;
  }

  Future<User?> signInWithGoogle(BuildContext context) async {
    String? deviceToken =await FirebaseMessaging.instance.getToken();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result =
    await _firebaseAuth.signInWithCredential(credential);
      User? userDetails = result.user;
      print('userDetails $userDetails');
      SharedPreferenceHelper().saveUserEmail(userDetails!.email??'');
      SharedPreferenceHelper().saveUserId(userDetails.uid);
      SharedPreferenceHelper()
          .saveUserName(userDetails.email!.replaceAll("@gmail.com", ""));
      SharedPreferenceHelper().saveDisplayName(userDetails.displayName??'');
      SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL??'');

    registerUser(
        userDetails.email!.replaceAll("@gmail.com", ""),
        userDetails.email,
        'password',
        'password',
        '+213',
       '0000000',
         deviceToken).then((value){
           if(value.id> -1){
             DatabaseMethods().addUserInfoToDB(
                 userID: userDetails.uid,
                 email: userDetails.email??'',
                 username: userDetails.email!.replaceAll("@gmail.com", ""),
                 name: userDetails.displayName??'',
                 isCompany: false,
                 profileUrl: userDetails.photoURL??'')
                 .then((value) {
               print(value);
               Navigator.pushReplacement(
                   context, MaterialPageRoute(builder: (context) => HomeScreen()));
             });
           }
    });




  }

  Future<User?> signInWithEmailPassword(BuildContext context,email,password,username,isCompany) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    UserCredential credential =
    (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password));
print(credential.user);
      User? userDetails = credential.user;
      SharedPreferenceHelper().saveUserEmail(email);
      SharedPreferenceHelper()  .saveUserName(username);
      SharedPreferenceHelper().saveDisplayName(username);
      SharedPreferenceHelper().saveUserId(userDetails!.uid);
      SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL??'');

      DatabaseMethods().addUserInfoToDB(
          userID: userDetails.uid,
          email: email,
          username: username,
          name: username,
          isCompany: isCompany,
          profileUrl: '')
          .then((value) {
            print(value);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });

  }


  Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await auth.signOut();
  }
}