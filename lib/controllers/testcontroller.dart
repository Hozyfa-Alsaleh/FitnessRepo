import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:captainshoaib/Utils/apilinks.dart';
import 'package:captainshoaib/core/classes/requeststate.dart';
import 'package:captainshoaib/core/functions/getxdialog.dart';
import 'package:captainshoaib/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TestController extends GetxController {
  late TextEditingController title;
  late TextEditingController content;
  late TextEditingController userid;
  RequestStatus reqStatus = RequestStatus.holding;
  String? token;
  String? sendToken;
  @override
  void onInit() async {
    title = TextEditingController();
    content = TextEditingController();
    userid = TextEditingController();
    token = await FirebaseMessaging.instance.getToken();
    print("===============================");
    print(token);
    sherdpref!.setString('token', token!);
    print("===============================");
    addToken();

    super.onInit();
  }

  send() async {
    await chooseUser();
    if (sendToken == null) {
      getxDialog('', 'The Token is empty');
    } else {}
  }

  Future chooseUser() async {
    var request = await http.post(
        Uri.parse("${ApiLinks.proteam}/testtoken.php"),
        body: {'acc_id': userid.text});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      sendToken = response['data'][0]['token'];
      getxDialog('', sendToken!);
    } else {
      getxDialog('', request.reasonPhrase.toString());
    }
    update();
  }

  Future<void> addToken() async {
    var request = await http
        .post(Uri.parse('${ApiLinks.proteam}/Auth/addtoken.php'), body: {
      'acc_id': sherdpref!.getString('userId').toString(),
      'token': token
    });
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      print('token added');
      getxDialog('', 'Token Added');
    } else {
      getxDialog('', 'faild to add token');
    }
  }
}
