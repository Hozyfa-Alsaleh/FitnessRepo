import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/controllers/infocontroller.dart';
import 'package:captainshoaib/core/classes/requeststate.dart';
import 'package:captainshoaib/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InfoController());
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "معلومات الدفع",
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontFamily: 'Tajwal'),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(AppRoute.packages);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: GetBuilder<InfoController>(
          builder: (controller) {
            return SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                    // padding:
                    //     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    children: [
                      Container(
                          width: width,
                          height: height! / 2,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 11, 108, 187),
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: controller.imagepath != ""
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              controller.imagepath),
                                          fit: BoxFit.cover)),
                                )
                              : const Center(
                                  child: Text(
                                    "لا يوجد باركود",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Tajwal'),
                                  ),
                                )),
                      const SizedBox(
                        height: 40,
                      ),
                      controller.requeststatus == RequestStatus.loading
                          ? const SizedBox(
                              width: 50,
                              child: CircularProgressIndicator.adaptive())
                          : Text(
                              controller.phone,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 25),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoute.payscreen);
                        },
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: width! / 2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                  width: 4, color: AppColors.border)),
                          child: const Text(
                            "التالي",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Tajwal',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ]),
              ),
            );
          },
        ));
  }
}
