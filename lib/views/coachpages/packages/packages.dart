import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/appbar.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/packagecontroller.dart';
import 'package:fitnessapp/widgets/information/packagecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Packages extends StatelessWidget {
  const Packages({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PackagesController());
    return WillPopScope(onWillPop: () async {
      Get.offAllNamed(AppRoute.captineHomePage);
      return false;
    }, child: GetBuilder<PackagesController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackGroundColor,
          appBar: SharedAppBar(
            title: "الباقات",
            addSend: Icons.add,
            addOrSend: () {
              print(controller.isUpdate.toString());
              Get.toNamed(AppRoute.packageCRUD);
            },
          ),
          body: FutureBuilder(
            future: controller.fetchPackages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.packages.isNotEmpty) {
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: controller.packages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.moveToPackageCRUD(index);
                      },
                      child: Column(
                        children: [
                          PackageCard(
                              name: controller.packages[index].name,
                              time: controller.packages[index].time,
                              price: controller.packages[index].price,
                              details: controller.packages[index].details),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "لا يوجد باقات إلى الآن",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                );
              }
            },
          ),
        );
      },
    ));
  }
}
