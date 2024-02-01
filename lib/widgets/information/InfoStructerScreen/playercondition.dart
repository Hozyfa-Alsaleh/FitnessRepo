import 'package:captainshoaib/widgets/information/infotextfield.dart';
import 'package:flutter/material.dart';

class PlayerConditionNotes extends StatelessWidget {
  final TextEditingController infectionCtrl;
  final TextEditingController excludedFoodsCtrl;
  const PlayerConditionNotes(
      {super.key,
      required this.infectionCtrl,
      required this.excludedFoodsCtrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: const Text(
            "إصابات لديك أو تمارين لا يمكنك ممارستها:",
            style: TextStyle(
                color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InfoTextField(
          controller: infectionCtrl,
          icon: Icons.notes,
          lable: "",
          keyboardType: TextInputType.multiline,
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerRight,
          child: const Text(
            "أطعمة لا ترغب بتناولها:",
            style: TextStyle(
                color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InfoTextField(
          controller: excludedFoodsCtrl,
          icon: Icons.not_interested_outlined,
          lable: "",
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}
