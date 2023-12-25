// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/models/exercies.dart';
import 'package:fitnessapp/models/videos.dart';
import 'package:fitnessapp/views/Home/CoursesPages/exerciseplayerdet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/core/functions/handlingdata.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class FetchPlayerExeCtrl extends GetxController {
  String videoUrl = "";
  List<VideoPlayerController> videosControllers = [];
  List<ExerciesModel> data = [];
  List<IconData> icons = [];
  String currentExeText = "";
  List<String> days = [
    'اليوم الأول',
    "اليوم الثاني",
    "اليوم الثالث",
    "اليوم الرابع",
    "اليوم الخامس"
  ];
  //Fetch All Exercies For Palyer
  int daynum = 0;
  gotoexercises(int id) {
    daynum = id;
    update();

    Get.toNamed(AppRoute.dayExercise);
  }

  String exerciseid = '0';

  Future getExercises() async {
    requestStatus = RequestStatus.loading;
    var request = await testData.getAllExercisesForPlayer(ApiLinks.fetchExeUser,
        sherdpref!.getString('userId').toString(), daynum);
    requestStatus = handlingdata(request);

    print(data);
    if (requestStatus == RequestStatus.success) {
      if (request['status'] == 1) {
        if (data.isNotEmpty) {
          data.clear();
        }
        for (var element in request['data']) {
          data.add(
            ExerciesModel(
              id: element['exe_id'],
              details: element['details'],
              day: element['day_id'],
            ),
          );
        }
        //print(request['data'][0]['id']);
        return request['data'];
      } else {
        print(request);
        return null;
      }
    } else if (requestStatus == RequestStatus.offline) {
      getxDialog("خطأ", "أنت غير متصل بالإنترنت");
    } else {
      getxDialog("خطأ", "حدث خطأ غير متوقع");
    }
    update();
  }

  List<Videos> videosM = [];
  Future getvideosforexe(String exeid) async {
    var request = await http.post(Uri.parse(ApiLinks.fetchVideos),
        body: {'exe_id': exeid.toString()});
    var response = await jsonDecode(request.body);

    if (response['status'] == 1) {
      print(response);
      for (var element in response['data']) {
        videosM.add(
          Videos(
              id: element['vid_id'],
              exeId: element['exe_id'],
              url: "${ApiLinks.video}/${element['videourl']}"),
        );
      }
      generateVideosControllers();
      print("success");
    } else {
      print("faild");
    }
    update();
  }

  int count = 0;
  void generateVideosControllers() {
    for (int i = 0; i < videosM.length; i++) {
      videosControllers.add(VideoPlayerController.networkUrl(
        Uri.parse(videosM[i].url),
      )..initialize().then((_) {
          update();
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        }));
      icons = List.generate(videosM.length, (index) => Icons.play_circle);
    }
  }

  bool valuee = false;
  @override
  void onInit() {
    // getExercises();
    super.onInit();
  }

  controllerVideo(VideoPlayerController videoPlayerController, i) {
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

  gotodetails(int index) {
    getExercises();
    getvideosforexe(data[index].id.toString());
    currentExeText = data[index].details;
    update();
    Get.to(() => const ExercisePlayerDet());
    update();
  }

  getFoodCourse() async {
    var request = await http.post(Uri.parse(""), body: {});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      print("success");
    } else {
      print("Faild");
    }
  }
}
