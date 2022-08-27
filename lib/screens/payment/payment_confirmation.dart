import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:project_pp/components/rounded_button.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/controllers/qr_controller.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/screens/payment/card_payment.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PaymentConfirmation extends StatefulWidget {
  const PaymentConfirmation({Key? key}) : super(key: key);

  @override
  State<PaymentConfirmation> createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  final voucherData = Get.arguments[0];
  final Map months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  @override
  Widget build(BuildContext context) {
    print(voucherData['voucher_payment']['signature']);
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF66a6ff), Color(0xFF89f7fe)],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.08,
                ),
                const Text(
                  'Payment Confirmation',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  width: Get.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 30.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(
                                    "${dotenv.env['media_url']}/${voucherData["voucher_payment"]["from"]["avatar"]}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${voucherData["voucher_payment"]["from"]["name"]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'CIS Department',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    'CS-18041',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                          const Icon(
                            Icons.arrow_right_alt,
                            size: 85,
                            color: Colors.blueAccent,
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 32.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(
                                      "${dotenv.env['media_url']}/${voucherData["voucher_payment"]["to"]["avatar"]}"),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${voucherData["voucher_payment"]["to"]["name"]}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 1.5,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' Amount',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Rs.${voucherData["voucher"]["price"]} '),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' Month',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "${months[voucherData['voucher']['month']]}, ${voucherData['voucher']['year']}"),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ' Your current balance',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${Get.find<GlobalController>().userAccountData['balance']}/-",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                RoundedButton(text: 'Pay now', press: () {
                  Get.find<QRController>().verifyPayment(context, voucherData['voucher_payment']['signature']);
                }),
                // GestureDetector(
                //   onTap: () => Get.to(() => const CardPaymentScreen(),
                //       transition: Transition.zoom),
                //   child: creditCard('assets/visa-master.png', 80.0),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // GestureDetector(
                //   onTap: () => Get.to(() => const CardPaymentScreen(),
                //       transition: Transition.zoom),
                //   child: creditCard('assets/nayapay-sadapay.jpg', 50.0),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // GestureDetector(
                //   onTap: () => Get.to(() => const CardPaymentScreen()),
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 12, horizontal: 50.0),
                //     width: Get.width * 0.8,
                //     height: 55,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Image.asset(
                //       'assets/easypaisa.jpg',
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ));
  }

  Container creditCard(image, width) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      width: Get.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Pay with:',
            style: const TextStyle(
                fontSize: 22,
                color: Colors.blueAccent,
                fontStyle: FontStyle.italic),
          ),
          Image.asset(
            image,
            width: width,
          )
        ],
      ),
    );
  }
}
