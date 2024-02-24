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
          appBar: AppBar(
            toolbarHeight: 50,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.HOME);
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
          backgroundColor: AppColors.scaffoldBackGroundColor,
          body: GetBuilder<PlayerProfileController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(0),
                child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
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
                                                2.0,
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                4.0,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            controller.imagename,
                                          ),
                                        ))
                                    : SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                3,
                                        height:
                                            MediaQuery.sizeOf(context).height /
                                                5,
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
                              ],
                            ),
                            Container(
                              width: width,
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: () {
                                  controller.pickeImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 55,
                                ),
                              ),
                            ),
                            Text(
                              sherdpref!.getString('username').toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 30),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                      //Get.offAllNamed(AppRoute.packages);
                                      Get.offAllNamed(AppRoute.PlayerInfo);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 30,
                                      color: Colors.black,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Get.offAll(() => const ManageProfile(
                                            route: AppRoute.PlayerProfile,
                                            type: "user",
                                          ));
                                      //controller.logout();
                                    },
                                    icon: const Icon(
                                      Icons.settings,
                                      size: 30,
                                      color: Colors.black,
                                    )),
                                // IconButton(
                                //     onPressed: () {
                                //       Get.offAll(() => const MyNotifyPage(
                                //             route: AppRoute.PlayerProfile,
                                //           ));
                                //     },
                                //     icon: const Icon(
                                //       Icons.notifications,
                                //       size: 30,
                                //       color: Colors.black,
                                //     )),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
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
                      ),
                      SizedBox(
                        width: width,
                        height: height! * 2.5,
                        child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            // clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                  } else if (controller.playerInfo.isNotEmpty) {
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      //shrinkWrap: true,
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return ListView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: [
                                            RowOfInfo(
                                                title: controller.titles[0],
                                                desc: controller
                                                    .playerInfo[index].target),
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
                                                    .playerInfo[index].height),
                                            RowOfInfo(
                                                title: controller.titles[5],
                                                desc: controller
                                                    .playerInfo[index].weight),
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
                                                    .playerInfo[index].cannon),
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
                                    return const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("لا يوجد معلومات"),
                                    );
                                  }
                                },
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.defaultDialog(
                                          backgroundColor: const Color.fromARGB(
                                              255, 14, 82, 138),
                                          title: "حذف الصور",
                                          titleStyle: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Tajwal',
                                              fontSize: 20),
                                          middleText:
                                              "هل أنت متأكد أنك تريد حذف الصور؟",
                                          middleTextStyle: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Tajwal',
                                              fontSize: 24),
                                          cancel: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: const Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.green,
                                                  size: 30,
                                                )),
                                          ),
                                          confirm: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 40),
                                            child: IconButton(
                                                onPressed: () {
                                                  controller.deleteBodyImages();
                                                  Get.back();
                                                },
                                                icon: const Icon(
                                                  Icons.done_outline_rounded,
                                                  color: Colors.red,
                                                  size: 30,
                                                )),
                                          ));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      width: width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              width: 3,
                                              color: AppColors.buttonsColor)),
                                      child: const Text(
                                        "حذف الصور",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Tajwal',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25),
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: controller.fetchBodyImages(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (controller
                                          .bodyPaths.isNotEmpty) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.all(8),
                                          itemCount:
                                              controller.bodyPaths.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Get.to(ImageView(
                                                  path: controller
                                                      .bodyPaths[index],
                                                ));
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 20),
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            controller
                                                                .bodyPaths[
                                                                    index]
                                                                .toString()),
                                                        fit: BoxFit.cover)),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return const Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Text(
                                            "لا يوجد صور لهذا اللاعب",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily: 'Tajwal'),
                                          ),
                                        );
                                      }
                                    },
                                  )
                                ],
                              )
                            ]),
                      ),
                    ]),
              );
            },
          )),
    );
  }
}
