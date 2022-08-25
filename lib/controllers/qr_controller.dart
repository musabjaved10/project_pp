import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:project_pp/screens/payment/payment_confirmation.dart';
import 'package:project_pp/utils/util_functions.dart';

class QRController extends GetxController {
  var scannedQRCode = '';

  Future<void> scanQR(context) async {
    try {
      scannedQRCode = await FlutterBarcodeScanner.scanBarcode(
          '#09ff00', 'Cancel', true, ScanMode.QR);
      print('scanned code is ${scannedQRCode}');
      // print("printing scanned code: ${scannedQRCode.value}");
      if (scannedQRCode != '-1') {
        await Get.defaultDialog(
            title: 'Fee Payment',
            middleText: 'Please confirm to continue payment',
            radius: 8,
            textCancel: 'Cancel',
            onCancel: () => Get.back(),
            textConfirm: 'Confirm',
            confirmTextColor: Colors.white,
            onConfirm: () async {
              closeCustomDialog();
              Get.to(() => PaymentConfirmation());
              // Get.back();
              // payment_dialog.show(
              //   max: 1,
              //   msg: 'Processing Payment',
              //   progressBgColor: Colors.transparent,
              // );
              // await Future.delayed(Duration(seconds: 4));
              // payment_dialog.close();
              // await CoolAlert.show(
              //     context: context,
              //     type: CoolAlertType.success,
              //     text: "Your transaction was successful!",
              //     backgroundColor: const Color(0xff61d6ed),
              //     confirmBtnText: 'View e-Card'
              // );
              // Get.to(() => CardScreen(), transition: Transition.rightToLeftWithFade, duration: Duration(seconds: 1));
            });

      }

    } catch (e) {
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    }
  }
}
