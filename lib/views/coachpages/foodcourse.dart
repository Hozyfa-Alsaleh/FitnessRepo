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
              actions: [
                IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.displayFood);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 26,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                if (controller.isUpdate == false) {
                                  controller.addFoodCourse();
                                } else if (controller.isUpdate == true) {
                                  controller.updateCourse();
                                }
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.only(bottom: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 3,
                                        color: const Color.fromARGB(
                                            192, 1, 52, 110))),
                                child: const Text(
                                  "إضافة",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Tajwal",
                                      fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.deleteCourse();
                              },
                              child: Container(
                                height: 50,
                                margin: const EdgeInsets.only(bottom: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 3,
                                        color: const Color.fromARGB(
                                            192, 1, 52, 110))),
                                child: const Text(
                                  "حذف",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Tajwal",
                                      fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
