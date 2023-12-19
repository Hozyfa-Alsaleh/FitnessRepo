import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController controller;
  bool valuee = false;
  @override
  void onInit() {
    controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://cinemana-pro.com/apiCaptine/admin/video/VID_20231114_152217.mp4'),
    )..initialize().then((_) {
        update();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
    //update();
    controller.addListener(() {
      if (controller.value.isCompleted == false) {
        if (controller.value.isPlaying) {
          icon = Icons.pause;
        } else {
          icon = Icons.play_arrow;
        }
      } else if (!controller.value.isInitialized) {
        icon = Icons.play_arrow;
      } else {
        icon = Icons.play_arrow;
      }
      update();
    });
    super.onInit();
  }

  controllerVideo() {
    controller.value.isPlaying ? controller.pause() : controller.play();
    update();
  }

  IconData icon = Icons.play_arrow;
  void changeIcon() {
    controller.value.isPlaying == false
        ? icon = Icons.play_arrow
        : icon = Icons.pause;
    update();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
