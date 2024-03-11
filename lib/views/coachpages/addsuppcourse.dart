import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/controllers/CaptinControllers/addsuppcontroller.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/widgets/coachpages/foodcard.dart';
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
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.suppcourse);
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 25,
                      ))
                ],
                elevation: 0.0,
                backgroundColor: Colors.transparent,
              ),
              body: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      vertical: height! / 4, horizontal: 10),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              if (controller.isUpdate == false) {
                                controller.insertNewSuppCourse();
                              } else if (controller.isUpdate == true) {
                                controller.updateSuppCourse();
                              }
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
                              child: Text(
                                controller.isUpdate == false
                                    ? "إضافة"
                                    : "تعديل",
                                style: const TextStyle(
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
                              controller.deleteSuppCourse();
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
                      icon: Icons.medical_information,
                      text: controller.isUpdate == false
                          ? "أضف الكورس"
                          : "عدل الكورس",
                      hint: "",
                      controller: controller.supptext,
                    ),
                  ])),
        );
      },
    );
  }
}