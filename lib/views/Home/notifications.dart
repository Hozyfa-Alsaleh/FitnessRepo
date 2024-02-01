import 'package:captainshoaib/controllers/notifycontroller.dart';
import 'package:captainshoaib/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyNotifyPage extends StatelessWidget {
  final String route;
  const MyNotifyPage({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    Get.put(NotifyController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(route);
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "الإشعارات",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tajwal',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: GetBuilder<NotifyController>(
            builder: (controller) {
              return SizedBox(
                  width: width,
                  height: height,
                  child: FutureBuilder(
                    future: controller.getAllUserNotifications(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (controller.notificatonsList.isNotEmpty) {
                        return ListView.builder(
                          itemCount: controller.notificatonsList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: width,
                              //height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                    transform: GradientRotation(90),
                                    colors: [
                                      Color.fromARGB(255, 0, 0, 0),
                                      Color.fromARGB(117, 0, 0, 0),
                                      Colors.black
                                    ]),
                              ),
                              child: ListTile(
                                  trailing: Text(
                                    "${controller.notificatonsList[index].date}\n${controller.notificatonsList[index].time}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  title: Text(
                                    controller.notificatonsList[index].title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Tajwal'),
                                  ),
                                  subtitle: Text(
                                    controller.notificatonsList[index].body,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontFamily: 'Tajwal'),
                                  )),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "لا يوجد إشعارت",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 27,
                                fontFamily: 'Tajwal'),
                          ),
                        );
                      }
                    },
                  ));
            },
          )),
    );
  }
}
