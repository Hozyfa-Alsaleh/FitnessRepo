// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/core/functions/handlingdata.dart';
import 'package:fitnessapp/core/functions/uploadfile.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/models/playerdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PlayerProfileController extends GetxController {
  int currentIndex = 0;
  Color? detailsColor;
  Color? imagesColor;
  late PageController pageController;
  File? pickedImage;
  String imagename = "";
  String previousImg = "";
  List<PlayerDetails> playerInfo = [];

  List<String> titles = [
    ///fixed values
    ///uncompleted list
    'الهدف من التمرين',
    "المنطقة",
    "القاعة",
    "العمر",
    "الطول",
    "الوزن",
    "ساعات النوم",
    "ساعات العمل",
    "ضغط العمل",
    "منذ متى يمارس اللعبة",
    "استخدام الهرمونات",
    "الإصابات",
    "أطعمة لايرغب بتناولها",
  ];
  bool updatepro = false;
  Future<void> pickeImage() async {
    //try {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image.path);
      String newimagename = pickedImage!.path.split("/").last;

      await postRequestWithFile(
          updatepro == false
              ? ApiLinks.insertProfileImg
              : ApiLinks.updateProfileImg,
          {
            'acc_id': sherdpref!.getString('userId').toString(),
            'imgUrl': updatepro == false ? newimagename : previousImg
          },
          pickedImage!);
      displayProfileImage();
    }
    // } catch (e) {
    //   print(e.toString());
    // }
    update();
  }

  ///Display the profile photo
  Future displayProfileImage() async {
    try {
      var request = await http.post(Uri.parse(ApiLinks.profileimg), body: {
        'acc_id': sherdpref!.getString('userId'),
      });
      var response = await jsonDecode(request.body);
      for (var element in response['data']) {
        imagename = "${ApiLinks.profileFolder}/${element['imgUrl'].toString()}";
      }
      previousImg = imagename.split("/").last;
      if (imagename != "") {
        updatepro = true;
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  ///This Method is for switch between Photos And Info
  switchthePage(int index) {
    currentIndex = index;
    pageController.animateToPage(currentIndex,
        duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
    if (currentIndex == 0) {
      detailsColor = const Color.fromARGB(235, 1, 51, 110);
    } else {
      detailsColor = const Color.fromARGB(127, 1, 51, 110);
    }
    if (currentIndex == 1) {
      imagesColor = const Color.fromARGB(235, 1, 51, 110);
    } else {
      imagesColor = const Color.fromARGB(127, 1, 51, 110);
    }
    update();
  }

  ///Get User information and display them in Player info screen
  Future getdata() async {
    try {
      requestStatus = RequestStatus.loading;
      var request = await testData.getPlayerInfo(
          ApiLinks.fetchPlayerInfo, sherdpref!.getString('userId').toString());

      requestStatus = handlingdata(request);
      print(requestStatus);

      if (requestStatus == RequestStatus.offline) {
        return getxDialog('', 'أنت غير متصل بالانترنت');
      }
      if (request['status'] == 1) {
        if (playerInfo.isNotEmpty) {
          playerInfo.clear();
        }
        for (var element in request['data']) {
          playerInfo.add(PlayerDetails(
              id: element['acc_id'],
              courseState: "بانتظار الرد",
              area: element['area'],
              hall: element['hall'],
              height: element['height'],
              target: element['target'],
              weight: element['weight'],
              sleephours: element['sleephours'],
              workhours: element['workhours'],
              workstress: element['workstrees'],
              gamehistory: element['gamehistory'],
              usehormon: element['usehormon'],
              age: element['age'],
              cannon: element['cannon'],
              unlikedfood: element['unlikedfood']));
        }
        print('done');
      } else if (request['status'] == 'There are no data') {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  ///
  ///////////////////////////////GET BODY IMAGES //////////////////////////////////
  ///
  List<String> bodyPaths = [];
  fetchBodyImages() async {
    var request = await http.post(
        Uri.parse("${ApiLinks.proteam}/bodyimg.php?fetch"),
        body: {'acc_id': sherdpref!.getString('userId')});
    var response = await jsonDecode(request.body);
    print(response);
    if (response['status'] == 1) {
      if (bodyPaths.isNotEmpty) {
        bodyPaths.clear();
        for (var element in response['data']) {
          bodyPaths.add("${ApiLinks.proteam}/body/${element['imgUrl']}");
        }
      } else {
        for (var element in response['data']) {
          bodyPaths.add("${ApiLinks.proteam}/body/${element['imgUrl']}");
        }
      }

      print('success');
      return bodyPaths;
    } else {
      //update();
      print('faild');
      return null;
    }
  }

  deleteBodyImagesUpdate() {
    deleteBodyImages();
    update();
  }

  Future<void> deleteBodyImages() async {
    var request = await http.post(Uri.parse(ApiLinks.deleteBodyImages),
        body: {'acc_id': sherdpref!.getString('userId')});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      bodyPaths.clear();
      getxDialog('', 'تم حذف الصور بنجاح');
    } else {
      getxDialog('', 'حدث خطأ أثناء حذف الصور');
    }
    update();
  }

  logout() {
    FirebaseMessaging.instance
        .unsubscribeFromTopic("user${sherdpref!.getString('userId')}");
    sherdpref!.clear();
    Get.offAllNamed(AppRoute.Splash);
  }

  @override
  void onInit() {
    pageController = PageController();
    detailsColor = const Color.fromARGB(235, 1, 51, 110);
    getdata();
    displayProfileImage();
    super.onInit();
  }
}
