import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  final String text;
  final String imgurl;
  final void Function()? onTap;
  const PlayerCard(
      {super.key, required this.text, this.onTap, required this.imgurl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(192, 1, 52, 110), width: 3.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: ListTile(
          onTap: onTap,
          title: Text(
            text,
            style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Tajwal',
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          titleTextStyle: const TextStyle(fontSize: 23),
          leading: SizedBox(
            height: 100,
            width: 70,
            child: CircleAvatar(
              backgroundImage: imgurl != "" ? NetworkImage(imgurl) : null,
              backgroundColor: const Color.fromARGB(127, 1, 52, 110),
            ),
          ),
          trailing: const Icon(
            Icons.info_outline_rounded,
            color: Colors.black,
            size: 35,
          )),
    );
  }
}
