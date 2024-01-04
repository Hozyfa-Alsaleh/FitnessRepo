import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getxDialog(String title, String content) {
  return Get.defaultDialog(
      radius: 20,
      title: title,
      titleStyle: const TextStyle(color: Colors.white),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontFamily: "Cairo-Regular", fontSize: 19),
      ),
      actions: [
        ElevatedButton(
            style: const ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder(
                  eccentricity: 0.5,
                )),
                backgroundColor:
                    MaterialStatePropertyAll(AppColors.buttonsColor)),
            onPressed: () {
              Get.back();
            },
            child: const Icon(Icons.cancel))
      ],
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      buttonColor: AppColors.buttonsColor);
}
