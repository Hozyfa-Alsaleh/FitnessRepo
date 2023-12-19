import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/displayfoodcourse.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayFoodCourse extends StatelessWidget {
  const DisplayFoodCourse({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DisplayFoodController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.coachprofile_C);
        return false;
      },
      child: Scaffold(
          backgroundColor: AppColors.scaffoldBackGroundColor,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.foodcourse);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.black,
                  ))
            ],
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              "كورس الغذاء",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: GetBuilder<DisplayFoodController>(
            builder: (controller) {
              return SizedBox(
                  width: width,
                  height: height,
                  child: FutureBuilder(
                    future: controller.getFoodCourse(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Text(
                              snapshot.data!['meal'],
                              style: const TextStyle(
                                  fontFamily: 'Tajwal',
                                  color: Colors.black,
                                  fontSize: 30),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "لا يوجد كورس الى الآن",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        );
                      }
                    },
                  ));
            },
          )),
    );
  }
}
