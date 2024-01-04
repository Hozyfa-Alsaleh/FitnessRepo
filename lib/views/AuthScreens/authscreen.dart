import 'package:fitnessapp/controllers/splashcontroller.dart';
import 'package:fitnessapp/core/StaticLData/appimageslinks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImagesLinks.splachBKG),
                fit: BoxFit.cover)),
      ),
    );
  }
}
