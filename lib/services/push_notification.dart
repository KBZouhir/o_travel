

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialise() async {

      // 3. On iOS, this helps to take the user permissions
      NotificationSettings settings = await _fcm.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );


    if (settings.authorizationStatus == AuthorizationStatus.authorized) {

    } else {
      print('User declined or has not accepted permission');
    }
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('${message.notification?.title}');
        print('${message.notification?.body}');
      });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('${message.notification?.title}');
        print('${message.notification?.body}');
      });
      /*FirebaseMessaging.onBackgroundMessage((message) {
        print('${message.notification?.title}');
        print('${message.notification?.body}');
        return null;
      });*/
  }
}