import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/controllers/CaptinControllers/playerscontroller.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/widgets/PlayerProfile/rowofinfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerDetailes extends StatelessWidget {
  const PlayerDetailes({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlayersController());
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed(AppRoute.coachprofile_C);
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black, size: 30),
            centerTitle: true,
            title: const Text(
              "تفاصيل اللاعب",
              style: TextStyle(
                  color: Colors.black, fontSize: 30, fontFamily: 'Tajwal'),
            ),
          ),
          body: GetBuilder<PlayersController>(
            builder: (controller) {
              return SizedBox(
                width: width,
                height: height,
                child: FutureBuilder(
                  future: controller.getplayerdetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: controller.playerdet.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const RowOfInfo(
                                  title: "حالة الكورس:", desc: "قيد الانتظار"),
                              RowOfInfo(
                                  title: "الهدف من التمرين:",
                                  desc: controller.playerdet[index].target),
                              RowOfInfo(
                                  title: "المنطقة:",
                                  desc: controller.playerdet[index].area),
                              RowOfInfo(
                                  title: "القاعة:",
                                  desc: controller.playerdet[index].hall),
                              RowOfInfo(
                                  title: "العمر:",
                                  desc: controller.playerdet[index].age),
                              RowOfInfo(
                                  title: "الطول:",
                                  desc: controller.playerdet[index].height),
                              RowOfInfo(
                                  title: "الوزن:",
                                  desc: controller.playerdet[index].weight),
                              RowOfInfo(
                                  title: "ساعات النوم:",
                                  desc: controller.playerdet[index].sleephours),
                              RowOfInfo(
                                  title: "ساعات العمل:",
                                  desc: controller.playerdet[index].workhours),
                              RowOfInfo(
                                  title: "ضغط العمل:",
                                  desc: controller.playerdet[index].workstress),
                              RowOfInfo(
                                  title: "منذ متى تمارس اللعبة:",
                                  desc: controller.playerdet[index].workstress),
                              RowOfInfo(
                                  title: "استخدام الهرمونات:",
                                  desc: controller.playerdet[index].usehormon),
                              RowOfInfo(
                                  title: "الإصابات:",
                                  desc: controller.playerdet[index].cannon),
                              RowOfInfo(
                                  title: "أطعمة لاترغب بتناولها: ",
                                  desc:
                                      controller.playerdet[index].unlikedfood),
                            ],
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "لا يوجد بيانات",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          )),
    );
  }
}
