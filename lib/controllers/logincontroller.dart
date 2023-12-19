import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/classes/crud.dart';
import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/core/functions/handlingdata.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  late GlobalKey<FormState> loginFormKey;
  late TextEditingController username;
  late TextEditingController password;
  bool secure = true;
  RequestStatus reqStatus = RequestStatus.holding;
  CRUD crud = CRUD();
  showpass() {
    secure = !secure;
    update();
  }

  ///Login method
  // login() {
  //   if (loginFormKey.currentState!.validate()) {
  //     sherdpref!.setBool('isLog', true);
  //     username.clear();
  //     password.clear();
  //     Get.offAll(() => const HomePage());
  //   }
  //   update();
  // }

  @override
  void onInit() async {
    loginFormKey = GlobalKey<FormState>();
    username = TextEditingController();
    password = TextEditingController();
    String? token = await FirebaseMessaging.instance.getToken();
    print("===============================");
    print(token);
    super.onInit();
  }

  ///Check Email and Password for Login
  loginMethod() async {
    reqStatus = RequestStatus.loading;
    var res =
        await testData.login(ApiLinks.login, username.text, password.text);
    reqStatus = handlingdata(res);

    if (RequestStatus.success == reqStatus) {
      if (loginFormKey.currentState!.validate()) {
        if (res['data']['acc_id'] == 1) {
          sherdpref!.setString('userId', res['data']['acc_id'].toString());
          sherdpref!.setString('username', res['data']['name']);
          sherdpref!.setBool('isLog', true);
          Get.offAllNamed(AppRoute.captineHomePage);
        } else {
          sherdpref!.setString('userId', res['data']['acc_id'].toString());
          sherdpref!.setString('username', res['data']['name']);
          sherdpref!.setBool('isLog', true);
          Get.offAllNamed(AppRoute.HOME);
        }
      }
    } else {
      getxDialog("", "خطأ في الايميل أو كلمة المرور");
      //getxDialog("", reqStatus.toString());
    }
    update();
  }

  sendNotification() async {
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAA5JVK_2c:APA91bE4BaDGuNH8bBl086IJv_awyjfGdWSUdCeZr0OC4XCjaduzsmIfAcVBDeCGlgmo1mehCbYyeldYFmR93nm7f8IaEDs0xE9XQYVjfIGkHsgrWXg0hSp_oX4DW5MlkdUkhRlyD5jk'
    };
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to":
          "c-GfhpR0RbG8-uC4CjjPG3:APA91bHQmbSJJg5JmnCi8y4b4rE4ZVbVUpJd_JT8auLCHuhp8KDSPQToP2tmJ30bnY5Turyw3qpx8C6beIeCO4TV4KZPebNWeRwWDxuQtqx_Un_tmtsiAEHVSFfHmnPElLugs3jC-eCI",
      "notification": {
        "title": "Check this Mobile (title)",
        "body": "Rich Notification testing (body)"
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}
