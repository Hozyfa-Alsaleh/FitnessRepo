import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;

  const CustomButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppColors.border, width: 3),
          color: Colors.white,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}

class PickImageButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const PickImageButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 26,
          color: Colors.black,
          fontFamily: 'Tajwal',
        ),
      ),
    );
  }
}
