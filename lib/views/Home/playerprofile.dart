import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/controllers/playerprofilecontroller.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/views/Home/imageviewer.dart';
import 'package:fitnessapp/views/Home/manageprofile.dart';
import 'package:fitnessapp/widgets/PlayerProfile/rowofinfo.dart';
import 'package:fitnessapp/widgets/PlayerProfile/switchpagebutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerProfile extends StatelessWidget {
  const PlayerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlayerProfileController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.HOME);
        return false;
      },
      child: Scaffold(
          backgroundColor: AppColors.scaffoldBackGroundColor,
          body: GetBuilder<PlayerProfileController>(
            builder: (controller) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            //flex: 7,
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  controller.imagename != ""
                                      ? SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  2.5,
                                          height: MediaQuery.sizeOf(context)
                                                  .height /
                                              4.5,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                controller.imagename),
                                          ))
                                      : SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width /
                                                  2.5,
                                          height: MediaQuery.sizeOf(context)
                                                  .height /
                                              4.5,
                                          child: const CircleAvatar(
                                            foregroundColor: Colors.blue,
                                            backgroundColor: Color.fromARGB(
                                                255, 134, 183, 223),
                                            child: Icon(
                                              Icons.person,
                                              size: 100,
                                              color: Colors.white,
                                            ),
                                          )),
                                  Positioned(
                                    bottom: 20,
                                    right: 10,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.pickeImage();
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey,
                                        size: 55,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    sherdpref!.getString('username').toString(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Get.offAllNamed(AppRoute.PlayerInfo);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 30,
                                        color: Colors.black,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        controller.logout();
                                      },
                                      icon: const Icon(
                                        Icons.logout,
                                        size: 30,
                                        color: Colors.black,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        Get.offAll(() => const ManageProfile());
                                        //controller.logout();
                                      },
                                      icon: const Icon(
                                        Icons.settings,
                                        size: 30,
                                        color: Colors.black,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              // const Text(
                              //   "تم ارسال المعلومات يرجي انتظار الكورس",
                              //   style:
                              //       TextStyle(color: Colors.white, fontSize: 18),
                              // ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SwitchButtonPage(
                                    onPressed: () {
                                      controller.switchthePage(0);
                                    },
                                    text: "التفاصيل",
                                    icon: Icons.list_rounded,
                                    color: controller.detailsColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SwitchButtonPage(
                                    onPressed: () {
                                      controller.switchthePage(1);
                                      controller.fetchBodyImages();
                                    },
                                    text: "الصور",
                                    icon: Icons.image,
                                    color: controller.imagesColor,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                            //flex: 7,
                            child: Container(
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: controller.pageController,
                              children: [
                                FutureBuilder(
                                  future: controller.getdata(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (controller
                                        .playerInfo.isNotEmpty) {
                                      return ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 1,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              RowOfInfo(
                                                  title: controller.titles[0],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .target),
                                              RowOfInfo(
                                                  title: controller.titles[1],
                                                  desc: controller
                                                      .playerInfo[index].area),
                                              RowOfInfo(
                                                  title: controller.titles[2],
                                                  desc: controller
                                                      .playerInfo[index].hall),
                                              RowOfInfo(
                                                  title: controller.titles[3],
                                                  desc: controller
                                                      .playerInfo[index].age),
                                              RowOfInfo(
                                                  title: controller.titles[4],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .height),
                                              RowOfInfo(
                                                  title: controller.titles[5],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .weight),
                                              RowOfInfo(
                                                  title: controller.titles[6],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .sleephours),
                                              RowOfInfo(
                                                  title: controller.titles[7],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .workhours),
                                              RowOfInfo(
                                                  title: controller.titles[8],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .workstress),
                                              RowOfInfo(
                                                  title: controller.titles[9],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .gamehistory),
                                              RowOfInfo(
                                                  title: controller.titles[10],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .usehormon),
                                              RowOfInfo(
                                                  title: controller.titles[11],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .cannon),
                                              RowOfInfo(
                                                  title: controller.titles[12],
                                                  desc: controller
                                                      .playerInfo[index]
                                                      .unlikedfood),
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
                                ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: controller.bodyPaths.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(ImageView(
                                          path: controller.bodyPaths[index],
                                        ));
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        width: MediaQuery.sizeOf(context).width,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(controller
                                                    .bodyPaths[index]
                                                    .toString()),
                                                fit: BoxFit.cover)),
                                      ),
                                    );
                                  },
                                )
                              ]),
                        )),
                      ]),
                ),
              );
            },
          )),
    );
  }
}
