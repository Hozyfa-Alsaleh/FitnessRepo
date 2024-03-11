import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CoachProfileController extends GetxController {
  goToThePage(String route) {
    Get.toNamed(route);
    update();
  }

  File? profilePic;
//!Mark: mhamad updated this

  ///Pick Imagee for player photo
Future<void> pickeImageProfile() async {
  var status = await Permission.photos.request();

  if (status == null || status.isDenied) {
    if (kDebugMode) {
      print('Permission denied');
    }
    return;
  }

  try {
    var img = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (img == null) return;
    profilePic = File(img.path);
  } catch (e) {
    if (kDebugMode) {
      print('Error picking profile image: $e');
    }
  }

  update();
}

}
