import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const LoginButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        alignment: Alignment.topCenter,
        width: 150,
        height: 60,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  spreadRadius: 1,
                  blurRadius: 30,
                  offset: Offset(0, 0))
            ],
            color: Color.fromARGB(191, 1, 51, 110),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 30, fontFamily: "Cairo-Regular", color: Colors.white),
        ),
      ),
    );
  }
}
