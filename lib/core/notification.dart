import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationMessage {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    // String? token = await messaging.getToken();
    String? token = await messaging.getToken();
    log(token ?? "");
    FirebaseMessaging.onBackgroundMessage(handelBackGroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      LocalNotification.showBasicNotification(message.notification?.title, message.notification?.body);
    });
  }

  static Future<void> handelBackGroundMessage(RemoteMessage massage) async {
    await Firebase.initializeApp();
    log(massage.notification?.title ?? "");
  }
}

class LocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future init() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
  }

  static void showBasicNotification(String? text, String? body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "channelId",
      "BasicNotification",
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin
        .show(0, text, body, notificationDetails, payload: "payload");
  }
}
