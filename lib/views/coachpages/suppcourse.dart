import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/suppcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuppCourse extends StatelessWidget {
  const SuppCourse({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SuppController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.coachprofile_C);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColor,
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoute.addSupp);
                },
                icon: const Icon(
                  Icons.add,
                  size: 45,
                  color: Colors.black,
                ))
          ],
          title: const Text(
            "كورس المكملات",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<SuppController>(
          builder: (controller) {
            return FutureBuilder(
              future: controller.fetchSuppCourse(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 30),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Text(
                        snapshot.data!['data']['supp'],
                        style:
                            const TextStyle(fontSize: 28, color: Colors.black),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: Text(
                    "لا يوجد كورس",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
