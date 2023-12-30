import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/controllers/CaptinControllers/addnewexecontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/views/testnotify.dart';
import 'package:fitnessapp/widgets/coachpages/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewExercise extends StatelessWidget {
  const AddNewExercise({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddNewExeController());
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "إضافة تمرين جديد",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<AddNewExeController>(
          builder: (controller) {
            return SizedBox(
                width: width,
                height: height,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        const Text(
                          "خطوات إضافة تمرين : \n 1-قم بإضافة تمرين\n 2-ثم أرفق الفيديوهات الخاصة به \n يجب إرسال التمرين أولاً كي لا ترفق فيديوهات بدون تمرين",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontFamily: 'Tajwal'),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1.7,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width,
                              child: TextFormField(
                                controller: controller.exerciseText,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 7,
                                style: const TextStyle(
                                    fontSize: 22, color: Colors.black),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.addnewexercise();
                                      },
                                      icon: const Icon(
                                        Icons.send_rounded,
                                        color: Colors.black,
                                      )),
                                  hintText: "اكتب وصف التمرين",
                                  hintStyle: const TextStyle(
                                      fontFamily: 'Tajwal',
                                      color: Colors.black),
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Visibility(
                            visible: controller.loading == true ? true : false,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const LinearProgressIndicator(
                                color: Colors.blue,
                              ),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Visibility(
                          visible: controller.visible,
                          //visible: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.blue, width: 3)),
                                child: MaterialButton(
                                  onPressed: () {
                                    controller.clearAllVideos();
                                  },
                                  child: const Text(
                                    "إفراغ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontFamily: 'Tajwal'),
                                  ),
                                ),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.blue, width: 3)),
                                  child: MaterialButton(
                                    onPressed: () {
                                      controller.pickMultiVideos();
                                    },
                                    child: const Text(
                                      "أرفق فيديو",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Tajwal',
                                          fontSize: 25),
                                    ),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.blue, width: 3)),
                                  child: MaterialButton(
                                    onPressed: () {
                                      controller.addVideosToCurrentExe();
                                    },
                                    child: const Text(
                                      "إرسال",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Tajwal',
                                          fontSize: 25),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.videos == []
                              ? 0
                              : controller.videos.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomeVideoPlayer(
                                //person: "admin",
                                vidController:
                                    controller.videosControllers[index],
                                icon: controller.icons[index],
                                playVideo: () {
                                  controller.controllerVideo(
                                      controller.videosControllers[index],
                                      index);
                                  controller.changeIcon(
                                      controller.videosControllers[index],
                                      index);
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ));
          },
        ));
  }
}
