import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/controllers/CaptinControllers/adminexecontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/views/coachpages/addnewexercise.dart';
import 'package:fitnessapp/views/coachpages/exercises.dart';
import 'package:fitnessapp/widgets/searchbarwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DisplayExercise extends StatelessWidget {
  const DisplayExercise({super.key});

  @override
  Widget build(BuildContext context) {
    AdminExeController control = Get.put(AdminExeController());
    return WillPopScope(
      onWillPop: () async {
        control.dayId = 0;
        sherdpref!.remove('dayId');
        Get.to(const AdminExercises());

        return false;
      },
      child: GetBuilder<AdminExeController>(
        builder: (controller) {
          return Scaffold(
              backgroundColor: AppColors.scaffoldBackGroundColor,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.black, size: 30),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                toolbarHeight: 100,
                title: const Text(
                  "التمارين",
                  style: TextStyle(
                      fontFamily: 'Tajwal',
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.to(() => const AddNewExercise());
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ],
                bottom: SearchBarWidget(
                  controller: controller.searchbar,
                  hint: "ابحث عن تمرين",
                  onPressed: controller.clearSearchBar,
                  onChanged: (p0) {
                    controller.searchAboutExercise(p0);
                  },
                ),
              ),
              body: SizedBox(
                  width: width,
                  height: height,
                  child: FutureBuilder(
                      future: controller
                          .fetchExerciseForDay(sherdpref!.getInt('dayId')!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (controller.allExercises.isNotEmpty) {
                          return ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 20.h),
                            itemCount: controller.allExercises.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  controller.fetchCurrentExercise(
                                      index, controller.allExercises[index].id);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  alignment: Alignment.center,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              192, 1, 52, 110),
                                          width: 3.5),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.info_outline,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      controller.allExercises[index].details,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Tajwal',
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "لا يوجد تمارين لهذا اليوم",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Tajwal'),
                            ),
                          );
                        }
                      })));
        },
      ),
    );
  }
}
