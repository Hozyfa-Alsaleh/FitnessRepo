// ignore_for_file: camel_case_types

import 'package:fitnessapp/controllers/videocontroller.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class videoAppState extends StatelessWidget {
  const videoAppState({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VideoController());
    return MaterialApp(
        title: 'Video Demo',
        home: GetBuilder<VideoController>(
          builder: (controller) {
            return Scaffold(
              body: Center(
                child: controller.controller.value.isInitialized
                    ? Container(
                        width: width,
                        height: 280,
                        padding: const EdgeInsets.only(
                            top: 20, right: 8, left: 8, bottom: 2),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width,
                                height: 210,
                                child: AspectRatio(
                                  aspectRatio:
                                      controller.controller.value.aspectRatio,
                                  child: VideoPlayer(controller.controller),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                        onPressed: () {
                                          controller.controllerVideo();
                                          controller.changeIcon();
                                        },
                                        icon: Icon(
                                          controller.icon,
                                          size: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: VideoProgressIndicator(
                                      padding: const EdgeInsets.all(0.0),
                                      controller.controller,
                                      colors: const VideoProgressColors(
                                          playedColor: Colors.red,
                                          backgroundColor: Colors.black),
                                      allowScrubbing: true,
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      )
                    : Container(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  controller.controllerVideo();
                  controller.changeIcon();
                },
                child: Icon(
                  controller.icon,
                ),
              ),
            );
          },
        ));
  }
}
