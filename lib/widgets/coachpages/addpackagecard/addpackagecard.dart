import 'package:fitnessapp/main.dart';
import 'package:fitnessapp/widgets/coachpages/addpackagecard/fieldofcard.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class AddPackageCard extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController time;
  final TextEditingController price;
  final TextEditingController details;
  final GlobalKey<FormState> formkey;

  const AddPackageCard(
      {super.key,
      required this.name,
      required this.time,
      required this.price,
      required this.details,
      required this.formkey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 30),
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                spreadRadius: 0,
                offset: Offset(0.8, 1))
          ],
          gradient:
              const LinearGradient(transform: GradientRotation(40), colors: [
            Color.fromARGB(255, 24, 126, 209),
            Color.fromARGB(255, 12, 96, 165),
            Color.fromARGB(255, 6, 52, 90),
          ])),
      child: Form(
        key: formkey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldOfCard(controller: name, label: "اسم الباقة:"),
              FieldOfCard(controller: time, label: "مدة الباقة(عدد الأيام:)"),
              FieldOfCard(controller: price, label: "سعر الباقة:"),
              FieldOfCard(controller: details, label: "التفاصيل:"),
            ]),
      ),
    );
  }
}
