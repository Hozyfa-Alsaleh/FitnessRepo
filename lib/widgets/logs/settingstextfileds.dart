import 'package:fitnessapp/Utils/appcolors.dart';
import 'package:flutter/material.dart';

class SettingsTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool? obsecure;
  final IconData icon;
  final TextInputType? keyboardType;
  final void Function()? onPressed;
  final String? Function(String?)? validator;
  final String? hint;
  final TextDirection? direction;
  const SettingsTextField(
      {super.key,
      required this.label,
      this.controller,
      this.obsecure,
      required this.icon,
      this.keyboardType,
      this.onPressed,
      this.validator,
      this.hint,
      this.direction});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecure == null || obsecure == false ? false : true,
      controller: controller,
      textDirection: direction ?? TextDirection.rtl,
      style: const TextStyle(
          fontSize: 25, color: Colors.black, fontFamily: 'Tajwal'),
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: Colors.black,
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
                    color: Colors.black,
                  ),
                  onPressed: onPressed,
                ),
              )
            : null,
        prefixIconColor: Colors.black,
        hintTextDirection: TextDirection.rtl,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 30, fontFamily: "Tajwal"),
        hintStyle: const TextStyle(
          fontSize: 23,
          fontFamily: "Tajwal",
          //color: Color.fromARGB(166, 217, 217, 217),
        ),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: AppColors.buttonsColor, width: 3)),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: AppColors.foucsborder, width: 3)),
      ),
    );
  }
}
