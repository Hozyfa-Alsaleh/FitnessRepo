import 'package:fitnessapp/controllers/infocontroller.dart';
import 'package:fitnessapp/widgets/information/workbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TargetOfExercise extends StatelessWidget {
  final Color? color;
  const TargetOfExercise({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    InfoController controller = Get.find();
    return Column(
      children: [
        Container(
          height: 70,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: const Color.fromARGB(255, 16, 85, 141), width: 3),
          ),
          child: const Text(
            "الهدف من التمرين",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontFamily: 'Tajwal'),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          children: [
            Expanded(
              child: WorkButton(
                height: 50,
                text: "زيادة وزن وحجم",
                fontsize: 20,
                onTap: () {
                  controller.exercisetext = "زيادة وزن وحجم";
                  controller.selectedExerciseButton();
                },
                color:
                    controller.exercisetext == "زيادة وزن وحجم" ? color : null,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Expanded(
              child: WorkButton(
                height: 50,
                text: "خسارة وزن",
                fontsize: 20,
                onTap: () {
                  controller.exercisetext = "خسارة وزن";
                  controller.selectedExerciseButton();
                },
                color: controller.exercisetext == "خسارة وزن" ? color : null,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: WorkButton(
                height: 50,
                text: "حرق دهون وبناء عضل",
                fontsize: 17,
                onTap: () {
                  controller.exercisetext = "حرق دهون وبناء عضل";
                  controller.selectedExerciseButton();
                },
                color: controller.exercisetext == "حرق دهون وبناء عضل"
                    ? color
                    : null,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            Expanded(
              child: WorkButton(
                height: 50,
                text: "إعداد بطولة",
                fontsize: 20,
                onTap: () {
                  controller.exercisetext = "إعداد بطولة";
                  controller.selectedExerciseButton();
                },
                color: controller.exercisetext == "إعداد بطولة" ? color : null,
              ),
            )
          ],
        ),
      ],
    );
  }
}
