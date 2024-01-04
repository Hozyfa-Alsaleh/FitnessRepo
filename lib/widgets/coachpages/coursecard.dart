import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String text;
  final IconData img;
  final void Function()? onTap;
  const CourseCard(
      {super.key, required this.text, required this.img, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: ListTile(
        onTap: onTap,
        title: Text(text),
        titleTextStyle: const TextStyle(fontSize: 23),
        leading: SizedBox(
          height: 100,
          width: 70,
          child: CircleAvatar(
            backgroundColor: AppColors.foucsborder,
            child: Icon(img),
          ),
        ),
        trailing: const Icon(
          Icons.info,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
