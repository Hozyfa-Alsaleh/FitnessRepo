// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/core/functions/uploadfile.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/models/exercies.dart';
import 'package:fitnessapp/models/videos.dart';
import 'package:fitnessapp/views/coachpages/displayexercise.dart';
import 'package:fitnessapp/views/coachpages/exedetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

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
  int currentindex = 0;
  int currentExeId = 0;
  Color lineColor = const Color.fromARGB(255, 10, 76, 131);
  File? videoFile;
  List<String> videoNames = ['null'];
  List<ExerciesModel> exercieses = [];
  List<ExerciesModel> allExercises = [];
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
  List<ChewieController> chewieControllers = [];

  List data = [];
  List<IconData> icons = [];
  TextEditingController editExe = TextEditingController();
  late TextEditingController searchbar;

  ///---------------------Picked Video------------------///
  pickExerciseVideo(int index) async {
    var pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo == null) return;
    videoFile = File(pickedVideo.path);
    var count = await videoFile!.length();
    print("==============>> ${count.toString()}");
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

  backToExercisesPage() {
    disposeVideos();
    videos.clear();
    newvideo = null;
    pickedvideos = null;
    newvideos.clear();
    newvideosforexe.clear();
    Get.to(() => const DisplayExercise());
    update();
  }

  ///Delete whole Exercise Method
  Future<void> deleteExeCourse() async {
    var request = await http.post(Uri.parse(ApiLinks.exedelete), body: {
      'exe_id': currentExeId.toString(),
      'acc_id': selectedUserId.toString(),
      'details': currentExercise.toString(),
      'day_id': dayId.toString()
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      backToExercisesPage();
    } else {
      getxDialog('حذف التمرين', 'حدث خطأ أثناء حذف التمريمن');
    }
  }

  ///Delete Video Method
  Future<void> deleteVideo(int vidId, int index) async {
    int vidnum = index + 1;
    var request = await http.post(Uri.parse(ApiLinks.deleteVideos), body: {
      'vid_id': vidId.toString(),
      'details': currentExercise,
      'vidnum': vidnum.toString(),
      'acc_id': selectedUserId.toString(),
      'day_id': dayId.toString()
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      getxDialog("حذف الفيديو", "تم حذف الفيديو بنجاح");
    } else {
      getxDialog('خطأ', 'حدث خطأ أثناء حذف الفيديو ');
    }
    videos.removeAt(index);
    videosControllers.removeAt(index);
    backToExercisesPage();
    update();
  }

  Future<void> updateExeCourse() async {
    var request = await http
        .post(Uri.parse("${ApiLinks.proteam}/exercises.php?update"), body: {
      'details': editExe.text,
      'acc_id': selectedUserId.toString(),
      'day_id': sherdpref!.getInt('dayId').toString(),
      'name': selectedUserName,
      'exe_id': currentExeId.toString(),
      'oldname': currentExercise.toString()
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

  ///
  ///=----------------Update Videos--------------///
  ///
  getVideosInfo(int index) {
    pickMultiVideos(index);
    update();
  }

  bool loading = false;

  ///-------------------------------------------------------///
  ///-----------------------Picked Methods------------------///
  ///-------------------------------------------------------///
  XFile? pickedvideos;
  List<XFile> newvideos = [];
  List<File> newvideosforexe = [];
  File? newvideo;
  String? names;
  double sum = 0;
  int currentIndexVideo = -1;
  pickMultiVideos(int index) async {
    if (index > -1) {
      pickedvideos = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (pickedvideos == null) return;
      newvideo = File(pickedvideos!.path);
      videosControllers[index] = VideoPlayerController.file(
        newvideo!,
      )..initialize().then((_) {
          update();
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        });
      currentIndexVideo = index;
      print("------------> $currentIndexVideo");
    } else {
      newvideos = await ImagePicker().pickMultipleMedia();
      if (newvideos.isEmpty) return;
      for (var element in newvideos) {
        newvideosforexe.add(File(element.path));
        videosControllers.add(VideoPlayerController.file(File(element.path))
          ..initialize().then((value) => update()));
        videos.add(Videos(exeId: currentExeId));
        icons.add(Icons.play_circle);
      }

      update();
    }
    update();
  }

  //
  //New Videos for exesit exercise
  bool newSending = false;
  Future<void> addNewVideosToCurrentExe() async {
    if (videos == []) return;
    newSending = true;
    update();
    if (await postRequestWithListFile(
            ApiLinks.insertVideos,
            {
              'exe_id': currentExeId.toString(),
              'details': currentExercise,
              'day_id': dayId.toString(),
              'acc_id': selectedUserId.toString()
            },
            newvideosforexe) ==
        'تم رفع الفيديوهات بنجاح') {
      newSending = false;
      getxDialog('إضافة فيديوهات', 'تم رفع الفيديوهات بنجاح');
      newvideos.clear();
      newvideosforexe.clear();
      fetchCurrentExercise(currentindex, currentExeId);
      update();
    } else {
      newSending = false;
      getxDialog('خطأ', 'حصل خطأ أثناء رفع الفيديوهات');
    }
    update();
  }

  Future<void> updatexe(int vidId, int index) async {
    if (videos == []) return;
    if (vidId != videos[currentIndexVideo].id) {
      getxDialog('',
          'انت تقوم بإرسال بيانات الفيديو رقم ${currentIndexVideo + 1} عبر فيديو آخر');
    } else {
      loading = true;
      update();

      // updateRequestWithListFile(
      //     ApiLinks.updateVideos, {'vid_id': vidId}, newvideo!);
      if (await updateRequestWithListFile(
              ApiLinks.updateVideos,
              {
                'vid_id': vidId.toString(),
                'details': currentExercise,
                'day_id': dayId.toString(),
                'vidnum': (index + 1).toString(),
                'acc_id': selectedUserId.toString()
              },
              newvideo!) ==
          1) {
        loading = false;
        getxDialog('تحديث الفيديوهات', "تم تحديث الفيديوهات");
      } else {
        loading = false;
        getxDialog('خطأ', 'حدث خطأ أثناء تعديل الفيديوهات');
      }
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
      if (videos.isNotEmpty) {
        videos.clear();
        for (var element in response['data']) {
          videos.add(Videos(
              id: element['vid_id'],
              url: "${ApiLinks.video}/${element['videourl']}",
              exeId: element['exe_id']));
        }
      } else {
        for (var element in response['data']) {
          videos.add(Videos(
              id: element['vid_id'],
              url: "${ApiLinks.video}/${element['videourl']}",
              exeId: element['exe_id']));
        }
      }

      generateVideosControllers();
      currentExercise = allExercises[i].details;
      currentExeId = allExercises[i].id;
      editExe.text = currentExercise;
      currentindex = i;
      print(currentExeId);
      Get.to(() => const ExeDetails());
    } else {
      currentExercise = allExercises[i].details;
      currentExeId = allExercises[i].id;
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
      if (searchbar.text.isNotEmpty) return;
      if (exercieses.isNotEmpty) {
        exercieses.clear();
      }
      for (var element in response['data']) {
        exercieses.add(
            ExerciesModel(id: element['exe_id'], details: element['details']));
      }
      dayId = sherdpref!.getInt('dayId')!;

      if (allExercises.isNotEmpty) {
        allExercises.clear();
      }
      allExercises.addAll(exercieses.reversed);

      //Get.toNamed(AppRoute.displayExe);
      return response['data'];
    } else {
      /// Get.toNamed(AppRoute.displayExe);
      exercieses.clear();
      allExercises.clear();
      return null;
    }
  }

  @override
  void onInit() {
    //fetchExeCourse();
    searchbar = TextEditingController();
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
    if (videosControllers.isNotEmpty) {
      videosControllers.clear();
      for (int i = 0; i < videos.length; i++) {
        videosControllers.add(
          VideoPlayerController.networkUrl(
            Uri.parse(videos[i].url),
          )..initialize().then((_) {
              update();
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            }),
        );

        icons = List.generate(videos.length, (index) => Icons.play_circle);
      }

      for (int i = 0; i < videosControllers.length; i++) {
        chewieControllers.add(ChewieController(
            videoPlayerController: videosControllers[i],
            autoPlay: true,
            looping: true));
      }
      update();
    } else {
      for (int i = 0; i < videos.length; i++) {
        videosControllers.add(VideoPlayerController.networkUrl(
          Uri.parse(videos[i].url),
        )..initialize().then((value) {
            update();
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          }));

        icons = List.generate(videos.length, (index) => Icons.play_circle);
      }

      for (int i = 0; i < videosControllers.length; i++) {
        chewieControllers.add(ChewieController(
            videoPlayerController: videosControllers[i],
            autoPlay: true,
            looping: true));
      }
      update();
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

  Future<void> disposeVideos() async {
    for (var element in videosControllers) {
      element.dispose();
    }
    for (var element in chewieControllers) {
      element.dispose();
    }
    videosControllers.clear();
    chewieControllers.clear();
    update();
  }

  void searchAboutExercise(String value) {
    if (allExercises.isNotEmpty) {
      allExercises.clear();
    }
    if (value.isNotEmpty) {
      List<ExerciesModel> filterdList = exercieses
          .where((element) => element.details.contains(value))
          .toList();
      allExercises.addAll(filterdList.reversed);
    }

    update();
  }

  void clearSearchBar() {
    searchbar.clear();
    update();
  }
}
