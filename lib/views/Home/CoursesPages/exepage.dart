import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/controllers/PlayerCoursesControllers/fetchplayerexe.dart';
import 'package:captainshoaib/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerExercies extends StatelessWidget {
  const PlayerExercies({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FetchPlayerExeCtrl());
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColor,
        body: GetBuilder<FetchPlayerExeCtrl>(builder: (controller) {
          return SafeArea(
              child: SizedBox(
                  width: width,
                  height: height,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.gotoexercises(index + 1);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(192, 1, 52, 110),
                                    width: 3.2),
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white.withOpacity(0.8)),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: ListTile(
                              leading: const Icon(
                                Icons.info,
                                color: Colors.black,
                                size: 35,
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              title: Text(
                                controller.days[index],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      }))
              // : Center(
              //     child: CircularProgressIndicator(),
              //   )
              );
        }));
  }
}
