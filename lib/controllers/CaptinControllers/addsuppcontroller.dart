// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddSuppController extends GetxController {
  bool isUpdate = false;
  late TextEditingController supptext;

  ///-----------------------------------------------------------///
  ///------------------------Insert Methods---------------------///
  ///-----------------------------------------------------------///
  Future<void> insertNewSuppCourse() async {
    try {
      var request = await http.post(Uri.parse(ApiLinks.suppInsert),
          body: {'acc_id': selectedUserId.toString(), 'supp': supptext.text});
      var response = await jsonDecode(request.body);
      if (response['status'] == 1) {
        isUpdate = true;
        print('success');
        getxDialog('كورس المكملات', response['Message'].toString());
      } else {
        getxDialog('كورس المكملات', response['Message'].toString());
      }
    } catch (so) {
      if (so.toString().contains("HandshakeException")) {
        getxDialog('خطأ ', 'يبدو أنك تواجه مشكلة في الاتصال');
      }
    }

    update();
  }

  ///-----------------------------------------------------------///
  ///------------------------Update Methods---------------------///
  ///-----------------------------------------------------------///
  Future<void> updateSuppCourse() async {
    var request = await http.post(Uri.parse(ApiLinks.suppUpdate),
        body: {'acc_id': selectedUserId.toString(), 'supp': supptext.text});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      print('success');
      getxDialog('تحديث', response['Message']);
    } else {
      getxDialog('تحديث', response['Message']);
    }
    update();
  }

  ///-----------------------------------------------------------///
  ///------------------------Delete Methods---------------------///
  ///-----------------------------------------------------------///
  Future<void> deleteSuppCourse() async {
    var request = await http.post(Uri.parse(ApiLinks.suppDelete),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);
    if (supptext.text.isNotEmpty) {
      if (response['status'] == 1) {
        supptext.clear();
        isUpdate = false;
      } else {
        getxDialog('الحذف', 'حدث خطأ ما');
      }
    } else {
      getxDialog('الحذف', 'لا يوجد كورس');
    }
    update();
  }

  ///-----------------------------------------------------------///
  ///------------------------fetch Methods----------------------///
  ///-----------------------------------------------------------///
  Future fetchSuppCourse() async {
    try {
      var request = await http.post(Uri.parse(ApiLinks.suppfetch),
          body: {'acc_id': selectedUserId.toString()});
      var response = await jsonDecode(request.body);

      if (response['status'] == 1) {
        print('success');
        supptext.text = response['data']['supp'].toString();
        print(supptext.text);
        isUpdate = true;
      }
    } catch (e) {
      getxDialog('', 'حدث خطأ بجلب البيانات');
    }
    update();
  }

  @override
  void onInit() {
    supptext = TextEditingController();

    fetchSuppCourse();
    super.onInit();
  }
}
