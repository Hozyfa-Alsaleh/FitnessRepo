import 'package:captainshoaib/Utils/appcolors.dart';
import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool? obsecure;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;
  final void Function()? onPressed;
  final String? Function(String?)? validator;
  final String? hint;
  const SignUpTextField(
      {super.key,
      required this.label,
      this.controller,
      this.obsecure,
      required this.icon,
      this.keyboardType,
      this.onPressed,
      this.validator,
      this.hint,
      this.textDirection});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure == null || obsecure == false ? false : true,
      controller: controller,
      textDirection: textDirection ?? TextDirection.rtl,
      style: const TextStyle(fontSize: 25, color: Colors.white),
      //keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.black26,
        prefixIcon: Icon(
          icon,
          color: Colors.white,
          size: 27,
        ),
        prefix: const SizedBox(width: 8),
        suffixIcon: obsecure == true || obsecure == false
            ? Container(
                margin: const EdgeInsets.only(left: 12),
                width: 30,
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
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.white, fontSize: 30, fontFamily: "Cairo-Regular"),
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: "Cairo-Regular",
          color: Color.fromARGB(166, 217, 217, 217),
        ),
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
