import 'dart:convert';

import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/core/functions/getxdialog.dart';
import 'package:fitnessapp/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ManageProfileController extends GetxController {
  bool secure = true;
  bool confirmSecure = true;
  late GlobalKey<FormState> settingKey;
  late TextEditingController regusername;
  late TextEditingController nickName;
  late TextEditingController email;
  late TextEditingController regpassword;
  late TextEditingController confirmpassword;
  late TextEditingController phone;
  String statusText = "لم تقم بإرسال معلومات بعد";
  Color bkcolor = Colors.yellow;
  showpass() {
    secure = !secure;
    update();
  }

  showConfirm() {
    confirmSecure = !confirmSecure;
    update();
  }
  Future<void> deleteUser() async {
    var request = await http.post(Uri.parse(ApiLinks.deletePlayer),
        body: {'acc_id':sherdpref!.getString('userId')});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
     sherdpref!.clear();
     Get.offAllNamed(AppRoute.Splash);
    } else {
      getxDialog('حذف حسابي', 'حدث خطأ خلال إزالة الحساب');
    }
  }
  Future<void> updateMyAccountInfo() async {
    var request = await http
        .post(Uri.parse("${ApiLinks.proteam}/manageprofile.php?update"), body: {
      'acc_id': sherdpref!.getString('userId'),
      'name': regusername.text,
      'lastname': nickName.text,
      'email': email.text,
      'password': regpassword.text,
      'phone': phone.text
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      Get.snackbar('تحديث البيانات', 'تم تحديث بيانات حسابك بنجاح',
          backgroundColor: const Color.fromARGB(160, 0, 0, 0),
          colorText: Colors.white);
      fetchCurrentUserAccount();
    } else {
      getxDialog('تحديث معلومات الحساب',
          'يبدو أنك تواجه خطأ في تحديث البيانات تأكد من جودة الاتصال لديك أو من أنك قمت بأي تعديل');
    }
    update();
  }

  Future fetchCurrentUserAccount() async {
    var request = await http.post(
        Uri.parse("${ApiLinks.proteam}/manageprofile.php?fetch"),
        body: {'acc_id': sherdpref!.getString('userId').toString()});
    var response = await jsonDecode(request.body);
    print(response['data'][0]['status']);
    if (response['status'] == 1) {
      regusername.text = response['data'][0]['name'];
      nickName.text = response['data'][0]['nickname'];
      email.text = response['data'][0]['email'];
      regpassword.text = response['data'][0]['password'];
      phone.text = response['data'][0]['phone'];
      sherdpref!.setString('username', response['data'][0]['name']);
      if (response['data'][0]['status'] == 3) {
        statusText = "تم رفض طلبك للأسف";
        bkcolor = const Color.fromARGB(255, 202, 32, 20);
      } else if (response['data'][0]['status'] == 1) {
        statusText = "حسابك مفعل الآن";
        bkcolor = Colors.green;
      } else if (response['data'][0]['status'] == 0) {
        statusText = "بانتظار الاستجابة لطلبك";
      }
      update();
    } else {
      getxDialog('', 'حدث خطأ بجلب البيانات');
    }
  }

  @override
  void onInit() {
    settingKey = GlobalKey<FormState>();
    regusername = TextEditingController();
    nickName = TextEditingController();
    email = TextEditingController();
    regpassword = TextEditingController();
    confirmpassword = TextEditingController();
    phone = TextEditingController();
    fetchCurrentUserAccount();
    super.onInit();
  }
}
