import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/controllers/qr_controller.dart';
import 'package:project_pp/screens/payment/card_payment.dart';
import 'package:project_pp/widgets/custom_text_field.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({Key? key}) : super(key: key);

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  TextEditingController topUpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          body: GetBuilder<GlobalController>(builder: (globalController) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/top_up.gif',
                      height: Get.height * 0.25,
                      width: Get.width * 0.6,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Text(
                    'Current Balance:',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white
                    ),
                    child: Text(
                      ' ${globalController.userAccountData['balance']}/-',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    label: 'TopUp',
                    controller: topUpController,
                    prefixText: 'Rs.',
                    prefixIcon: Icon(Icons.add_card),
                    hintText: 'Enter wallet amount',
                    inputType: TextInputType.number,
                  ),
                  GestureDetector(
                    onTap: () async{
                      await Get.find<QRController>().performTopUp(context, topUpController.text);
                      setState(() {

                      });
                    },
                    child: creditCard('assets/visa-master.png', 80.0),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async{
                      await Get.find<QRController>().performTopUp(context, topUpController.text);
                      setState(() {

                      });
                    },
                    child: creditCard('assets/nayapay-sadapay.jpg', 50.0),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Get.find<QRController>().payWithEasyPaisa(context, topUpController.text);
                      setState(() {

                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 50.0),
                      width: Get.width * 0.8,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(
                        'assets/easypaisa.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  )
                ],
              ),
            );
          }),
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
