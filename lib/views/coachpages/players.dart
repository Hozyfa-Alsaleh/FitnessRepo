import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/playerscontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/coachpages/playercard.dart';
import 'package:fitnessapp/widgets/searchbarwidget.dart';
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
      child: GetBuilder<PlayersController>(
        builder: (controller) {
          return Scaffold(
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
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.offAllNamed(AppRoute.captineHomePage);
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 30,
                      ))
                ],
                bottom: SearchBarWidget(
                  controller: controller.searchbar,
                  hint: "ابحث عن لاعب",
                  onPressed: controller.clearSearchBar,
                  onChanged: (p0) {
                    controller.searchAboutPlayer(p0);
                  },
                ),
              ),
              backgroundColor: AppColors.scaffoldBackGroundColor,
              body: SizedBox(
                  width: width,
                  height: height,
                  child: FutureBuilder(
                    future: controller.getAllPlayers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (controller.allPlayers.isNotEmpty) {
                        return ListView.builder(
                          itemCount: controller.allPlayers.length,
                          itemBuilder: (context, index) {
                            return PlayerCard(
                              imgurl: controller.allPlayers[index].imgurl!,
                              text: controller.allPlayers[index].name!,
                              onTap: () {
                                controller.selectedUser(
                                  controller.allPlayers[index].id!,
                                  controller.allPlayers[index].name!,
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
                  )));
        },
      ),
    );
  }
}
