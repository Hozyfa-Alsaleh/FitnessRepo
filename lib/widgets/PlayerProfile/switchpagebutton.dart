import 'package:flutter/material.dart';

class SwitchButtonPage extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;
  final Color? color;
  const SwitchButtonPage(
      {super.key,
      required this.text,
      required this.icon,
      this.onPressed,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: color ?? const Color.fromARGB(127, 1, 51, 110),
            borderRadius: BorderRadius.circular(20)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
