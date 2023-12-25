import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/core/classes/mynotifications.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

requestNotificationPermissions() async {
  // ignore: unused_local_variable
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
          colorText: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(141, 0, 0, 0),
          duration: const Duration(seconds: 5));
      NotificationsApi.showNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          payload: 'Hozyfa Alsaleh');
      storNotificationsToDB(
          sherdpref!.getString('userId').toString(),
          message.notification!.title!,
          message.notification!.body!,
          DateTime.now().toString(),
          "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}:00",
          "insert");
    }
  });
}

storNotificationsToDB(String id, String title, String body, String date,
    String time, String getRequest) async {
  var request = await http.post(
      Uri.parse("${ApiLinks.proteam}/notifications.php?$getRequest"),
      body: {
        'acc_id': id,
        'title': title,
        'body': body,
        'date': date,
        'time': time,
      });
  var response = await jsonDecode(request.body);
  if (response['status'] == 1) {
    Get.snackbar('', 'تم حفظ الاشعار بنجاح');
  } else {
    Get.snackbar('', 'خطأ');
  }
}
