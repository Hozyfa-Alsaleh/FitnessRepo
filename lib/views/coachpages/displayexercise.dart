import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/controllers/CaptinControllers/adminexecontroller.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/views/coachpages/addnewexercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayExercise extends StatelessWidget {
  const DisplayExercise({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminExeController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black, size: 30),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          toolbarHeight: 100,
          title: const Text(
            "التمارين",
            style: TextStyle(
                fontFamily: 'Tajwal',
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const AddNewExercise());
              },
              icon: const Icon(
                Icons.add,
                size: 40,
                color: Colors.black,
              ),
            ),
          ]),
      body: GetBuilder<AdminExeController>(
        builder: (controller) {
          return SizedBox(
            width: width,
            height: height,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: controller.exercieses.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    controller.fetchCurrentExercise(
                        index, controller.exercieses[index].id);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(192, 1, 52, 110),
                            width: 3.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      leading: const Icon(
                        Icons.info_outline,
                        size: 30,
                        color: Colors.black,
                      ),
                      title: Text(
                        controller.exercieses[index].details,
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Tajwal',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
