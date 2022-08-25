import 'package:get/get.dart';
import 'package:project_pp/controllers/qr_controller.dart';


class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<QRController>(QRController());
  }
}