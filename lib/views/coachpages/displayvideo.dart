import 'package:captainshoaib/controllers/CaptinControllers/adminexecontroller.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/views/coachpages/exedetails.dart';
import 'package:captainshoaib/widgets/coachpages/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayVideo extends StatelessWidget {
  final int index;

  const DisplayVideo({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminExeController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async {
          await controller.disposeVideos();
          // controller.videos.clear();
          Get.off(() => ExeDetails());
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: SizedBox(
              width: width,
              height: height,
              child: CustomeVideoPlayer(
                person: "admin",
                vidController: controller.videosControllers[index],
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
              )),
        ),
      );
    });
  }
}