import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/controllers/PlayerCoursesControllers/fetchplayerexe.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/views/Home/exercisespage.dart';
import 'package:fitnessapp/widgets/searchbarwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayExercise extends StatelessWidget {
  const DayExercise({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FetchPlayerExeCtrl());
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const Exercises());
        return false;
      },
      child: GetBuilder<FetchPlayerExeCtrl>(
        init: FetchPlayerExeCtrl(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackGroundColor,
            appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                toolbarHeight: 90,
                title: const Text(
                  "التمارين",
                  style: TextStyle(
                      fontFamily: "Tajwal",
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                  onPressed: () {
                    Get.offAll(() => const Exercises());
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                bottom: SearchBarWidget(
                  controller: controller.searchbar,
                  hint: "ابحث عن تمرين",
                  onPressed: controller.clearSearchBar,
                  onChanged: (value) {
                    controller.searchAboutExercise(value);
                  },
                )),
            body: FutureBuilder(
              future: controller.getExercises(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.allData.isNotEmpty) {
                  return ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    itemCount: controller.allData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.gotodetails(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(192, 1, 52, 110),
                                  width: 3.5),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: ListTile(
                            leading: const Icon(
                              Icons.info_outline,
                              color: Colors.black,
                              size: 35,
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            title: Text(
                              controller.allData[index].details,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
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
                    "لا يوجد تمارين إلى الآن",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Tajwal'),
                  ));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
