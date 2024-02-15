import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/playerscontroller.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';

import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/coachpages/captinbuttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachProfile extends StatelessWidget {
  const CoachProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlayersController());
    return WillPopScope(onWillPop: () {
      Get.offAllNamed(AppRoute.players_C);
      return Future.value(false);
    }, child: GetBuilder<PlayersController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              title: const Text(
                "صفحة اللاعب",
                style: TextStyle(
                    color: Colors.black, fontSize: 30, fontFamily: 'Tajwal'),
              ),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoute.players_C);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        backgroundColor: const Color.fromARGB(255, 14, 82, 138),
                        title: "",
                        content: const Text(
                          "هل تود حذف هذا اللاعب ؟ \nسيتم حذف كل مايتعلق بهذا اللاعب من معلومات",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        cancel: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.cancel, color: Colors.white),
                        ),
                        confirm: IconButton(
                          onPressed: () {
                            controller.deleteUser();
                          },
                          icon: const Icon(Icons.done, color: Colors.white),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ))
              ],
            ),
            backgroundColor: AppColors.scaffoldBackGroundColor,
            body: ListView(
              children: [
                SizedBox(
                  width: width,
                  height: height,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.imagename != ""
                                ? SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width / 2.5,
                                    height:
                                        MediaQuery.sizeOf(context).height / 4.5,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        controller.imagename,
                                      ),
                                    ))
                                : SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width / 2.5,
                                    height:
                                        MediaQuery.sizeOf(context).height / 4.5,
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black,
                                      child: Icon(
                                        Icons.person,
                                        size: 100,
                                      ),
                                    )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  selectedUserName,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1.7,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          CaptinButtons(
                            onPressed: () {
                              controller.getplayerdetails();
                              Get.toNamed(AppRoute.playerdetails_C);
                            },
                            text: "التفاصيل",
                            icon: Icons.list_rounded,
                            color: AppColors.buttonsColor,
                          ),
                          CaptinButtons(
                            onPressed: () async {
                              //await controller.fetchBodyImages();
                              Get.toNamed(AppRoute.palyerImages_C);
                            },
                            text: "الصور",
                            icon: Icons.image,
                            color: AppColors.detailsButtons,
                          ),
                          CaptinButtons(
                            onPressed: () {
                              Get.toNamed(AppRoute.adminExe);
                            },
                            text: "التمارين",
                            icon: Icons.fitness_center_rounded,
                            color: AppColors.buttonsColor,
                          ),
                          CaptinButtons(
                            onPressed: () {
                              Get.toNamed(AppRoute.displayFood);
                            },
                            text: "الغذاء",
                            icon: Icons.food_bank_rounded,
                            color: AppColors.detailsButtons,
                          ),
                          CaptinButtons(
                            onPressed: () {
                              Get.toNamed(AppRoute.suppcourse);
                            },
                            text: "المكملات",
                            icon: Icons.health_and_safety_rounded,
                            color: AppColors.detailsButtons,
                          ),
                        ],
                      )
                      // ListView(
                      //   shrinkWrap: true,
                      //   children: [
                      //     CaptinButtons(
                      //       onPressed: () {
                      //         controller.getplayerdetails();
                      //         Get.toNamed(AppRoute.playerdetails_C);
                      //       },
                      //       text: "التفاصيل",
                      //       icon: Icons.list_rounded,
                      //       color: AppColors.detailsButtons,
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     CaptinButtons(
                      //       onPressed: () {
                      //         // controller.goToThePage(AppRoute.palyerImages_C);
                      //       },
                      //       text: "الصور",
                      //       icon: Icons.image,
                      //       color: AppColors.detailsButtons,
                      //     ),
                      //     CaptinButtons(
                      //       onPressed: () {
                      //         Get.offAllNamed(AppRoute.adminExe);
                      //       },
                      //       text: "التمارين",
                      //       icon: Icons.fitness_center_rounded,
                      //       color: AppColors.detailsButtons,
                      //     ),
                      //     CaptinButtons(
                      //       onPressed: () {
                      //         Get.offAllNamed(AppRoute.foodcourse);
                      //       },
                      //       text: "الغذاء",
                      //       icon: Icons.food_bank_rounded,
                      //       color: AppColors.detailsButtons,
                      //     ),
                      //     CaptinButtons(
                      //       onPressed: () {},
                      //       text: "المكملات",
                      //       icon: Icons.health_and_safety_rounded,
                      //       color: AppColors.detailsButtons,
                      //     ),
                      //   ],
                      // )
                    ]),
                  ),
                ),
              ],
            ));
      },
    ));
  }
}
