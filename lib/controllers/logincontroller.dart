// ignore_for_file: avoid_print
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

class LoginController extends GetxController {
  late GlobalKey<FormState> loginFormKey;
  late TextEditingController username;
  late TextEditingController password;
  bool secure = true;
  String? sendToken;
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
    super.onInit();
  }

  ///Check Email and Password for Login
  loginMethod() async {
    reqStatus = RequestStatus.loading;
    var res =
        await testData.login(ApiLinks.login, username.text, password.text);
    reqStatus = handlingdata(res);
    if (RequestStatus.success == reqStatus) {
      if (res['status'] != "faild") {
        if (loginFormKey.currentState!.validate()) {
          if (res['data']['acc_id'] == 1) {
            sherdpref!.setString('userId', '1');
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
        getxDialog(
            "", "خطأ في الايميل أو كلمة المرور \n أو انك لا تملك حساباً");
      }
    } else {
      getxDialog("", " خطأ في الايميل أو كلمة المرور");

      //getxDialog("", "لا يوجد حساب بهذه المعلومات");

      //getxDialog("", reqStatus.toString());
    }
    update();
  }
}
