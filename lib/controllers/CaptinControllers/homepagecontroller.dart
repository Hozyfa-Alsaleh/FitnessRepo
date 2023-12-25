import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitnessapp/core/functions/fcmconfig.dart';
import 'package:get/get.dart';

class CaptineHomePageController extends GetxController {
  @override
  void onInit() {
    FirebaseMessaging.instance.subscribeToTopic('captine');
    requestNotificationPermissions();
    fcmconfigure();
    super.onInit();
  }
}
