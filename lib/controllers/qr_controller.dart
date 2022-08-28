import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/screens/payment/payment_confirmation.dart';
import 'package:project_pp/utils/util_functions.dart';
import 'package:http/http.dart' as http;

class QRController extends GetxController {
  var scannedQRCode = '';
  Map voucherData = {};
  String? uid;
  List paymentHistory = [];

  @override
  void onReady() {
    super.onReady();
    voucherData = {};
    uid = Get.find<GlobalController>().uid;
    print('printing uid $uid for current user in onReadyQR');
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
          confirmTextColor: Colors.white,
          confirm: Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 25),
              child: InkWell(
                onTap: () async {
                  closeCustomDialog();
                  await Future.delayed(const Duration(seconds: 1));
                  showCustomDialog('Processing request');
                  await initiatePayment(context, scannedQRCode);
                  return;
                },
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                ),
              )),
          cancel: Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 25),
              child: InkWell(
                onTap: () => Get.back(),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black45, fontSize: 18),
                ),
              )),
        );
      }
    } catch (e) {
      closeCustomDialog();
      print(e);
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    }
  }

  Future<void> initiatePayment(context, code) async {
    try {
      final url =
          Uri.parse('${dotenv.env['db_url']}/payment/initiate?code=${code}');
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": uid!});
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
      return Get.to(() => const PaymentConfirmation(),
          arguments: [voucherData]);
      // ignore: empty_catches
      return;
    } catch (e) {
      print(e);
      voucherData = {};
      showSnackBar('Error', 'Unable to fetch organizations');
      return;
    }
  }

  Future<void> verifyPayment(context, signature) async {
    showCustomDialog('Processing Payment');
    try {
      final url = Uri.parse('${dotenv.env['db_url']}/payment/verify');
      final res = await http.post(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": uid!},
          body: {"signature": "$signature"});
      final resData = jsonDecode(res.body);
      print('data for voucher verify payment $resData');
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
      closeCustomDialog();
      await CoolAlert.show(
        animType: CoolAlertAnimType.slideInUp,
        backgroundColor: Colors.blueAccent,
        context: context,
        type: CoolAlertType.success,
        title: 'Success',
        text: 'Your fees has been paid successfully.',
        loopAnimation: false,
      );
      return;
    } catch (e) {
      print(e);
      voucherData = {};
      showSnackBar('Error', 'Unable to fetch organizations');
      return;
    }
  }

  Future<void> getPaymentHistory() async {
    try {
      final url = Uri.parse('${dotenv.env['db_url']}/payment/history');
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": uid!});
      final resData = jsonDecode(res.body);
      print('data for payment history $resData');
      if (resData['status'] != 200 && resData['errors'] != null) {
        return;
      }
      paymentHistory = resData['success']['data']["payment_history"];
      return;

    } catch (e) {
      print(e);
      voucherData = {};
      showSnackBar('Error', 'Unable to fetch organizations');
      return;
    }
  }
}
