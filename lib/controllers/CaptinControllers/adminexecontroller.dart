// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/models/exercies.dart';
import 'package:fitnessapp/models/videos.dart';
import 'package:fitnessapp/views/coachpages/exedetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

class AdminExeController extends GetxController {
  String newValue = 'يوم واحد';
  late TextEditingController dayname;
  List<TextEditingController> myControllerList = List.generate(
    7,
    (index) => TextEditingController(),
  );

  int dayId = 0;
  int count = 0;
  bool isUpdate = false;
  String? videoName;
  String? cardVideoName;
  String details = "";
  String currentExercise = "";
  int currentExeId = 0;
  Color lineColor = const Color.fromARGB(255, 10, 76, 131);
  File? videoFile;
  List<String> videoNames = ['null'];
  List<ExerciesModel> exercieses = [];
  List<Videos> videos = [];
  List<Color> lineColorsList = [];
  List<String> daysname = [
    'اليوم الأول',
    'اليوم الثاني',
    "اليوم الثالث",
    "اليوم الرابع",
    "اليوم الخامس",
    "ليوم السادس",
    "اليوم السابع"
  ];
  String videoUrl = "";
  List<VideoPlayerController> videosControllers = [];
  List data = [];
  List<IconData> icons = [];
  TextEditingController editExe = TextEditingController();

  ///---------------------Picked Video------------------///
  pickExerciseVideo(int index) async {
    var pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo == null) return;
    videoFile = File(pickedVideo.path);
    videoName = videoFile!.path.split("/").last;
    videoNames[index] = videoName!;
    update();
  }

  ///-----------------------------------------------------------------------///
  ///---------------------Insert Update Delete Methods----------------------///
  ///-----------------------------------------------------------------------///

  Future<void> sendExeToDB(int id, String videoname) async {
    ///Send Data to the database
    if (details == "") return;
    var base64 = base64Encode(videoFile!.readAsBytesSync());

    var request = await http.post(Uri.parse(ApiLinks.addExercise), body: {
      'id_user': selectedUserId.toString(),
      'day': id.toString(),
      'details': details,
      'video': videoname,
      'video64': base64,
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      lineColor = Colors.green;
      details = "";
      getxDialog('إضافة كورس', 'تم إضافة الكورس بنجاح');
    }
    update();
  }

  Future<void> deleteExeCourse() async {}

  Future<void> updateExeCourse() async {
    var request = await http
        .post(Uri.parse("${ApiLinks.proteam}/exercises.php?update"), body: {
      'details': editExe.text,
      'acc_id': selectedUserId.toString(),
      'day_id': sherdpref!.getInt('dayId').toString(),
      'name': selectedUserName
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == "exercise updated") {
      lineColor = Colors.lightGreen;
      getxDialog('تعديل الكورس ', 'تم تحديث الكورس بنجاح');
      update();
    } else {
      getxDialog('تعديل الكورس ', 'حدث خطأ ما');
    }
    update();
  }

  ///-------------------------------------------------------------///
  ///---------------------Fetch Data Methods----------------------///
  ///-------------------------------------------------------------///
  Future fetchCurrentExercise(int i, int index) async {
    ///
    ///Fetch the data to see the details of pressed exercise "Name & Details"
    ///
    var request = await http.post(Uri.parse(ApiLinks.fetchcurrentexe), body: {
      'exe_id': index.toString(),
    });
    var response = await jsonDecode(request.body);
    // print(response);
    // print(response['data'][0]['video']);
    if (response['status'] == 1) {
      videos.clear();
      for (var element in response['data']) {
        videos.add(Videos(
            id: element['vid_id'],
            url: "${ApiLinks.video}/${element['videourl']}",
            exeId: element['exe_id']));
      }
      generateVideosControllers();
      currentExercise = exercieses[i].details;
      currentExeId = exercieses[i].id;
      editExe.text = currentExercise;
      print(currentExeId);
      Get.to(() => const ExeDetails());
    } else {
      currentExercise = exercieses[i].details;
      currentExeId = exercieses[i].id;
      editExe.text = currentExercise;
      Get.to(() => const ExeDetails());
      getxDialog("", "There are no videos");
    }
    update();
  }

  Future fetchExerciseForDay(int index) async {
    exercieses.clear();
    var request = await http.post(Uri.parse(ApiLinks.exerciseFetch), body: {
      'day_id': index.toString(),
      'acc_id': selectedUserId.toString()
    });

    var response = await jsonDecode(request.body);
    print(response);
    if (response['status'] == 1) {
      if (exercieses.isNotEmpty) {
        exercieses.clear();
      }
      for (var element in response['data']) {
        exercieses.add(
            ExerciesModel(id: element['exe_id'], details: element['details']));
      }
      dayId = index;
      Get.toNamed(AppRoute.displayExe);
    } else {
      Get.toNamed(AppRoute.displayExe);

      return null;
    }
  }

  @override
  void onInit() {
    //fetchExeCourse();
    dayname = TextEditingController();
    videoNames = List.generate(
        count == 0 ? 7 : count, (index) => "لا يوجد فيديو إلى الآن");
    lineColorsList =
        List.generate(7, (index) => const Color.fromARGB(255, 10, 76, 131));
    getdataFromCountApi();
    update();
    super.onInit();
  }

  onPressedSendButton(int index, int listindex) {
    details = myControllerList[index].text;
    lineColorsList[index] = Colors.green;
    print(lineColorsList);
    if (isUpdate == true) {
      updateExeCourse();
    } else if (isUpdate == false) {
      sendExeToDB(index + 1, videoNames[index]);
    }
    update();
  }

  int dayscount = 0;
  List<String> days = [];
  List<int> exenumber = [];
  getdataFromCountApi() async {
    var request = await http.post(Uri.parse(ApiLinks.exerciseFetch),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      for (var element in response['data']) {
        // days.add(element['day']);
        // exenumber.add(int.parse(element['countExe']));
        // dayscount++;
        print(element);
      }
      print(days);
      print(response);
    } else {
      print("errorrrrrrrrrrrrrrrrr");
    }
    update();
  }

  ///------------------------------------------------------------------///
  ///--------------------------Videos Methods ------------------------///
  ///-----------------------------------------------------------------///
  ///

  void generateVideosControllers() {
    ///
    ///Generate Videos Controllers
    ///
    ///

    for (int i = 0; i < videos.length; i++) {
      videosControllers.add(VideoPlayerController.networkUrl(
        Uri.parse(videos[i].url),
      )..initialize().then((_) {
          update();
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        }));

      icons = List.generate(videos.length, (index) => Icons.play_circle);
    }
    print(videosControllers);
    print(videosControllers[0].value.rotationCorrection);
  }

  bool fullscreen = false;
  changeToFullScreen(int index, BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    }
    update();
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
