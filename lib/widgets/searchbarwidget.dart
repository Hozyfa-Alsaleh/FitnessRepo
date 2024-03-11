import 'package:captainshoaib/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String hint;
  final void Function()? onPressed;
  const SearchBarWidget(
      {super.key,
      this.onChanged,
      required this.controller,
      required this.hint,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(width!, 60.h),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            padding: EdgeInsets.only(bottom: 8.h),
            width: width,
            child: TextFormField(
              onChanged: onChanged,
              controller: controller,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'Tajwal',
                  fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                hintText: hint,
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 78, 78, 78),
                    fontSize: 18,
                    fontFamily: 'Tajwal'),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.5)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.5)),
              ),
            ),
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.h);
}