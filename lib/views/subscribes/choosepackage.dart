import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/infocontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/information/packagecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosePackage extends StatelessWidget {
  const ChoosePackage({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrl = Get.put(InfoController());
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(AppRoute.PlayerInfo);
        return false;
      },
      child: Scaffold(
          backgroundColor: AppColors.scaffoldBackGroundColor,
          appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      ctrl.refreshpackagepage();
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ))
              ],
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              title: const Text(
                "الباقات",
                style: TextStyle(
                    fontSize: 30, color: Colors.black, fontFamily: 'Tajwal'),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.PlayerInfo);
                  },
                  icon: const Icon(Icons.arrow_back))),
          body: GetBuilder<InfoController>(
            builder: (controller) {
              return SizedBox(
                width: width,
                height: height,
                child: FutureBuilder(
                  future: controller.getAllPackages(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.packageId =
                                  controller.packages[index].id!;
                              controller.goToPayScreen();
                            },
                            child: PackageCard(
                                name: controller.packages[index].name,
                                time: controller.packages[index].time,
                                price: controller.packages[index].price,
                                details: controller.packages[index].details),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("لا يوجد بيانات إلى الآن"),
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
