import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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

  Future<void> scanQR(context, String code) async {
    try {
      scannedQRCode = code;
      print('scanned code is ${scannedQRCode}');
      // print("printing scanned code: ${scannedQRCode.value}");
      if (scannedQRCode.isNotEmpty) {
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
                  closeCustomDialog();
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
                onTap: () {
                  closeCustomDialog();
                  Get.back();
                },
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

  Future performTopUp(context, String amount) async {
    if (amount.isEmpty ||
        amount.contains('-') ||
        amount.contains('.') ||
        amount.contains(',') ||
        amount.contains(' ')) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid amount"),
        duration: Duration(milliseconds: 500),
      ));
      return;
    }
    showCustomDialog('Processing Request');
    var paymentIntentData;
    try {
      final url =
          Uri.parse('${dotenv.env['db_url']}/payment/topup?amount=$amount');
      final res = await http.get(url,
          headers: {"uid": uid!, "api-key": "${dotenv.env['api_key']}"});
      final resData = jsonDecode(res.body);
      print('resData for initiate topup ${resData}');
      if (resData['status'] == 200) {
        paymentIntentData = resData['success']['data']['payment_sheet'];
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['paymentIntent'],
          customerId: paymentIntentData['customer'],
          customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
          merchantDisplayName: 'PointPay-NEDUET',
        ));
        closeCustomDialog();
        await Stripe.instance.presentPaymentSheet();
        showCustomDialog('Updating Wallet');

        final response = await http
            .post(Uri.parse('${dotenv.env['db_url']}/payment/topup'), headers: {
          "uid": uid!,
          "api-key": "${dotenv.env['api_key']}",
        }, body: {
          'paymentIntent': paymentIntentData['paymentIntent'],
          'ephemeralKey': paymentIntentData['ephemeralKey'],
        });
        final feedback = jsonDecode(response.body);
        print('resData for initiate topup ${feedback}');

        if (feedback['status'] == 200) {
          closeCustomDialog();
          Get.find<GlobalController>().getAccountData();
          await CoolAlert.show(
            animType: CoolAlertAnimType.slideInUp,
            backgroundColor: Colors.blueAccent,
            context: context,
            type: CoolAlertType.success,
            title: 'Success',
            text: 'Your wallet has been topped up!',
            loopAnimation: false,
          );
        }
      } else if ((resData['status'] != 200) && (resData['errors'] != null)) {
        closeCustomDialog();
        await CoolAlert.show(
          animType: CoolAlertAnimType.slideInUp,
          backgroundColor: Colors.blueAccent,
          context: context,
          type: CoolAlertType.error,
          title: 'Error',
          text: '${resData['errors'].values.first}',
          loopAnimation: false,
        );
      }
    } on StripeException catch (e) {
      closeCustomDialog();
      // final failedResponse = await http.post(Uri.parse('${dotenv.env['db_url']}/payment'), headers: {
      //   "uid": "${_authController.getUserId()}",
      //   "api-key" : "${dotenv.env['api_key']}",
      //   "Content-Type" : "application/json"
      // }, body: json.encode({
      //   'paymentIntent': paymentIntentData['paymentIntent'],
      //   'ephemeralKey': paymentIntentData['ephemeralKey'],
      //   'status': "-1",
      // }));
      // // send api pending-0
      showSnackBar('Error', '${e.error.message}', icon: Icon(Icons.error));
    } catch (e) {
      closeCustomDialog();
      print('printing error for api $e');
      showSnackBar('Error', '$e', icon: Icon(Icons.error));
    }
  }

  Future payWithEasyPaisa(context, String amount) async {
    bool isCancel = false;
    if (amount.isEmpty ||
        amount.contains('-') ||
        amount.contains('.') ||
        amount.contains(',') ||
        amount.contains(' ')) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid amount"),
        duration: Duration(milliseconds: 500),
      ));
      return;
    }
    await Get.defaultDialog(
      title: 'Are you sure',
      // middleText: "You are about to make a payment of ${amount} from your EasyPaisa Account i.e ${Get
      //     .find<GlobalController>()
      //     .userData['student']['phone'] ?? '+923331234567'}",
      content: RichText(
        text: TextSpan(
          text: 'You are about to make a payment of',
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: ' Rs.${amount}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green, fontSize: 18)),
            TextSpan(
                text: ' from your EasyPaisa Account i.e',
                style: TextStyle(color: Colors.black)),
            TextSpan(
                text:
                    ' ${Get.find<GlobalController>().userData['student']['phone'] ?? '+923331234567'}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16)),
          ],
        ),
      ),

      contentPadding: EdgeInsets.symmetric(horizontal: 12),

      radius: 8,
      confirmTextColor: Colors.white,
      confirm: Container(
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 25),
          child: InkWell(
            onTap: () async {
              closeCustomDialog();
            },
            child: Text(
              'Yes I\'m sure',
              style: TextStyle(color: Colors.blueAccent, fontSize: 18),
            ),
          )),
      cancel: Container(
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 25),
          child: InkWell(
            onTap: () {
              isCancel = true;
              closeCustomDialog();
              return;
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black45, fontSize: 18),
            ),
          )),
    );
    if (isCancel) return;
    showCustomDialog('Processing Request');
    var paymentIntentData;
    try {
      final url =
          Uri.parse('${dotenv.env['db_url']}/payment/topup?amount=$amount');
      final res = await http.get(url,
          headers: {"uid": uid!, "api-key": "${dotenv.env['api_key']}"});
      final resData = jsonDecode(res.body);
      print('resData for easypaisa topup ${resData}');
      if (resData['status'] == 200) {
        paymentIntentData = resData['success']['data']['payment_sheet'];
        closeCustomDialog();
        showCustomDialog('Updating Wallet');

        final response = await http
            .post(Uri.parse('${dotenv.env['db_url']}/payment/topup'), headers: {
          "uid": uid!,
          "api-key": "${dotenv.env['api_key']}",
        }, body: {
          'paymentIntent': paymentIntentData['paymentIntent'],
          'ephemeralKey': paymentIntentData['ephemeralKey'],
        });
        final feedback = jsonDecode(response.body);
        print('resData for initiate topup ${feedback}');

        if (feedback['status'] == 200) {
          closeCustomDialog();
          Get.find<GlobalController>().getAccountData();
          await CoolAlert.show(
            animType: CoolAlertAnimType.slideInUp,
            backgroundColor: Colors.blueAccent,
            context: context,
            type: CoolAlertType.success,
            title: 'Success',
            text: 'Your wallet has been topped up!',
            loopAnimation: false,
          );
        }
      } else if ((resData['status'] != 200) && (resData['errors'] != null)) {
        closeCustomDialog();
        await CoolAlert.show(
          animType: CoolAlertAnimType.slideInUp,
          backgroundColor: Colors.blueAccent,
          context: context,
          type: CoolAlertType.error,
          title: 'Error',
          text: '${resData['errors'].values.first}',
          loopAnimation: false,
        );
      }
    } catch (e) {
      closeCustomDialog();
      print('printing error for api $e');
      showSnackBar('Error', '$e', icon: Icon(Icons.error));
    }
  }
}
