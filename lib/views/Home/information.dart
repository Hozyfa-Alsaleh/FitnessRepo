import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/controllers/infocontroller.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/physicinfo.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/playercondition.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/targetofexercise.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/usinghormon.dart';
import 'package:captainshoaib/widgets/information/InfoStructerScreen/workstressinfo.dart';
import 'package:captainshoaib/widgets/information/pickimagebutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  onPressed: ctrl.resetInfo,
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.black,
                  )),
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
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
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
                              const Divider(color: Colors.grey),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                controller.imageName == null
                                    ? "لا يوجد صورة"
                                    : controller.imageName!,
                                style: const TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                height: 30,
                              ),

                              ///----------PickImage Button
                              PickImageButton(
                                  text: "إرفاق الصور",
                                  onPressed: () {
                                    controller.pickImage();
                                  }),
                              const SizedBox(
                                height: 15,
                              ),

                              ///----------------Send Information Button

                              InkWell(
                                onTap: () {
                                  if (controller.isUpdate == false) {
                                    controller.goToPackags();
                                  } else {
                                    controller.updatePlayerInfo();
                                  }
                                  //controller.goToPackags();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  width: MediaQuery.sizeOf(context).width / 2.3,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          width: 2,
                                          color: AppColors.buttonsColor)),
                                  child: Text(
                                    controller.isUpdate == false
                                        ? "التالي"
                                        : "تعديل",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
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
