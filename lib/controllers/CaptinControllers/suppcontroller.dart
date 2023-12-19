import 'dart:convert';

import 'package:fitnessapp/Utils/apilinks.dart';
import 'package:fitnessapp/core/StaticLData/staticvar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SuppController extends GetxController {
  Future fetchSuppCourse() async {
    var request = await http.post(Uri.parse(ApiLinks.suppfetch),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);

    if (response['status'] == 1) {
      return response;
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    fetchSuppCourse();
    super.onInit();
  }
}
