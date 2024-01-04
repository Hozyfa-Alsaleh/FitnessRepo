import 'package:flutter/material.dart';

class WorkButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  final double? fontsize;
  final double? height;
  final Color? color;
  const WorkButton(
      {super.key,
      this.text,
      this.onTap,
      this.fontsize,
      this.height,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      splashColor: Colors.grey,
      child: Container(
        alignment: Alignment.center,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 75, 75, 75),
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 1))
          ],
          // color: Colors.deepOrange[900],
          // color: color ?? AppColors.buttonsColor,
          color: color ?? const Color.fromARGB(255, 87, 87, 87),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text!,
          style: TextStyle(color: Colors.white, fontSize: fontsize ?? 30),
        ),
      ),
    );
  }
}
