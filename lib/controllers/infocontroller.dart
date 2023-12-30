// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/core/functions/handlingdata.dart';
import 'package:fitnessapp/core/functions/uploadfile.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/models/package.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class InfoController extends GetxController {
  late GlobalKey<FormState> infoFormKey;
  late TextEditingController playerName;
  late TextEditingController weight;
  late TextEditingController height;
  late TextEditingController age;
  late TextEditingController center;
  late TextEditingController address;
  late TextEditingController sleepHours;
  late TextEditingController workHours;
  late TextEditingController historyWithgame;
  late TextEditingController infection;
  late TextEditingController excludedFoods;
  Color workcolor = Colors.blue;
  Color exercisecolor = Colors.blue;
  Color hormoncolor = Colors.blue;
  String? imageName;
  String worktext = "";
  String exercisetext = "";
  String hormontext = "";
  File? file;
  List<PackageModel> packages = [];
  File? payImage;
  int packageId = 0;
  RequestStatus requeststatus = RequestStatus.loading;

  ///send information to the captin
  /// here we should send the data of player to the captin

  void resetInfo() {
    workcolor = Colors.deepOrange.shade900;
    exercisecolor = Colors.deepOrange.shade900;
    hormoncolor = Colors.deepOrange.shade900;
    worktext = "";
    exercisetext = "";
    hormontext = "";

    playerName.clear();
    weight.clear();
    height.clear();
    age.clear();
    center.clear();
    address.clear();
    sleepHours.clear();
    workHours.clear();
    historyWithgame.clear();
    infection.clear();
    excludedFoods.clear();
    update();
  }

  selectedWorkButton() {
    workcolor = Colors.blue;
    print(worktext);
    update();
  }

  selectedExerciseButton() {
    exercisecolor = Colors.blue;
    update();
  }

  selectedHormonButton() {
    hormoncolor = Colors.blue;
    update();
  }

  @override
  void onInit() {
    infoFormKey = GlobalKey<FormState>();
    playerName = TextEditingController();
    playerName.text = sherdpref!.getString('username').toString();
    weight = TextEditingController();
    height = TextEditingController();
    age = TextEditingController();
    center = TextEditingController();
    address = TextEditingController();
    sleepHours = TextEditingController();
    workHours = TextEditingController();
    historyWithgame = TextEditingController();
    infection = TextEditingController();
    excludedFoods = TextEditingController();
    fetchPlayerInfo();
    fetchbodyimages();
    super.onInit();
  }

  ///
  ///Pick Image For Player Body
  ///
  List<XFile>? picked;
  List<File> images = [];
  pickImage() async {
    picked = await ImagePicker().pickMultipleMedia();
    if (picked!.isEmpty) return;
    if (images.isNotEmpty) {
      images.clear();
    }
    for (var element in picked!) {
      images.add(File(element.path));
    }
    imageName = images[0].path.split("/").last;
    update();
  }

  ///
  ///Send the player information to the database
  ///NEED FIX
  Future<void> sendinformation() async {
    if (exercisetext == "" || hormontext == "" || worktext == "") {
      getxDialog("لم يتم الاختيار", "لم تقم باختيار بعض الخيارات");
    } else {
      if (infoFormKey.currentState!.validate()) {
        var response = await testData.sendInfo(
            ApiLinks.insertPlayerInfo,
            sherdpref!.getString('userId').toString(),
            weight.text,
            height.text,
            age.text,
            center.text,
            address.text,
            sleepHours.text,
            workHours.text,
            worktext,
            historyWithgame.text,
            exercisetext,
            hormontext,
            infection.text,
            excludedFoods.text);
        requestStatus = handlingdata(response);
        if (response == RequestStatus.offline) {
          getxDialog('خطأ', 'أنت لست متصل بالانترنت');
        }
        if (postRequestWithListFile(
                "https://captain.pro-team.pro/captineApi/bodyimg.php?insert",
                {
                  'acc_id': sherdpref!.getString('userId').toString(),
                },
                images) ==
            "OK") {
          if (response['status'] == 0) {
            getxDialog('', 'خطأ');
          } else {
            if (RequestStatus.success == requestStatus) {
              getxDialog("", "تم إضافة البيانات بنجاح");
            } else {
              getxDialog("خطـأ", requestStatus.toString());
            }
          }
        }
      } else {
        getxDialog("", "الرجاء ملئ جميع الحقول والخيارات");
      }
    }
  }

  ///
  ///Send The Subscribe Data
  bool load = false;
  sendSubscribeData() async {
    if (payImage == null) return;
    requestStatus = RequestStatus.loading;
    // try {
    postRequestWithFile(
        ApiLinks.subscribe,
        {
          'acc_id': sherdpref!.getString('userId').toString(),
          'package_id': packageId.toString(),
          'name': sherdpref!.getString('username')
        },
        payImage!);
    requeststatus = RequestStatus.success;
    load = false;
    update();
  }

  ///
  ///Send all data to the database
  ///in this method we collacte the Data pay and informations
  ///to send it to the data base in the same time
  ///
  sendAllInformations() async {
    load = true;
    update();
    await sendinformation();
    await sendSubscribeData();
  }

  ///
  ///Method for get all packages
  ///
  Future getAllPackages() async {
    // try {
    requestStatus = RequestStatus.loading;
    var request = await testData.getpackages(ApiLinks.packages);
    requestStatus = handlingdata(request);

    if (requestStatus == RequestStatus.success) {
      if (request['status'] == 1) {
        if (packages.isNotEmpty) {
          packages.clear();
        }
        for (var element in request['data']) {
          packages.add(PackageModel(
              id: element['package_id'],
              name: element['name'],
              time: element['time'],
              price: element['price'],
              details: element['details']));
        }
      }
      return packages;
    } else if (requestStatus == RequestStatus.offline) {
      return getxDialog('', 'أنت غير متصل بالانترنت');
    } else {
      return [];
    }
    //update();

    // } catch (e) {
    //   print(e.toString());
    //   return [];
    // }
  }

  goToPackags() {
    if (exercisetext == "" || hormontext == "" || worktext == "") {
      getxDialog("لم يتم الاختيار", "لم تقم باختيار بعض الخيارات");
    } else {
      if (infoFormKey.currentState!.validate()) {
        Get.toNamed(AppRoute.packages);
      }
    }
  }

  refreshpackagepage() {
    getAllPackages();
    update();
  }

  Future<void> pickPayImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      payImage = File(image.path);
    }
    update();
  }

  goToPayScreen() {
    Get.toNamed(AppRoute.contact);
    fetchContactInfo();
  }

  ///----------------------fetch player information---------------------///
  bool isUpdate = false;
  Future fetchPlayerInfo() async {
    var request = await http.post(Uri.parse(ApiLinks.fetchPlayerInfo),
        body: {'acc_id': sherdpref!.getString('userId')});
    var response = await jsonDecode(request.body);
    if (response['status'] == 0) {
      print('error');
    } else if (response['data'] == null) {
      isUpdate == false;
    } else {
      print(response);
      for (var element in response['data']) {
        weight.text = element['weight'];
        height.text = element['height'];
        age.text = element['age'];
        center.text = element['hall'];
        address.text = element['area'];
        sleepHours.text = element['sleephours'];
        workHours.text = element['workhours'];
        worktext = element['workstrees'];
        historyWithgame.text = element['gamehistory'];
        exercisetext = element['target'];
        hormontext = element['usehormon'];
        infection.text = element['cannon'];
        excludedFoods.text = element['unlikedfood'];
      }

      print(response['data']);
      isUpdate = true;
      update();
    }
  }

  ///---------Update Information--------------///
  Future<void> updatePlayerInfo() async {
    // print(images);
    // if (images.isEmpty) {
    //   getxDialog('الصور', 'لم تقم باختيار صور');
    // } else {
    var request = await http.post(Uri.parse(ApiLinks.updateinfo), body: {
      'acc_id': sherdpref!.getString('userId').toString(),
      'weight': weight.text,
      'height': height.text,
      'age': age.text,
      'hall': center.text,
      'area': address.text,
      'sleephours': sleepHours.text,
      'workhours': workHours.text,
      'workstrees': worktext,
      'gamehistory': historyWithgame.text,
      'target': exercisetext,
      'usehormon': hormontext,
      'cannon': infection.text,
      'unlikedfood': excludedFoods.text
    });
    print(jsonEncode(oldImages));
    print(images);
    if (images.isNotEmpty) {
      postRequestWithListFile(
          ApiLinks.bodyimgsUpdate,
          {
            'old': jsonEncode(oldImages),
            'acc_id': sherdpref!.getString('userId').toString()
          },
          images);
    }

    var response = await jsonDecode(request.body);
    if (response['status'] == 'Informations updated successfully') {
      getxDialog('تعديل البيانات', 'تم تعديل البيانات بنجاح');
      isUpdate = true;
    } else {
      getxDialog('تعديل البيانات', 'حدث خطأ في تحديث البيانات');
    }

    update();
  }

  ///
  ///-----------------Fetch Contact Information------------------///
  ///
  String phone = "";
  String imagepath = "";

  fetchContactInfo() async {
    var request = await http.post(Uri.parse(ApiLinks.contactfetch));
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      if (response['data'] != null) {
        phone = response['data'][0]['phone'];
        imagepath =
            "${ApiLinks.contactFolder}/${response['data'][0]['barcodeurl']}";
      } else {
        phone = "لا يوجد معلومات تواصل إلى الآن";
      }
      requeststatus = RequestStatus.success;
    } else {
      getxDialog(
          'معلومات التواصل', 'حدث خطأ أثناء جلب البيانات تأكد من الاتصال');
      requeststatus = RequestStatus.success;
    }
    update();
  }

  List<String> oldImages = [];
  fetchbodyimages() async {
    var request = await http.post(Uri.parse(ApiLinks.bodyimgsfetch),
        body: {'acc_id': sherdpref!.getString('userId')});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      for (var element in response['data']) {
        oldImages.add(element['imgUrl']);
      }
    }
    print(oldImages);
    update();
  }
}
