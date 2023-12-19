import 'package:fitnessapp/core/functions/validator.dart';
import 'package:fitnessapp/widgets/information/infotextfield.dart';
import 'package:flutter/material.dart';

class PhysicsInfo extends StatelessWidget {
  final TextEditingController playerNameCtrl;
  final TextEditingController weightCtrl;
  final TextEditingController heightCtrl;
  final TextEditingController ageCtrl;
  final TextEditingController centerCtrl;
  final TextEditingController addressCtrl;
  final TextEditingController sleepHoursCtrl;
  final TextEditingController workHoursCtrl;
  final TextEditingController historyWithgameCtrl;

  const PhysicsInfo({
    super.key,
    required this.playerNameCtrl,
    required this.weightCtrl,
    required this.heightCtrl,
    required this.ageCtrl,
    required this.centerCtrl,
    required this.addressCtrl,
    required this.sleepHoursCtrl,
    required this.workHoursCtrl,
    required this.historyWithgameCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoTextField(
          lable: "الاسم",
          icon: Icons.person,
          controller: playerNameCtrl,
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: InfoTextField(
              icon: Icons.monitor_weight,
              fontsize: 17,
              lable: "الوزن",
              controller: weightCtrl,
              validator: (val) =>
                  validateInput(val!, 2, 3, TextInputType.number),
            )),
            Expanded(
                child: InfoTextField(
              lable: "الطول",
              icon: Icons.accessibility,
              controller: heightCtrl,
              validator: (val) =>
                  validateInput(val!, 3, 3, TextInputType.number),
            )),
            Expanded(
                child: InfoTextField(
              lable: "العمر",
              icon: Icons.numbers,
              controller: ageCtrl,
              validator: (val) =>
                  validateInput(val!, 2, 2, TextInputType.number),
            )),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: InfoTextField(
              lable: "القاعة",
              icon: Icons.home_filled,
              controller: centerCtrl,
              validator: (val) =>
                  validateInput(val!, 4, 20, TextInputType.text),
            )),
            Expanded(
              child: InfoTextField(
                lable: "المنطقة",
                icon: Icons.location_city_rounded,
                controller: addressCtrl,
                validator: (val) =>
                    validateInput(val!, 4, 20, TextInputType.text),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: InfoTextField(
              lable: "ساعات النوم",
              icon: Icons.home_filled,
              controller: sleepHoursCtrl,
              validator: (val) =>
                  validateInput(val!, 2, 10, TextInputType.text),
            )),
            Expanded(
              child: InfoTextField(
                lable: "ساعات العمل",
                icon: Icons.location_city_rounded,
                controller: workHoursCtrl,
                validator: (val) =>
                    validateInput(val!, 2, 10, TextInputType.text),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        InfoTextField(
          icon: Icons.timelapse,
          lable: "منذ متى تمارس اللعبة",
          controller: historyWithgameCtrl,
          validator: (val) => validateInput(val!, 3, 20, TextInputType.number),
        ),
      ],
    );
  }
}
