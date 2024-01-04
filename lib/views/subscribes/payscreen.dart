import 'dart:io';

import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/infocontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/information/pickimagebutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InfoController());
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "إثبات الدفع",
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontFamily: 'Tajwal'),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(AppRoute.packages);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: GetBuilder<InfoController>(
          builder: (controller) {
            return SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: width,
                          height: height! / 2.5,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 11, 108, 187),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(8),
                          child: controller.payImage != null
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: FileImage(
                                              File(controller.payImage!.path)),
                                          fit: BoxFit.contain)),
                                )
                              : const Center(
                                  child: Text(
                                  "يرجى رفع صورة إشعار الدفع",
                                  style: TextStyle(fontSize: 25),
                                ))),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: controller.payImage == null
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceEvenly,
                        children: [
                          PickImageButton(
                              text: "إرفاق صورة",
                              onPressed: () {
                                controller.pickPayImage();
                              }),
                          controller.payImage != null
                              ? PickImageButton(
                                  onPressed: () {
                                    controller.sendAllInformations();
                                  },
                                  text: "إرسال البيانات")
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Visibility(
                          visible: controller.load == false ? false : true,
                          child: const CircularProgressIndicator())
                    ]),
              ),
            );
          },
        ));
  }
}
