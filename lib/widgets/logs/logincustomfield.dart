import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool? obsecure;
//  final IconData icon;
  final TextInputType? keyboardType;
  final void Function()? onPressed;
  final String? Function(String?)? validator;
  const CustomTextField(
      {super.key,
      required this.hint,
      this.controller,
      this.obsecure,
      // required this.icon,
      this.keyboardType,
      this.onPressed,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure == null || obsecure == false ? false : true,
      controller: controller,
      textDirection: TextDirection.rtl,
      style: const TextStyle(fontSize: 25, color: Colors.white),
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.black26,
        prefix: const SizedBox(
          width: 8,
        ),
        suffixIcon: obsecure == true || obsecure == false
            ? Container(
                margin: EdgeInsets.only(left: 12),
                width: 50,
                height: 30,
                child: IconButton(
                  icon: Icon(
                    obsecure == true ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: onPressed,
                ),
              )
            : null,
        prefixIconColor: Colors.white,
        hintTextDirection: TextDirection.rtl,
        hintText: hint,
        hintStyle: const TextStyle(
            fontSize: 20, fontFamily: "Cairo-Regular", color: Colors.white),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: AppColors.buttonsColor, width: 1)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: AppColors.foucsborder, width: 2)),
      ),
    );
  }
}
