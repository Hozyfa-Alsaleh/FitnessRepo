import 'dart:io';

import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/controllers/homepagecontroller.dart';
import 'package:captainshoaib/views/Home/couchlogo.dart';
import 'package:captainshoaib/views/Home/exercisespage.dart';
import 'package:captainshoaib/views/Home/playerprofile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomePageController());
    return WillPopScope(
      onWillPop: () {
        Get.defaultDialog(
          title: "تحذير",
          content: const Text(
            "هل تود الخروج من التطبيق؟",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          titleStyle: const TextStyle(fontSize: 25),
          onCancel: () {
            Get.back();
          },
          onConfirm: () {
            exit(1);
          },
        );
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: AppColors.scaffoldBackGroundColor,
          bottomNavigationBar: ConvexAppBar(
              onTap: (index) {
                controller.changedPage(index);
              },
              style: TabStyle.titled,
              color: Colors.white,
              backgroundColor: Colors.white,
              curveSize: 0,
              initialActiveIndex: 1,
              top: -12,
              activeColor: const Color.fromARGB(255, 40, 40, 40),
              items: const [
                TabItem(
                  icon: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                  title: "الكورس",
                ),
                TabItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: "الرئيسية",
                ),
                TabItem(
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    title: "ملف اللاعب"),
              ]),
          body: GetBuilder<HomePageController>(
            builder: (controller) {
              return SafeArea(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pc,
                  children: const [
                    Exercises(),
                    CouchLogo(),
                    PlayerProfile(),
                  ],
                ),
              );
            },
          )),
    );
  }
}
