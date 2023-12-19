import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController dayname;
  final void Function()? onPressed;
  final void Function()? send;
  final String videoname;
  final Color? color;
  const ExerciseCard(
      {super.key,
      required this.controller,
      this.onPressed,
      required this.videoname,
      this.send,
      this.color,
      required this.dayname});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: width,
      decoration: BoxDecoration(
          color: color ?? const Color.fromARGB(255, 10, 76, 131),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: dayname,
                cursorHeight: 30,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: "اليوم",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: controller,
              cursorHeight: 30,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: "اكتب وصف التمرين هنا",
                hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 5, 12, 82),
                      borderRadius: BorderRadius.circular(10)),
                  child: MaterialButton(
                    onPressed: onPressed,
                    child: const Text(
                      "إرفاق فيديو",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Text(
                  videoname,
                  style: const TextStyle(color: Colors.white),
                ),
                IconButton(
                    onPressed: send,
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 28,
                    ))
              ],
            )
          ]),
    );
  }
}
