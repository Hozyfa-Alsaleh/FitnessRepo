import 'package:captainshoaib/Utils/apilinks.dart';
import 'package:captainshoaib/approute.dart';
import 'package:captainshoaib/core/StaticLData/staticvar.dart';
import 'package:captainshoaib/core/classes/requeststate.dart';
import 'package:captainshoaib/core/functions/getxdialog.dart';
import 'package:captainshoaib/core/functions/handlingdata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  bool secure = true;
  bool confirmSecure = true;
  late GlobalKey<FormState> signFormKey;
  late TextEditingController regusername;
  late TextEditingController nickName;
  late TextEditingController email;
  late TextEditingController regpassword;
  late TextEditingController confirmpassword;
  late TextEditingController phone;

  showpass() {
    secure = !secure;
    update();
  }

  showConfirm() {
    confirmSecure = !confirmSecure;
    update();
  }

  @override
  void onInit() {
    signFormKey = GlobalKey<FormState>();
    regusername = TextEditingController();
    nickName = TextEditingController();
    email = TextEditingController();
    regpassword = TextEditingController();
    confirmpassword = TextEditingController();
    phone = TextEditingController();
    super.onInit();
  }

  signup() async {
    if (signFormKey.currentState!.validate()) {
      if (confirmpassword.text == regpassword.text) {
        var response = await testData.signup(ApiLinks.signup, regusername.text,
            nickName.text, email.text, phone.text, regpassword.text);
        requestStatus = handlingdata(response);
        if (RequestStatus.success == requestStatus) {
          Get.offAllNamed(AppRoute.LOGIN);
        }
      } else {
        getxDialog("خطأ", requestStatus.toString());
      }
    }
    update();
  }
}
