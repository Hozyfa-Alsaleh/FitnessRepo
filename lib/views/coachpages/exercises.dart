// ignore_for_file: avoid_print

import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/controllers/CaptinControllers/adminexecontroller.dart';
import 'package:captainshoaib/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminExercises extends StatelessWidget {
  const AdminExercises({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminExeController());
    return WillPopScope(
      onWillPop: () {
        sherdpref!.remove('dayId');
        Get.offAllNamed(AppRoute.coachprofile_C);

        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: AppColors.scaffoldBackGroundColor,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            toolbarHeight: 100,
            title: const Text(
              "الأيام",
              style: TextStyle(
                  fontFamily: 'Tajwal',
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: GetBuilder<AdminExeController>(
            builder: (controller) {
              return SizedBox(
                width: width,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        sherdpref!.setInt('dayId', index + 1);
                        print(sherdpref!.getInt('dayId'));
                        controller.fetchExerciseForDay(index + 1);
                        Get.toNamed(AppRoute.displayExe);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        height: 90,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(192, 1, 52, 110),
                                width: 3.5),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          leading: const Icon(
                            Icons.info_outline,
                            size: 30,
                            color: Colors.black,
                          ),
                          title: Text(
                            controller.daysname[index],
                            style: const TextStyle(
                                fontFamily: 'Tajwal',
                                color: Colors.black,
                                fontSize: 25),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )),
    );
  }
}
// ExerciseCard(
//                             dayname: controller.dayname,
//                             color: controller.lineColorsList[index],
//                             controller: controller.myControllerList[index],
//                             videoname: controller.videoName == null &&
//                                     controller.isUpdate == false
//                                 ? "لايوجد فيديو إلى الآن"
//                                 : controller.videoNames[index],
//                             onPressed: () {
//                               controller.pickExerciseVideo(index);

//                               print(controller.videoName);
//                               // controller.currentCard(index);
//                             },
//                             send: () {
//                               controller.onPressedSendButton(index, index);
//                               print(controller.details);
//                             },
//                           );