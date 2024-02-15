import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/CaptinControllers/contactinfocontroller.dart';
import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ContactInfoController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.captineHomePage);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColor,
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "معلومات الدفع",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Tajwal'),
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
        body: GetBuilder<ContactInfoController>(
          builder: (controller) {
            return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  children: [
                    Container(
                        width: width,
                        height: height! / 2,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(192, 1, 52, 110),
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(8),
                        child: controller.imagePath != null
                            ? Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(controller.imagePath!),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: controller.barcode != null
                                        ? DecorationImage(
                                            image:
                                                FileImage(controller.barcode!),
                                            fit: BoxFit.cover)
                                        : null),
                              )),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        controller.pickBarcodeImage();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withOpacity(0.6), width: 4),
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.border),
                        width: width! / 2,
                        height: 60,
                        child: Text(
                          controller.isUpdate == false
                              ? "إرفاق صورة باركود"
                              : "تعديل صورة الباركود",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Tajwal',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: controller.phone,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Tajwal'),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "أدخل رقم الهاتف",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Tajwal',
                              fontWeight: FontWeight.bold),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: AppColors.border, width: 3.5)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: AppColors.border, width: 3.5)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.requestState == RequestStatus.loading) {
                        } else {
                          if (controller.isUpdate == false) {
                            controller.insertContactInfo();
                          } else {
                            controller.updateContactInfo();
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white38, width: 4),
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(192, 1, 52, 110)),
                        width: width! / 2,
                        height: 60,
                        child: controller.requestState == RequestStatus.loading
                            ? const CircularProgressIndicator()
                            : Text(
                                controller.isUpdate == false
                                    ? "إرسال المعلومات"
                                    : "تعديل المعلومات",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Tajwal',
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
