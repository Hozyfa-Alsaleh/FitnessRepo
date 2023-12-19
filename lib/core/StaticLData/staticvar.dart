import 'package:fitnessapp/core/classes/requeststate.dart';
import 'package:fitnessapp/core/classes/testdata.dart';
import 'package:get/get.dart';

TestData testData = TestData(Get.find());
RequestStatus requestStatus = RequestStatus.holding;
List<String> infoTitles = [
  "حالة الكورس",
  "الهدف من التمرين",
  "المنطقة",
  "القاعة",
  "الطول",
  "الوزن"
];
int selectedUserId = 0;
String selectedUserName = "";
