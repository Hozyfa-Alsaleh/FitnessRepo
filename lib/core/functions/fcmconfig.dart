import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitnessapp/core/classes/mynotifications.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

requestNotificationPermissions() async {
  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(
          alert: true,
          sound: true,
          announcement: false,
          badge: true,
          criticalAlert: false,
          carPlay: false,
          provisional: false);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
}

fcmconfigure() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("=============================ON FOREGROUND");
      print(message.notification!.title);
      print(message.notification!.body);
      print("==============================");
      Get.snackbar(message.notification!.title!, message.notification!.body!,
          colorText: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Color.fromARGB(141, 0, 0, 0),
          duration: Duration(seconds: 5));
      NotificationsApi.showNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          payload: 'Hozyfa Alsaleh');
    }
  });
}
