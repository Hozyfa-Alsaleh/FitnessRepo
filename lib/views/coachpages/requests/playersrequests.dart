import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/requestscontrollers.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/coachpages/playercard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayersRequests extends StatelessWidget {
  const PlayersRequests({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RequestsController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.captineHomePage);
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "الطلبات",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tajwal',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
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
                    size: 27,
                  ))
            ],
          ),
          body: GetBuilder<RequestsController>(
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
                      } else if (controller.players.isNotEmpty) {
                        return ListView.builder(
                          itemCount: controller.players.length,
                          itemBuilder: (context, index) {
                            return PlayerCard(
                              imgurl: controller.players[index].imgurl!,
                              text: controller.players[index].name!,
                              onTap: () {
                                controller.gotoRequestinfo(index);
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
                                fontSize: 27,
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
