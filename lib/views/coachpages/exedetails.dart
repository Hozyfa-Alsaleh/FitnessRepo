import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:captainshoaib/controllers/CaptinControllers/adminexecontroller.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/views/coachpages/displayvideo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExeDetails extends StatelessWidget {
  const ExeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminExeController>(
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColors.scaffoldBackGroundColor,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              toolbarHeight: 150,
              title: const Text(
                "تفاصيل التمرين",
                style: TextStyle(
                    color: Colors.black, fontSize: 33, fontFamily: 'Tajwal'),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      controller.updateExeCourse();
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),
            body: SizedBox(
              width: width,
              //  height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextFormField(
                          controller: controller.editExe,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          style: const TextStyle(
                              fontFamily: 'Tajwal',
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: "Write new exercise here",
                            hintStyle: TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      //shrinkWrap: true,
                      itemCount: controller.videos.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => DisplayVideo(
                                  index: index,
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 20),
                            alignment: Alignment.center,
                            height: 90,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(192, 1, 52, 110),
                                    width: 3.5),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              leading: const Icon(
                                Icons.info_outline,
                                size: 30,
                                color: Colors.black,
                              ),
                              title: Text(
                                "الفيديو رقم ${index + 1}",
                                style: const TextStyle(
                                    fontFamily: 'Tajwal',
                                    color: Colors.black,
                                    fontSize: 25),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
