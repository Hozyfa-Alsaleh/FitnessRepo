import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/PlayerCoursesControllers/fetchplayerexe.dart';
import 'package:fitnessapp/widgets/coachpages/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExercisePlayerDet extends StatelessWidget {
  const ExercisePlayerDet({super.key});

  @override
  Widget build(BuildContext context) {
    FetchPlayerExeCtrl control = Get.put(FetchPlayerExeCtrl());
    return WillPopScope(
        onWillPop: () async {
          await control.disposeVideos();
          control.videosM.clear();
          Get.offNamed(AppRoute.dayExercise);
          return false;
        },
        child: GetBuilder<FetchPlayerExeCtrl>(
            init: FetchPlayerExeCtrl(),
            builder: (controller) {
              return Scaffold(
                  backgroundColor: AppColors.scaffoldBackGroundColor,
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    title: const Text(
                      "تفاصيل التمرين",
                      style: TextStyle(
                          fontFamily: "Tajwal",
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    leading: IconButton(
                      onPressed: () async {
                        await control.disposeVideos();
                        control.videosM.clear();
                        Get.offNamed(AppRoute.dayExercise);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  body: ListView(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 40, horizontal: 10),
                          child: Text(
                            controller.currentExeText,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 30),
                          )),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Divider(
                          color: Colors.black,
                          thickness: 3,
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.videosM.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            child: CustomeVideoPlayer(
                              //person: "admin",
                              vidController:
                                  controller.videosControllers[index],
                              icon: controller.icons[index],
                              playVideo: () {
                                controller.controllerVideo(
                                    controller.videosControllers[index], index);
                                controller.changeIcon(
                                    controller.videosControllers[index], index);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ));
            }));
  }
}
