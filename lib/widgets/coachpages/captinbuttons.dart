import 'package:flutter/material.dart';

class CaptinButtons extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;
  final Color? color;
  const CaptinButtons(
      {super.key,
      required this.text,
      required this.icon,
      this.onPressed,
      this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(192, 1, 52, 110), width: 3.5),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.black,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                    fontFamily: 'Tajwal',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
