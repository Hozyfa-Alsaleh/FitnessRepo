import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/controllers/CaptinControllers/adminexecontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/views/coachpages/displayexercise.dart';
import 'package:fitnessapp/widgets/coachpages/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';

class ExeDetails extends StatelessWidget {
  const ExeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminExeController>(
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvoked: (val) {
            controller.backToExercisesPage();
          },
          child: Scaffold(
              backgroundColor: AppColors.scaffoldBackGroundColor,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0.0,
                backgroundColor: Colors.white,
                // toolbarHeight: height! / 7,
                title: const Text(
                  "تفاصيل التمرين",
                  style: TextStyle(
                      color: Colors.black, fontSize: 33, fontFamily: 'Tajwal'),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    controller.backToExercisesPage();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 14, 82, 138),
                            title: "حذف التمرين",
                            titleStyle: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Tajwal',
                                fontSize: 20),
                            middleText: "هل أنت متأكد أنك تريد حذف التمرين؟",
                            middleTextStyle: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Tajwal',
                                fontSize: 24),
                            cancel: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.green,
                                    size: 30,
                                  )),
                            ),
                            confirm: Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: IconButton(
                                  onPressed: () {
                                    controller.deleteExeCourse();
                                  },
                                  icon: const Icon(
                                    Icons.done_outline_rounded,
                                    color: Colors.red,
                                    size: 30,
                                  )),
                            ));
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 30,
                      ))
                ],
              ),
              body: SizedBox(
                width: width,
                height: height,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
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
                        decoration: InputDecoration(
                          suffix: IconButton(
                              onPressed: () {
                                controller.updateExeCourse();
                              },
                              icon: const Icon(Icons.edit)),
                          hintText: "Write new exercise here",
                          hintStyle: const TextStyle(color: Colors.black),
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blue, width: 3)),
                        child: MaterialButton(
                          onPressed: () {
                            controller.pickMultiVideos(-1);
                          },
                          child: const Text(
                            "أرفق فيديو",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Tajwal',
                                fontSize: 25),
                          ),
                        )),
                    Visibility(
                      visible: controller.newvideos.isEmpty ? false : true,
                      child: controller.newSending == false
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: Colors.blue, width: 3)),
                              child: MaterialButton(
                                onPressed: () {
                                  controller.addNewVideosToCurrentExe();
                                },
                                child: const Text(
                                  "إرسال الفيديوهات الجديدة",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Tajwal',
                                      fontSize: 25),
                                ),
                              ))
                          : const LinearProgressIndicator(),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.videos.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.getVideosInfo(index);
                                      },
                                      icon: const Icon(
                                          Icons.edit_calendar_outlined)),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 14, 82, 138),
                                              title: "",
                                              content: const Text(
                                                "هل تود حذف الفيديو؟",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontFamily: 'Tajwal'),
                                              ),
                                              cancel: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 40),
                                                child: IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.green,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                              confirm: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 40),
                                                child: IconButton(
                                                  onPressed: () {
                                                    controller.deleteVideo(
                                                        controller
                                                            .videos[index].id,
                                                        index);
                                                    Get.back();
                                                  },
                                                  icon: const Icon(
                                                    Icons.done_outline_rounded,
                                                    color: Colors.green,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                      controller.loading == true
                                          ? const CircularProgressIndicator()
                                          : Visibility(
                                              visible:
                                                  controller.newvideo == null
                                                      ? false
                                                      : true,
                                              child: IconButton(
                                                  onPressed: () {
                                                    controller.updatexe(
                                                        controller
                                                            .videos[index].id,
                                                        index);
                                                  },
                                                  icon: const Icon(
                                                      Icons.send_rounded)),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(10),
                            //   child: SizedBox(
                            //     height: 200,
                            //     child: Chewie(
                            //       controller:
                            //           controller.chewieControllers[index],
                            //     ),
                            //   ),
                            // )
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CustomeVideoPlayer(
                                person: "admin",
                                vidController:
                                    controller.chewieControllers[index],
                                icon: controller.icons[index],
                                fullScreen: () {
                                  controller.changeToFullScreen(index, context);
                                },
                                playVideo: () {
                                  controller.controllerVideo(
                                      controller.videosControllers[index],
                                      index);
                                  controller.changeIcon(
                                      controller.videosControllers[index],
                                      index);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
