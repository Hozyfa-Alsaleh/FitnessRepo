// ignore_for_file: file_names

import 'dart:convert';

import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/approute.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/models/package.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PackagesController extends GetxController {
  late GlobalKey<FormState> formkey;
  late TextEditingController name;
  late TextEditingController time;
  late TextEditingController price;
  late TextEditingController notes;
  List<PackageModel> packages = [];
  int packageId = 0;
  bool isUpdate = false;

  ///------------------------Fetch Method---------------------///
  Future fetchPackages() async {
    var request = await http.post(Uri.parse(ApiLinks.packages), body: {});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      if (packages.isEmpty) {
        packages.clear();
        for (var element in response['data']) {
          packages.add(PackageModel(
            id: element['package_id'],
            name: element['name'],
            time: element['time'],
            price: element['price'],
            details: element['details'],
          ));
        }
      }
      return packages;
    } else {
      print('faild');
      return null;
    }
  }

  moveToPackageCRUD(int index) {
    try {
      if (packages.isNotEmpty) {
        packageId = packages[index].id!;
        name.text = packages[index].name;
        time.text = packages[index].time;
        price.text = packages[index].price;
        notes.text = packages[index].details;
        isUpdate = true;
      }
      print(isUpdate.toString());
      Get.toNamed(AppRoute.packageCRUD);
      print("pack id ====> " + packageId.toString());
      update();
    } catch (e) {
      getxDialog('الباقات', 'حدث خطأ أثناء الانتقال الى تفاصيل الباقة');
    }
  }

  ///--------------------------CRUD METHODS-----------------------///
  ///-------------------------Insert Method------------------------///
  Future<void> insertPackage() async {
    var request = await http.post(Uri.parse(ApiLinks.packageInsert), body: {
      'name': name.text,
      'time': time.text,
      'price': price.text,
      'details': notes.text
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      getxDialog('إضافة باقة', 'تم إضافة الباقة بنجاح');
      isUpdate = true;
    } else {
      getxDialog('إضافة باقة', 'حدث خطأ أثناء إضافة الباقة');
    }
    update();
  }

  ///--------------------------Update Method-------------------------///
  Future<void> updatePackage() async {
    var request = await http.post(Uri.parse(ApiLinks.packageUpdate), body: {
      'package_id': packageId.toString(),
      'name': name.text,
      'time': time.text,
      'price': price.text,
      'details': notes.text
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      getxDialog('تحديث الباقة', 'تم تعديل الباقة بنجاح');
    } else {
      getxDialog('تحديث الباقة', 'حدث خطأ أثناء تحديث الباقة');
    }
  }

  ///-----------------------Delete Package-----------------///
  Future<void> deletePackage() async {
    var request = await http.post(Uri.parse(ApiLinks.packageDelete),
        body: {'package_id': packageId.toString()});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      name.clear();
      time.clear();
      price.clear();
      notes.clear();
      isUpdate = false;
    } else {
      getxDialog('حذف الباقة', "حدث خطأ أثناء حذف الباقة");
    }
  }

  @override
  void onInit() {
    formkey = GlobalKey<FormState>();
    name = TextEditingController();
    time = TextEditingController();
    price = TextEditingController();
    notes = TextEditingController();
    fetchPackages();

    super.onInit();
  }
}
