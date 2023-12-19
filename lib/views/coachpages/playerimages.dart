import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/views/Home/imageviewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerImages extends StatelessWidget {
  const PlayerImages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldBackGroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(ImageView(
                  path: "",
                ));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                width: MediaQuery.sizeOf(context).width,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/weightlifting.jpeg"),
                        fit: BoxFit.cover)),
              ),
            );
          },
        ));
  }
}
