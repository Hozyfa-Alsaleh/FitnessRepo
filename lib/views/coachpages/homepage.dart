import 'dart:io';

import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/homepagecontroller.dart';

import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/views/Home/manageprofile.dart';
import 'package:fitnessapp/views/Home/notifications.dart';
import 'package:fitnessapp/widgets/coachpages/captinbuttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaptinHomePage extends StatelessWidget {
  const CaptinHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CaptineHomePageController());
    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
          backgroundColor: const Color.fromARGB(255, 14, 82, 138),
          title: "",
          content: const Text(
            "هل تود الخروج من التطبيق؟",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          // onCancel: () {
          //   Get.back();
          // },
          // onConfirm: () {
          //   exit(1);
          // },
          cancel: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.cancel, color: Colors.white),
          ),
          confirm: IconButton(
            onPressed: () {
              exit(1);
            },
            icon: const Icon(Icons.done, color: Colors.white),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "الصفحة الرئيسية",
            style: TextStyle(
                color: Colors.black, fontFamily: "Tajwal", fontSize: 30),
          ),
          centerTitle: true,
          toolbarHeight: 200,
          leading: IconButton(
            onPressed: () {
              sherdpref!.clear();
              Get.offAllNamed(AppRoute.LOGIN);
            },
            icon: const Icon(
              Icons.logout,
              size: 30,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAll(() => const MyNotifyPage(
                        route: AppRoute.captineHomePage,
                      ));
                },
                icon: const Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.black,
                  size: 30,
                ))
          ],
        ),
        body: SizedBox(
          width: width,
          child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                CaptinButtons(
                  text: "اللاعبين",
                  icon: Icons.man,
                  color: Colors.white,
                  onPressed: () {
                    Get.offAllNamed(AppRoute.players_C);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CaptinButtons(
                  text: "الباقات",
                  icon: Icons.pages_rounded,
                  color: Colors.white,
                  onPressed: () {
                    Get.offAllNamed(AppRoute.CaptinePackages);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CaptinButtons(
                  text: "الطلبات",
                  icon: Icons.request_page_rounded,
                  color: Colors.white,
                  onPressed: () {
                    Get.offAllNamed(AppRoute.playersRequests);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                CaptinButtons(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.contactInfo);
                  },
                  text: "معلومات التواصل",
                  icon: Icons.health_and_safety_rounded,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 30,
                ),
                CaptinButtons(
                  onPressed: () {
                    Get.offAll(() => const ManageProfile(
                          route: AppRoute.captineHomePage,
                          type: "admin",
                        ));
                  },
                  text: "الإعدادات",
                  icon: Icons.health_and_safety_rounded,
                  color: Colors.white,
                ),
              ]),
        ),
      ),
    );
  }
}
