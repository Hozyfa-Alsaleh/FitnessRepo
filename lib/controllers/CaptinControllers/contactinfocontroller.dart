import 'dart:convert';
import 'dart:io';

import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/core/functions/uploadfile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ContactInfoController extends GetxController {
  late TextEditingController phone;

  File? barcode;
  String? imagePath;
  bool isUpdate = false;
  String? previousImage;
  RequestStatus requestState = RequestStatus.holding;
  pickBarcodeImage() async {
    var pickedBarcode =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedBarcode == null) return;
    barcode = File(pickedBarcode.path);
    if (imagePath != null) {
      imagePath = null;
    }
    update();
  }

  Future fetchContactInfo() async {
    requestState = RequestStatus.loading;
    var request = await http.post(Uri.parse(ApiLinks.contactfetch));
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      if (response['data'] != null) {
        phone.text = response['data'][0]['phone'].toString();
        imagePath =
            "${ApiLinks.contactFolder}/${response['data'][0]['barcodeurl']}";
        previousImage = response['data'][0]['barcodeurl'].toString();
        isUpdate = true;
        requestState = RequestStatus.success;
      } else {
        requestState = RequestStatus.success;
      }
    } else {
      requestState = RequestStatus.success;
      getxDialog('جلب البيانات', 'حدث خطأ أثناء جلب البيانات');
    }
    update();
  }

  Future<void> insertContactInfo() async {
    if (barcode == null) {
      getxDialog('خطأ', 'لم تقم بتحميل صورة للباركود');
    } else {
      requestState = RequestStatus.loading;
      if (await postRequestWithFile(
              ApiLinks.contactInsert, {'phone': phone.text}, barcode!) ==
          'OK') {
        getxDialog('إضافة', "تم إضافة معلومات التواصل بنجاح");
        isUpdate = true;
        requestState = RequestStatus.success;
      } else {
        requestState = RequestStatus.success;

        getxDialog('خطأ', 'حدث خطأ ما ولم تتم عملية الإضافة');
      }
    }
    update();
  }

  Future<void> updateContactInfo() async {
    requestState = RequestStatus.loading;

    if (barcode == null) {
      var request = await http.post(Uri.parse(ApiLinks.contactUpdate), body: {
        'phone': phone.text,
        'barcodeimg': previousImage,
      });
      var response = await jsonDecode(request.body);
      if (response['status'] == 1) {
        getxDialog('إضافة', "تم تعديل معلومات التواصل بنجاح");
      } else {
        getxDialog('خطأ', 'حدث خطأ ما ولم تتم عملية الإضافة');
      }
    } else {
      if (await postRequestWithFile(
              ApiLinks.contactUpdate,
              {
                'phone': phone.text,
                'barcodeimg': previousImage,
              },
              barcode!) ==
          'OK') {
        isUpdate = true;
        requestState = RequestStatus.success;
        getxDialog('إضافة', "تم تعديل معلومات التواصل بنجاح");
      } else {
        getxDialog('خطأ', 'حدث خطأ ما ولم تتم عملية الإضافة');
      }
    }
    update();
  }

  @override
  void onInit() {
    phone = TextEditingController();
    fetchContactInfo();
    super.onInit();
  }
}
