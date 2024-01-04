import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';

class RowOfInfo extends StatelessWidget {
  final String title;
  final String desc;
  const RowOfInfo({super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: width,
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.border, width: 3.5),
          // color: const Color.fromARGB(204, 10, 23, 99),
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
        title: Text("$title:"),
        subtitle: Text(
          desc,
          style: const TextStyle(
              // color: Color.fromARGB(255, 255, 73, 60),
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
