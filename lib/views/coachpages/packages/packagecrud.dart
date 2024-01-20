import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/appbar.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/packagecontroller.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/coachpages/addpackagecard/addpackagecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageCRUD extends StatelessWidget {
  const PackageCRUD({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PackagesController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.CaptinePackages);
        return false;
      },
      child: GetBuilder<PackagesController>(
        builder: (controller) {
          return Scaffold(
              backgroundColor: AppColors.scaffoldBackGroundColor,
              appBar: SharedAppBar(
                title: "إضافة باقة",
                addSend: Icons.send,
                addOrSend: () {
                  if (controller.formkey.currentState!.validate()) {
                    if (controller.isUpdate == false) {
                      controller.insertPackage();
                    } else if (controller.isUpdate == true) {
                      controller.updatePackage();
                    }
                  }
                },
                delete: () {
                  if (controller.name.text.isEmpty &&
                      controller.time.text.isEmpty &&
                      controller.price.text.isEmpty &&
                      controller.notes.text.isEmpty) {
                    getxDialog('حذف باقة',
                        'لم تقم باختيار باقة من قائمة الباقات لحذقها');
                  } else {
                    controller.deletePackage();
                  }
                },
                goback: Icons.arrow_forward_ios,
                backFun: () {
                  Get.offAllNamed(AppRoute.CaptinePackages);
                },
              ),
              body: SizedBox(
                width: width,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AddPackageCard(
                      formkey: controller.formkey,
                      name: controller.name,
                      time: controller.time,
                      price: controller.price,
                      details: controller.notes),
                ),
              ));
        },
      ),
    );
  }
}
