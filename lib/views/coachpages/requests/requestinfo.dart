import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/controllers/CaptinControllers/requestscontrollers.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/widgets/PlayerProfile/rowofinfo.dart';
import 'package:captainshoaib/widgets/information/packagecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestInfo extends StatelessWidget {
  const RequestInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RequestsController());
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(AppRoute.playersRequests);
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text(
              "تفاصيل الطلب",
              style: TextStyle(
                  color: Colors.black, fontSize: 30, fontFamily: 'Tajwal'),
            ),
            centerTitle: true,
          ),
          body: GetBuilder<RequestsController>(builder: (controller) {
            return SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  FutureBuilder(
                    future: controller.fetchUserInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (controller.playerInfo.isNotEmpty) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                RowOfInfo(
                                    title: controller.titles[0],
                                    desc: controller
                                        .playerInfo[index].courseState),
                                RowOfInfo(
                                    title: controller.titles[1],
                                    desc: controller.playerInfo[index].area),
                                RowOfInfo(
                                    title: controller.titles[2],
                                    desc: controller.playerInfo[index].hall),
                                RowOfInfo(
                                    title: controller.titles[3],
                                    desc: controller.playerInfo[index].age),
                                RowOfInfo(
                                    title: controller.titles[4],
                                    desc: controller.playerInfo[index].height),
                                RowOfInfo(
                                    title: controller.titles[5],
                                    desc: controller.playerInfo[index].weight),
                                RowOfInfo(
                                    title: controller.titles[6],
                                    desc: controller
                                        .playerInfo[index].sleephours),
                                RowOfInfo(
                                    title: controller.titles[7],
                                    desc:
                                        controller.playerInfo[index].workhours),
                                RowOfInfo(
                                    title: controller.titles[8],
                                    desc: controller
                                        .playerInfo[index].workstress),
                                RowOfInfo(
                                    title: controller.titles[9],
                                    desc: controller
                                        .playerInfo[index].gamehistory),
                                RowOfInfo(
                                    title: controller.titles[10],
                                    desc:
                                        controller.playerInfo[index].usehormon),
                                RowOfInfo(
                                    title: controller.titles[11],
                                    desc: controller.playerInfo[index].cannon),
                                RowOfInfo(
                                    title: controller.titles[12],
                                    desc: controller
                                        .playerInfo[index].unlikedfood),
                              ],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("لا يوجد معلومات"),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: controller.getSubscribeOfUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (controller.package != null) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: PackageCard(
                                  name: controller.package!.name,
                                  time: controller.package!.time,
                                  price: "${controller.package!.price}\$",
                                  details: controller.package!.details),
                            ),
                            Container(
                              width: width,
                              height: height! / 2.5,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 5,
                                        spreadRadius: 0,
                                        offset: Offset(0.8, 4))
                                  ],
                                  color:
                                      const Color.fromARGB(255, 11, 108, 187),
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(controller.imagePath)),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text("لا يوجد باقة أو صورة إشعار"),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      children: [
                        Expanded(
                            child: StatusButtons(
                          text: "قبول",
                          onTap: () {
                            ///Here will accept the player and change the status to 1
                            controller.acceptplayer();
                          },
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: StatusButtons(
                          text: "رفض",
                          onTap: () {
                            ///Here will ignore him and drop from DB
                            Get.defaultDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 12, 55, 90),
                              title: "رفض طلب اللاعب",
                              titleStyle: const TextStyle(
                                  color: Colors.white, fontFamily: 'Tajwal'),
                              content: SizedBox(
                                width: width,
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Tajwal'),
                                  controller: controller.reason,
                                  decoration: InputDecoration(
                                      hintText: "اكتب سبب الرفض",
                                      hintStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Tajwal'),
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.black, width: 1))),
                                ),
                              ),
                              cancel: Container(
                                margin: const EdgeInsets.only(left: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.green,
                                ),
                                child: IconButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    controller.reason.clear();

                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              confirm: Container(
                                margin: const EdgeInsets.only(right: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.red,
                                ),
                                child: IconButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    controller.deletePlayer();
                                    controller.reason.clear();
                                    Get.back();
                                    Get.offAllNamed(AppRoute.captineHomePage);
                                  },
                                  icon: const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ))
                      ],
                    ),
                  )
                ]),
              ),
            );
          })),
    );
  }
}

class StatusButtons extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const StatusButtons({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 99, 170, 228),
            border: Border.all(color: AppColors.border, width: 3.5),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Tajwal',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
