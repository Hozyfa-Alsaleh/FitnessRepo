import 'dart:convert';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FoodCourseController extends GetxController {
  bool isUpdate = false;
  late TextEditingController firstMeal;
  late TextEditingController secondMeal;
  late TextEditingController thirdMeal;
  late TextEditingController fourthMeal;

  Future<void> addFoodCourse() async {
    var request = await http.post(Uri.parse(ApiLinks.foodInsert), body: {
      'acc_id': selectedUserId.toString(),
      'meal': firstMeal.text,
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      print("added sucess");
      getxDialog("كورس الغذاء", response['Message'].toString());
      fetchTheCourse();
      isUpdate = true;
    } else if (response['status'] == 0) {
      getxDialog("كورس الغذاء", response['Message'].toString());

      print("added faild");
    }
    update();
  }

  Future<void> deleteCourse() async {
    var request = await http.post(Uri.parse(ApiLinks.foodDelete),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      firstMeal.clear();
      isUpdate = false;
      print(isUpdate);
    } else {
      getxDialog("كورس الغذاء", "حدث خطأ ما");
    }
    update();
  }

  Future fetchTheCourse() async {
    var request = await http.post(Uri.parse(ApiLinks.foodFetch),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      isUpdate = true;
      firstMeal.text = response['data']['meal'];
      print(updateCourse);
      print("full");
    } else if (response['status'] == 0) {
      isUpdate = false;
      print("empty");
    }
    update();
    return response;
  }

  Future<void> updateCourse() async {
    try {
      var request = await http.post(Uri.parse(ApiLinks.foodUpdate), body: {
        'acc_id': selectedUserId.toString(),
        'meal': firstMeal.text,
      });
      var response = await jsonDecode(request.body);
      if (response['status'] == 1) {
        getxDialog("كورس الغذاء", response['Message'].toString());
        fetchTheCourse();
      } else if (response['status'] == 0) {
        getxDialog("كورس الغذاء", response['Message'].toString());
      }
    } catch (e) {
      getxDialog('كورس الغذاء', 'حدث خطأ غير متوقع');
    }
  }

  @override
  void onInit() {
    firstMeal = TextEditingController();
    secondMeal = TextEditingController();
    thirdMeal = TextEditingController();
    fourthMeal = TextEditingController();
    fetchTheCourse();

    super.onInit();
  }
}
