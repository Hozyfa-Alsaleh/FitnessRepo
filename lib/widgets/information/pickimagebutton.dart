import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:flutter/material.dart';

class PickImageButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const PickImageButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.sizeOf(context).width / 2,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(7),
            shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
                side: const BorderSide(color: AppColors.border, width: 3),
                borderRadius: BorderRadius.circular(25))),
            backgroundColor: const MaterialStatePropertyAll(Colors.white)),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 26, color: Colors.black, fontFamily: 'Tajwal'),
        ),
      ),
    );
  }
}
