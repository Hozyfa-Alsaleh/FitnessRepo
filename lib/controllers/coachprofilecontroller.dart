import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CoachProfileController extends GetxController {
  goToThePage(String route) {
    Get.toNamed(route);
    update();
  }

  File? profilePic;

  ///Pick Imagee for player photo
  Future pickeImageProfile() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) return;
    profilePic = File(img.path);
    update();
  }
}
