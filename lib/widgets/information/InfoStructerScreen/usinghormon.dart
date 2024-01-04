import 'package:fitnessapp/controllers/infocontroller.dart';
import 'package:fitnessapp/widgets/information/workbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsingHormon extends StatelessWidget {
  final Color? color;
  const UsingHormon({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    InfoController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 3, color: const Color.fromARGB(255, 16, 85, 141))),
          child: const Text(
            "استخدام الهرمون",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: WorkButton(
                text: "نعم",
                onTap: () {
                  controller.hormontext = "نعم";
                  controller.selectedHormonButton();
                },
                color: controller.hormontext == "نعم" ? color : null,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: WorkButton(
                text: "لا",
                onTap: () {
                  controller.hormontext = "لا";
                  controller.selectedHormonButton();
                },
                color: controller.hormontext == "لا" ? color : null,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: WorkButton(
                height: 57,
                fontsize: 18,
                text: "الخيار للمدرب",
                onTap: () {
                  controller.hormontext = "الخيار للمدرب";
                  controller.selectedHormonButton();
                },
                color: controller.hormontext == "الخيار للمدرب" ? color : null,
              ),
            )
          ],
        )
      ],
    );
  }
}
