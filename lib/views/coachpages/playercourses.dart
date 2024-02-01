import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/widgets/coachpages/coursecard.dart';
import 'package:flutter/material.dart';

class PlayerCourses extends StatelessWidget {
  const PlayerCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackGroundColor,
      body: SizedBox(
        height: height,
        width: width,
        child: ListView(
          children: [
            CourseCard(
              text: "التمارين",
              img: Icons.fitness_center,
              onTap: () {},
            ),
            CourseCard(
              text: "الغذاء",
              img: Icons.food_bank_rounded,
              onTap: () {},
            ),
            CourseCard(
              text: "المكملات",
              img: Icons.health_and_safety,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
