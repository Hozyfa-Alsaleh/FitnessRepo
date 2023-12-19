import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  int currentindex = 0;
  late PageController pc;
  changedPage(int index) {
    currentindex = index;
    pc.animateToPage(currentindex,
        duration: const Duration(microseconds: 800), curve: Curves.easeInOut);
    update();
  }

  @override
  void onInit() {
    pc = PageController(initialPage: 1);
    super.onInit();
  }
}
