import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/playerscontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/coachpages/playercard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPlayers extends StatelessWidget {
  const MyPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlayersController());
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed(AppRoute.captineHomePage);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "المتدربيـــن",
              style: TextStyle(
                fontFamily: "Tajwal",
                color: Colors.black,
                fontSize: 45,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: AppColors.scaffoldBackGroundColor,
          body: GetBuilder<PlayersController>(
            builder: (controller) {
              return SizedBox(
                  width: width,
                  height: height,
                  child: FutureBuilder(
                    future: controller.getAllPlayers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: controller.player.length,
                          itemBuilder: (context, index) {
                            return PlayerCard(
                              imgurl: controller.player[index].imgurl!,
                              text: controller.player[index].name!,
                              onTap: () {
                                controller.selectedUser(
                                  controller.player[index].id!,
                                  controller.player[index].name!,
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "لا يوجد لاعبين",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Tajwal'),
                          ),
                        );
                      }
                    },
                  ));
            },
          )),
    );
  }
}
