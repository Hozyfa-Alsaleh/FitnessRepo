import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPreesed;
  const CustomButton(
      {super.key, required this.text, this.color, this.onPreesed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color ?? const Color.fromARGB(127, 1, 51, 110)),
        child: MaterialButton(
          onPressed: onPreesed,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
