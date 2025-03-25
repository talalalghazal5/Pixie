import 'package:get/get.dart';
import 'package:pixie/controllers/main_controller.dart';
import 'package:pixie/controllers/photos_controller.dart';
class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PhotosController());
    Get.put(MainController());
  }
}
