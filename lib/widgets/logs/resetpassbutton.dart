import 'package:flutter/material.dart';

class ForgetPassButton extends StatelessWidget {
  const ForgetPassButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: const Text(
        "نسيت كلمة المرور؟",
        style: TextStyle(
            color: Colors.white, fontFamily: "Cairo-Regular", fontSize: 18),
      ),
    );
  }
}
