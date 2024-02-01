// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:captainshoaib/Utils/apilinks.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/core/StaticLData/staticvar.dart';
import 'package:captainshoaib/core/classes/requeststate.dart';
import 'package:captainshoaib/core/functions/getxdialog.dart';
import 'package:captainshoaib/core/functions/handlingdata.dart';
import 'package:captainshoaib/core/functions/uploadfile.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/models/playerdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

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
  //!Mark: mhamad updated this

  Future<void> pickeImage() async {
    // Check if permission is granted
    var status = await Permission.photos.request();

    if (status == null || status.isDenied) {
      // Handle the case where the user denied access to photos
      print('Permission denied kkkk');
      // You may want to show a dialog or message to inform the user
      return;
    }

    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image != null) {
        pickedImage = File(image.path);
        String newImageName = pickedImage!.path.split("/").last;

        await postRequestWithFile(
          updatepro == false
              ? ApiLinks.insertProfileImg
              : ApiLinks.updateProfileImg,
          {
            'acc_id': sherdpref!.getString('userId').toString(),
            'imgUrl': updatepro == false ? newImageName : previousImg
          },
          pickedImage!,
        );

        displayProfileImage();
      }
    } catch (e) {
      print('Error picking or uploading image: $e');
      // Handle the error, you may want to show a dialog or message to inform the user
    }

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
      for (var element in response['data']) {
        bodyPaths.add("${ApiLinks.proteam}/body/${element['imgUrl']}");
      }
      print('success');
    } else {
      print('faild');
    }
    update();
  }

  logout() {
    FirebaseMessaging.instance.unsubscribeFromTopic(
        "${sherdpref!.getString('username')}${sherdpref!.getString('userId')}");
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
