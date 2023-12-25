import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/core/functions/fcmconfig.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  int currentindex = 0;
  late PageController pc;
  String? token = "";
  String? sendToken;
  changedPage(int index) {
    currentindex = index;
    pc.animateToPage(currentindex,
        duration: const Duration(microseconds: 800), curve: Curves.easeInOut);
    update();
  }

  setTokenForUser() {}
  @override
  void onInit() async {
    pc = PageController(initialPage: 1);

    ///Subscribe USER WITH TOPIC
    FirebaseMessaging.instance.subscribeToTopic(
        "${sherdpref!.getString('username')}${sherdpref!.getString('userId')}");
    requestNotificationPermissions();
    fcmconfigure();
    print(
        "${sherdpref!.getString('username')}${sherdpref!.getString('userId')}");
    super.onInit();
  }

  ///ADD TOKEN FOR DATABASE
  Future<void> addToken() async {
    var request = await http
        .post(Uri.parse('${ApiLinks.proteam}/Auth/addtoken.php'), body: {
      'acc_id': sherdpref!.getString('userId').toString(),
      'token': token
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      print('token added');
    } else {
      print('faild to add token');
    }
  }

  ///WE DON'T NEED IT
  Future chooseUser() async {
    var request = await http.post(
        Uri.parse("${ApiLinks.proteam}/testtoken.php"),
        body: {'acc_id': '1'});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      sendToken = response['data'][0]['token'];
      sherdpref!.setString('captineToken', sendToken!);
    } else {
      getxDialog('', request.reasonPhrase.toString());
    }
    update();
  }
}
