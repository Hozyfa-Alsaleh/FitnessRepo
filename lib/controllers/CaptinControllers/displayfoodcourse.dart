import 'dart:convert';

import 'package:captainshoaib/Utils/apilinks.dart';
import 'package:captainshoaib/core/StaticLData/staticvar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DisplayFoodController extends GetxController {
  Future getFoodCourse() async {
    var request = await http.post(Uri.parse(ApiLinks.fetchfood),
        body: {'acc_id': selectedUserId.toString()});
    var response = await jsonDecode(request.body);

    return response['data'];
  }

  @override
  void onInit() {
    getFoodCourse();
    super.onInit();
  }
}
