import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/exercisecontroller.dart';
import 'package:fitnessapp/views/Home/CoursesPages/exepage.dart';
import 'package:fitnessapp/widgets/ExercisesWidgets/customebutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Exercises extends StatelessWidget {
  const Exercises({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExercisesController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.HOME);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColor,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text(
              "كابتن شعيب",
            ),
            centerTitle: true,
            titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "Cairo-Regular"),
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onPressed: () {
                    Get.offAllNamed(AppRoute.HOME);
                  }),
            ]),
        body: GetBuilder<ExercisesController>(
          builder: (controller) {
            return SafeArea(
                child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            text: "الكورس",
                            onPreesed: () {
                              controller.switchPage(0);
                            },
                            color: controller.courseColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomButton(
                            text: "الغذاء",
                            onPreesed: () {
                              controller.switchPage(1);
                            },
                            color: controller.foodColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CustomButton(
                            text: "المكملات",
                            onPreesed: () {
                              controller.switchPage(2);
                            },
                            color: controller.hormonColor,
                          )
                        ]),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  indent: 10,
                  endIndent: 10,
                ),
                Expanded(
                    flex: 7,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pagectrl,
                      children: [
                        ///
                        ///This is the exercises Class
                        ///
                        ///
                        // ignore: avoid_unnecessary_containers
                        const PlayerExercies(),

                        ///
                        ///
                        ///
                        // ignore: avoid_unnecessary_containers
                        Container(
                            child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            if (controller.meal != "") {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.meal,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 30),
                                ),
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  "لا يوجد كورس تغذية",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Tajwal',
                                      fontSize: 25),
                                ),
                              );
                            }
                          },
                        )),
                        // ignore: avoid_unnecessary_containers
                        Container(
                            child: FutureBuilder(
                          future: controller.fetchHormonCourse(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (controller.hormon != "") {
                              return SingleChildScrollView(
                                child: Text(
                                  controller.hormon,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Tajwal',
                                      fontSize: 28),
                                ),
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  "لا يوجد كورس مكملات",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 28,
                                      fontFamily: 'Tajwal'),
                                ),
                              );
                            }
                          },
                        ))
                      ],
                    ))
              ],
            ));
          },
        ),
      ),
    );
  }
}
