// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/core/functions/uploadfile.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AddNewExeController extends GetxController {
  bool visible = false;
  bool loading = false;
  late TextEditingController exerciseText;
  // ignore: non_constant_identifier_names
  List<int> IDs = [];

  ///
  ///Videos Variables and Lists
  ///
  String videoUrl = "";
  List<VideoPlayerController> videosControllers = [];
  List data = [];
  List<IconData> icons = [];

  ///----------------------------------------------------------///
  ///------------------------Insert Methods--------------------///
  ///----------------------------------------------------------///
  String currentId = '0';
  Future<void> addnewexercise() async {
    var request = await http.post(Uri.parse(ApiLinks.addExercise), body: {
      'acc_id': selectedUserId.toString(),
      'day_id': sherdpref!.getInt('dayId').toString(),
      'details': exerciseText.text,
      'name': selectedUserName
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 'exercise added') {
      visible = true;
      for (var element in response['data']) {
        IDs.add(element['exe_id']);
      }
      currentId = IDs.last.toString();
      print(currentId);
    } else {
      getxDialog("", "Something error");
    }
    update();
  }

  double perc = 0.0;
  Future<void> addVideosToCurrentExe() async {
    if (videos == []) return;
    loading = true;
    update();
    if (await postRequestWithListFile(
            ApiLinks.insertVideos, {'exe_id': currentId.toString()}, videos) ==
        'تم رفع الفيديوهات بنجاح') {
      loading = false;
      getxDialog('إضافة فيديوهات', 'تم رفع الفيديوهات بنجاح');
    } else {
      loading = false;
      getxDialog('خطأ', 'حصل خطأ أثناء رفع الفيديوهات');
    }
    update();
  }

  Future<void> updatexe() async {}

  ///-------------------------------------------------------///
  ///-----------------------Picked Methods------------------///
  ///-------------------------------------------------------///
  List<XFile> pickedvideos = [];
  List<File> videos = [];
  List<String> names = [];
  double sum = 0;
  pickMultiVideos() async {
    pickedvideos = await ImagePicker().pickMultipleMedia();
    if (pickedvideos == []) return;

    videos.clear();
    names.clear();
    for (var element in pickedvideos) {
      videos.add(File(element.path));
      names.add(element.path.split("/").last);
    }

    generateVideosControllers();
    update();
  }

  clearAllVideos() {
    if (videos != []) {
      pickedvideos.clear();
      videos.clear();
      names.clear();
    }
    update();
  }

  @override
  void onInit() {
    exerciseText = TextEditingController();
    super.onInit();
  }

  ///----------------------------------------------------------///
  ///------------------------Videos Methods--------------------///
  ///----------------------------------------------------------///
  void generateVideosControllers() {
    ///
    ///Generate Videos Controllers
    ///
    for (int i = 0; i < videos.length; i++) {
      videosControllers = List.generate(
          videos.length,
          (i) => VideoPlayerController.file(
                videos[i],
              )..initialize().then((_) {
                  update();
                  // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                }));
      icons = List.generate(videos.length, (index) => Icons.play_circle);
    }
  }

  controllerVideo(VideoPlayerController videoPlayerController, i) {
    ///
    ///Controle The video "Playe Puase and Listen to it to check the status"
    ///
    videoPlayerController.value.isPlaying
        ? videoPlayerController.pause()
        : videoPlayerController.play();

    videosControllers[i].addListener(() {
      if (videosControllers[i].value.isCompleted == false) {
        if (videosControllers[i].value.isPlaying) {
          icons[i] = Icons.pause_circle;
        } else {
          icons[i] = Icons.play_circle;
          update();
        }
      } else if (!videosControllers[i].value.isInitialized) {
        icons[i] = Icons.play_circle;
      } else {
        icons[i] = Icons.play_circle;
      }
      if (videosControllers[i].value.isCompleted) {
        icons[i] = Icons.play_circle;
      }
    });
    update();
  }

  ///
  ///change the icon of status
  ///
  IconData icon = Icons.play_arrow;
  void changeIcon(VideoPlayerController videoPlayerController, int index) {
    videoPlayerController.value.isPlaying == false
        ? icons[index] = Icons.play_circle
        : icons[index] = Icons.pause_circle;
    update();
  }

  @override
  void onClose() {
    for (var element in videosControllers) {
      element.dispose();
    }
    super.onClose();
  }
}
