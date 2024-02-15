import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: camel_case_types
class CustomeVideoPlayer extends StatelessWidget {
  final VideoPlayerController vidController;
  final void Function()? playVideo;
  final void Function()? edit;
  final void Function()? delete;
  final void Function()? fullScreen;
  final String? person;
  final IconData icon;
  const CustomeVideoPlayer(
      {super.key,
      required this.vidController,
      this.playVideo,
      required this.icon,
      this.edit,
      this.delete,
      this.person,
      this.fullScreen});

  @override
  Widget build(BuildContext context) {
    return vidController.dataSource != ""
        ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromARGB(255, 69, 122, 148)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    child: AspectRatio(
                      aspectRatio: vidController.value.aspectRatio,
                      child: VideoPlayer(
                        vidController,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 69, 122, 148)),
                    child: SizedBox(
                      //width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 0,
                              child: Container(
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: playVideo,
                                  icon: Icon(
                                    icon,
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
                                vidController,
                                colors: const VideoProgressColors(
                                    playedColor: Colors.white,
                                    backgroundColor: Colors.black),
                                allowScrubbing: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
