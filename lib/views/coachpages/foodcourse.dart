import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/foodcoursecontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/coachpages/foodcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFoodCourse extends StatelessWidget {
  const AddFoodCourse({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FoodCourseController());
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed(AppRoute.displayFood);
        return Future.value(false);
      },
      child: GetBuilder<FoodCourseController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackGroundColor,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 30),
              toolbarHeight: 100,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: const Text(
                "إضافة كورس الغذاء",
                style: TextStyle(
                    color: Colors.black, fontSize: 30, fontFamily: 'Tajwal'),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  controller.deleteCourse();
                },
                icon: const Icon(
                  Icons.delete_forever_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      if (controller.isUpdate == false) {
                        controller.addFoodCourse();
                      } else if (controller.isUpdate == true) {
                        controller.updateCourse();
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 30,
                    ))
              ],
            ),
            body: SizedBox(
              width: width,
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                //shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      FoodCard(
                        icon: Icons.food_bank_rounded,
                        text: controller.isUpdate == false
                            ? "أضف الوجبات هنا"
                            : "عدل الوجبات",
                        hint: "",
                        controller: controller.firstMeal,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
