import 'package:project_pp/controllers/map_controller.dart';
import 'package:get/get.dart';


class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MapController>(MapController());
  }
}