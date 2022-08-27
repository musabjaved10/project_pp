import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:project_pp/screens/payment/payment_confirmation.dart';
import 'package:project_pp/utils/util_functions.dart';
import 'package:http/http.dart' as http;

class QRController extends GetxController {
  var scannedQRCode = '';
  Map voucherData = {};

  @override
  void onReady(){
    super.onReady();
    voucherData = {};
  }

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
              await Future.delayed(const Duration(seconds: 1));
              showCustomDialog('Processing request');
              await initiatePayment(context, scannedQRCode);
              if(voucherData.isEmpty) return Get.back();
              closeCustomDialog();
              return Get.to(() => const PaymentConfirmation(), arguments: [voucherData]);
            });

      }

    } catch (e) {
      closeCustomDialog();
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    }
  }

  Future<void> initiatePayment(context, code) async {

    try {
      final url = Uri.parse('${dotenv.env['db_url']}/payment/initiate?code=${code}');
      final res = await http.get(url, headers: {"api-key": "${dotenv.env['api_key']}", "uid":"4WhTzlx2aHUIoqt28m3jl4evu9L2"});
      final resData = jsonDecode(res.body);
      print('data for voucher initiate payment $resData');
      if (resData['status'] != 200 && resData['errors'] != null) {
        closeCustomDialog();
        await CoolAlert.show(
          animType: CoolAlertAnimType.slideInUp,
          backgroundColor: Colors.blueAccent,
          context: context,
          type: CoolAlertType.error,
          title: 'Oops...',
          text: '${resData['errors'].values.first}',
          loopAnimation: false,
        );
        return;
      }
      voucherData = resData['success']['data'];
      // ignore: empty_catches
      return;
    } catch (e) {
      print(e);
      voucherData = {};
      showSnackBar('Error', 'Unable to fetch organizations');
      return;
    }
  }
}
