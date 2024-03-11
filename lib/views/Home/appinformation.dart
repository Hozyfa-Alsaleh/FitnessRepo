import 'package:captainshoaib/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInformation extends StatelessWidget {
  const AppInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(AppRoute.HOME);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          title: const Text(
            "حول التطبيق",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Tajwal",
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.offAllNamed(AppRoute.HOME);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 30,
                ))
          ],
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
            children: const [
              Text(
                "هذا التطبيق هو تطبيق لكمال الأجسام والصحة البدنية \n تحت إشراف الكابتن شعيب ",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Tajwal', fontSize: 28),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "يساعد هذا التطبيق في إدارة تمارين اللاعبين وكورساتهم من خلال الكابتن شعيب\n حيث يقوم اللاعب يالتسجيل وإرسال معلوماته  \nليقوم الكابتن بإرسال التمارين والكورسات المناسبة للاعب ",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Tajwal', fontSize: 28),
                textAlign: TextAlign.center,
              ),
            ]),
      ),
    );
  }
}
