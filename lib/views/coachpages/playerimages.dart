import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/controllers/CaptinControllers/playerscontroller.dart';
import 'package:captainshoaib/views/Home/imageviewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerImages extends StatelessWidget {
  const PlayerImages({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayersController>(builder: (controller) {
      return Scaffold(
          backgroundColor: AppColors.scaffoldBackGroundColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: FutureBuilder(
            future: controller.fetchBodyImages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.bodyPaths.isNotEmpty) {
                return ListView.builder(
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
                        margin: const EdgeInsets.only(bottom: 20),
                        width: MediaQuery.sizeOf(context).width,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    controller.bodyPaths[index].toString()),
                                fit: BoxFit.cover)),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "لا يوجد صور لهذا اللاعب",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Tajwal',
                        color: Colors.black),
                  ),
                );
              }
            },
          ));
    });
  }
}
