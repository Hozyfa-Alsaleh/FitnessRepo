import 'package:flutter/material.dart';
import 'package:get/get.dart';

validateInput(String val, int min, int max, TextInputType type) {
  if (val.isNotEmpty) {
    if (type == TextInputType.emailAddress) {
      if (!GetUtils.isEmail(val)) {
        return "الرجاء ادخال ايميل صحيح";
      }
    } else if (type == TextInputType.name) {
      if (!GetUtils.isUsername(val)) {
        return "لرجاء كتابة الاسم بشكل صحيح";
      }
    }
    if (type == TextInputType.visiblePassword) {
      if (val.length < min) {
        return "لا يجب أن تكون أقل من $min محارف";
      } else if (val.length > max) {
        return "لا يجب أن تتجاوز $max محارف";
      }
    }
  } else if (val.isEmpty) {
    return "الرجاء ملئ الحقول الفارغة";
  }
}
