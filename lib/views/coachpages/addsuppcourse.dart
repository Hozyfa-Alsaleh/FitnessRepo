import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/addsuppcontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/coachpages/foodcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSuppCourse extends StatelessWidget {
  const AppSuppCourse({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddSuppController());
    return GetBuilder<AddSuppController>(
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            Get.offAllNamed(AppRoute.suppcourse);
            return false;
          },
          child: Scaffold(
              backgroundColor: AppColors.scaffoldBackGroundColor,
              appBar: AppBar(
                title: const Text(
                  "إضافة كورس مكملات",
                  style: TextStyle(
                      fontFamily: 'Tajwal',
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    controller.deleteSuppCourse();
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (controller.isUpdate == false) {
                          controller.insertNewSuppCourse();
                        } else if (controller.isUpdate == true) {
                          controller.updateSuppCourse();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.black,
                      ))
                ],
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(vertical: height! / 4, horizontal: 10),
                child: FoodCard(
                  icon: Icons.medical_information,
                  text: controller.isUpdate == false
                      ? "أضف الكورس"
                      : "عدل الكورس",
                  hint: "",
                  controller: controller.supptext,
                ),
              )),
        );
      },
    );
  }
}
