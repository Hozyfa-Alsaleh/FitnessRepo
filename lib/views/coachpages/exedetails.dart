import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/controllers/CaptinControllers/adminexecontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/views/coachpages/displayexercise.dart';

import 'package:fitnessapp/widgets/coachpages/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExeDetails extends StatelessWidget {
  const ExeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminExeController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            controller.disposeVideos();
            controller.videos.clear();

            Get.to(DisplayExercise());
            return false;
          },
          child: Scaffold(
              backgroundColor: AppColors.scaffoldBackGroundColor,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                toolbarHeight: 150,
                title: const Text(
                  "تفاصيل التمرين",
                  style: TextStyle(
                      color: Colors.black, fontSize: 33, fontFamily: 'Tajwal'),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    controller.disposeVideos();
                    controller.videos.clear();
                    Get.to(const DisplayExercise());
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        controller.updateExeCourse();
                      },
                      icon: const Icon(Icons.edit))
                ],
              ),
              body: SizedBox(
                width: width,
                //  height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            controller: controller.editExe,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            style: const TextStyle(
                                fontFamily: 'Tajwal',
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            decoration: const InputDecoration(
                              hintText: "Write new exercise here",
                              hintStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: controller.videos.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: CustomeVideoPlayer(
                              //person: "admin",
                              vidController:
                                  controller.videosControllers[index],
                              icon: controller.icons[index],
                              fullScreen: () {
                                controller.changeToFullScreen(index, context);
                              },
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
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
