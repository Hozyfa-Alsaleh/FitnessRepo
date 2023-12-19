import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (sherdpref!.getBool("isLog") == true) {
      if (sherdpref!.getString('userId').toString() == '1') {
        return const RouteSettings(name: AppRoute.captineHomePage);
      } else {
        return const RouteSettings(name: AppRoute.HOME);
      }
    }
    return null;
  }
}
