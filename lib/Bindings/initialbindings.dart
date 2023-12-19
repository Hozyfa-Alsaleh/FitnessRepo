import 'package:fitnessapp/core/classes/crud.dart';
import 'package:get/instance_manager.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CRUD());
    // Get.put(InfoController());
  }
}
