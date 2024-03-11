import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/views/Home/infoimageviewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:captainshoaib/controllers/infocontroller.dart';
import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/physicinfo.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/playercondition.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/targetofexercise.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/usinghormon.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/workstressinfo.dart';
import 'package:captainshoaib/widgets/information/pickimagebutton.dart';
import 'dart:io';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrl = Get.put(InfoController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.PlayerProfile);
        return false;
      },
      child: Scaffold(
          backgroundColor: AppColors.scaffoldBackGroundColor,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.PlayerProfile);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  )),
            ],
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            toolbarHeight: 100,
            title: const Text(
              "معلومات اللاعب",
              style: TextStyle(
                  fontSize: 30, color: Colors.black, fontFamily: 'Tajwal'),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: ctrl.resetInfo,
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.black,
                )),
          ),
          body: GetBuilder<InfoController>(builder: (controller) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                children: [
                  Form(
                      key: controller.infoFormKey,
                      child: Column(
                        children: [
                          ///-------------PhiscalInformation-----------///
                          PhysicsInfo(
                            playerNameCtrl: controller.playerName,
                            weightCtrl: controller.weight,
                            heightCtrl: controller.height,
                            ageCtrl: controller.age,
                            centerCtrl: controller.center,
                            addressCtrl: controller.address,
                            sleepHoursCtrl: controller.sleepHours,
                            workHoursCtrl: controller.workHours,
                            historyWithgameCtrl: controller.historyWithgame,
                          ),

                          ///
                          const SizedBox(
                            height: 25,
                          ),

                          ///---------------Work Stress
                          WorkStressInfo(color: controller.workcolor),
                          const SizedBox(
                            height: 25,
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment,
                            children: [
                              ///------------------The Target from exercise
                              TargetOfExercise(color: controller.exercisecolor),

                              ///
                              const SizedBox(
                                height: 25,
                              ),

                              ///-------------Using Hormon
                              UsingHormon(
                                color: controller.hormoncolor,
                              ),

                              ///
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              ///----------------Notes for the player condition
                              PlayerConditionNotes(
                                infectionCtrl: controller.infection,
                                excludedFoodsCtrl: controller.excludedFoods,
                              ),

                              ///
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible:
                                    controller.isUpdate == true ? true : false,
                                child: InkWell(
                                  onTap: () {
                                    //Update just Info
                                    controller.updatePlayerInfo();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 3,
                                            color: AppColors.buttonsColor)),
                                    child: const Text(
                                      "تعديل المعلومات",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Tajwal',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(color: Colors.grey),
                              const SizedBox(
                                height: 20,
                              ),
                              GetBuilder<InfoController>(builder: (controller) {
                                return Row(
                                  mainAxisAlignment: controller.images.isEmpty
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "الصور :",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Tajwal',
                                          color: Colors.black),
                                    ),
                                    Visibility(
                                      visible: controller.images.isEmpty
                                          ? false
                                          : true,
                                      child: IconButton(
                                        onPressed: () {
                                          //Update just Images
                                          controller.updateJustImages();
                                        },
                                        icon: const Icon(
                                          Icons.edit_rounded,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              Visibility(
                                visible:
                                    controller.imageName == null ? false : true,
                                child: GetBuilder<InfoController>(
                                    builder: (controller) {
                                  return SizedBox(
                                    width: width,
                                    height: height! / 4.5,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: controller.images.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () {
                                              Get.to(InfoImageView(
                                                  path: controller
                                                      .images[index].path));
                                            },
                                            child: Container(
                                              width: width! / 2,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 179, 175, 175),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Image.file(
                                                File(controller
                                                    .images[index].path),
                                                fit: BoxFit.contain,
                                              ),
                                            ));
                                      },
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(
                                height: 30,
                              ),

                              ///----------PickImage Button
                              GetBuilder<InfoController>(builder: (controller) {
                                return Row(
                                  mainAxisAlignment:
                                      controller.imageName == null
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.spaceEvenly,
                                  children: [
                                    PickImageButton(
                                        text: "إرفاق الصور",
                                        onPressed: () {
                                          controller.pickImage();
                                        }),
                                    Visibility(
                                      visible: controller.imageName == null
                                          ? false
                                          : true,
                                      child: PickImageButton(
                                          text: "حذف الصور",
                                          onPressed: () {
                                            controller.deleteCurrentPic();
                                          }),
                                    )
                                  ],
                                );
                              }),
                              const SizedBox(
                                height: 15,
                              ),

                              ///----------------Send Information Button

                              Visibility(
                                visible:
                                    controller.isUpdate == false ? true : false,
                                child: InkWell(
                                  onTap: () {
                                    // if (controller.isUpdate == false) {
                                    controller.goToPackags();
                                    // } else {
                                    //   controller.updatePlayerInfo();
                                    // }
                                    //controller.goToPackags();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    width: width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 3,
                                            color: AppColors.buttonsColor)),
                                    child: const Text(
                                      "التالي",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Tajwal',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
              ////
            );
          })),
    );
  }
}
