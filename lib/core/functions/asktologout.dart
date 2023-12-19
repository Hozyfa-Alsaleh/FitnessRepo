import 'dart:io';

import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

askToLogOut(String title, String content) {
  return Get.defaultDialog(
    contentPadding: EdgeInsets.all(10),
    backgroundColor: AppColors.detailsButtons,
    title: title,
    content: Text(
      content,
      style: const TextStyle(color: Colors.white, fontSize: 28),
    ),
    onConfirm: () {
      exit(1);
    },
    onCancel: () {
      Get.back();
    },
  );
}
