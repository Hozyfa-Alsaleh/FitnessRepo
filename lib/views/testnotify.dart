import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/controllers/testcontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestNotify extends StatelessWidget {
  const TestNotify({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TestController());
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                sherdpref!.clear();
                Get.offAllNamed(AppRoute.LOGIN);
              },
              icon: const Icon(Icons.logout),
            ),
            centerTitle: true,
            title: const Text(
              "اختبار الإشعارات",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Tajwal', fontSize: 30),
            )),
        body: GetBuilder<TestController>(
          builder: (controller) {
            return Center(
                child: Column(
              children: [
                TextFormField(
                    controller: controller.userid,
                    decoration: const InputDecoration(hintText: "user id")),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                    controller: controller.title,
                    decoration: const InputDecoration(hintText: "title")),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: controller.content,
                  decoration: const InputDecoration(hintText: "content"),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(10),
                  onPressed: () {
                    controller.send();
                  },
                  child: const Text(
                    "أرسل إشعار",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'Tajwal'),
                  ),
                ),
              ],
            ));
          },
        ));
  }
}
