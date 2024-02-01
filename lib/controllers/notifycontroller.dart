import 'dart:convert';
import 'package:captainshoaib/Utils/apilinks.dart';
import 'package:captainshoaib/main.dart';
import 'package:captainshoaib/models/notification.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotifyController extends GetxController {
  List<MyNotification> notificatonsList = [];
  List<MyNotification> initalList = [];

  Future getAllUserNotifications() async {
    var request = await http.post(
        Uri.parse("${ApiLinks.proteam}/notifications.php?fetch"),
        body: {'acc_id': sherdpref!.getString('userId')});
    var response = await jsonDecode(request.body);
    if (response['status'] == 1) {
      if (initalList.isNotEmpty) {
        initalList.clear();
      }
      if (notificatonsList.isNotEmpty) {
        notificatonsList.clear();
      }
      for (var element in response['data']) {
        initalList.add(MyNotification(
            date: element['notic_date'],
            title: element['notic_title'],
            body: element['notice_text'],
            time: element['notic_time']));
      }
      for (var element in initalList.reversed) {
        notificatonsList.add(element);
      }
      print(notificatonsList);
    } else {
      return [];
    }
  }
}
