import 'package:flutter/material.dart';

class InfoTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final bool? obsecure;
  final IconData icon;
  final double? iconsize;
  final TextInputType? keyboardType;
  final void Function()? onPressed;
  final String? Function(String?)? validator;
  final double? fontsize;
  final double? width;
  final String lable;
  final bool? maxLines;
  const InfoTextField(
      {super.key,
      this.hint,
      this.controller,
      this.obsecure,
      required this.icon,
      this.keyboardType,
      this.onPressed,
      this.validator,
      this.fontsize,
      this.width,
      this.iconsize,
      required this.lable,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        maxLines: keyboardType == TextInputType.multiline ? null : 1,
        obscureText: obsecure == null || obsecure == false ? false : true,
        controller: controller,
        textDirection: TextDirection.rtl,
        style: TextStyle(fontSize: fontsize, color: Colors.black),
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: Icon(
            icon,
            color: Colors.black,
            size: iconsize,
          ),
          suffix: obsecure == true || obsecure == false
              ? SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    icon: Icon(
                      obsecure == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: onPressed,
                  ),
                )
              : null,
          prefixIconColor: Colors.black,
          hintTextDirection: TextDirection.rtl,
          hintText: hint,
          labelText: lable,

          alignLabelWithHint: true,
          labelStyle:
              const TextStyle(color: Colors.black, fontFamily: 'Tajwal'),
          floatingLabelStyle: const TextStyle(
              fontFamily: 'Tajwal',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600),
          // alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          hintStyle: const TextStyle(
              fontSize: 20, fontFamily: "Cairo-Regular", color: Colors.white),
          enabledBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          focusedBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.grey, width: 2)),
        ),
      ),
    );
  }
}
