// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:captainshoaib/Utils/apilinks.dart';
import 'package:captainshoaib/main.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ExercisesController extends GetxController {
  int currentIndex = 0;
  Color? courseColor;
  Color? foodColor;
  Color? hormonColor;
  late PageController pagectrl;
  switchPage(int index) {
    currentIndex = index;
    pagectrl.animateToPage(currentIndex,
        duration: const Duration(microseconds: 800), curve: Curves.easeInOut);
    currentIndex == 0
        ? courseColor = const Color.fromARGB(235, 1, 51, 110)
        : courseColor = const Color.fromARGB(127, 1, 51, 110);
    currentIndex == 1
        ? foodColor = const Color.fromARGB(235, 1, 51, 110)
        : foodColor = const Color.fromARGB(127, 1, 51, 110);

    currentIndex == 2
        ? hormonColor = const Color.fromARGB(235, 1, 51, 110)
        : hormonColor = const Color.fromARGB(127, 1, 51, 110);

    update();
  }

  String meal = "";
  Future fetchFoodCourse() async {
    //try {
    var request = await http.post(Uri.parse(ApiLinks.foodFetch),
        body: {'acc_id': sherdpref!.getString('userId')});
    var response = await jsonDecode(request.body);

    print(response);
    if (response['status'] == 1) {
      meal = response['data']['meal'].toString();
      update();
      print('success');
    }
    //} catch (e) {}
  }

  String hormon = "";
  fetchHormonCourse() async {
    var request = await http.post(Uri.parse(ApiLinks.suppfetch),
        body: {'acc_id': sherdpref!.getString('userId')});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      if (response['data'] != null) {
        hormon = response['data']['supp'].toString();
        print('success');
      }
    }
  }

  @override
  void onInit() {
    pagectrl = PageController();
    courseColor = const Color.fromARGB(191, 1, 51, 110);
    fetchFoodCourse();
    super.onInit();
  }
}
