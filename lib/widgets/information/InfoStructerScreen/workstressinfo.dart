import 'package:fitnessapp/controllers/infocontroller.dart';
import 'package:fitnessapp/widgets/information/workbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkStressInfo extends StatelessWidget {
  final Color? color;
  const WorkStressInfo({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    InfoController controller = Get.find();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color.fromARGB(192, 1, 52, 110),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.black)),
          child: const Text(
            "جهد العمل",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontFamily: 'Tajwal'),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: WorkButton(
                onTap: () {
                  controller.worktext = "قليل";
                  controller.selectedWorkButton();
                },
                text: "قليل",
                color: controller.worktext == "قليل" ? color : null,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: WorkButton(
                onTap: () {
                  controller.worktext = "متوسط";
                  controller.selectedWorkButton();
                },
                text: "متوسط",
                color: controller.worktext == "متوسط" ? color : null,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: WorkButton(
                onTap: () {
                  controller.worktext = "عالي";
                  controller.selectedWorkButton();
                },
                text: "عالي",
                color: controller.worktext == "عالي" ? color : null,
              ),
            )
          ],
        )
      ],
    );
  }
}
