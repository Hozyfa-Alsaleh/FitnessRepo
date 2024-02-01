import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaptinInfo extends StatelessWidget {
  const CaptinInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              sherdpref!.clear();
              Get.offAllNamed(AppRoute.Splash);
            },
            icon: const Icon(Icons.logout))
      ]),
    );
  }
}
