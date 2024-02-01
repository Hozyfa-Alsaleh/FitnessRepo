import 'dart:async';

import 'package:captainshoaib/approute.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoute.LOGIN);
    });
    super.onInit();
  }
}
