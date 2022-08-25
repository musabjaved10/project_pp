import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/screens/payment/card_payment.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PaymentConfirmation extends StatefulWidget {
  const PaymentConfirmation({Key? key}) : super(key: key);

  @override
  State<PaymentConfirmation> createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
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
                const SizedBox(height: 40,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                          SizedBox(
                            width: Get.width *0.3,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.network(
                                        'https://scontent.fkhi8-1.fna.fbcdn.net/v/t39.30808-6/283932408_3199654210278174_2657023735973614549_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=p2r58t2UCgMAX_8SN2H&_nc_ht=scontent.fkhi8-1.fna&oh=00_AT-O6UM-1ti67kwAjyLRzj91fhVjvfqcNvMQ26jtDuN4rw&oe=630AE24C'),
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Column(
                                  children: const [Text('Musab Javed', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),), Text('CIS Department', style: TextStyle(fontSize: 12),), Text('CS-18041', style: TextStyle(fontSize: 12),)],
                                )
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_right_alt, size: 85, color: Colors.blueAccent,),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 32.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/en/thumb/8/8b/NEDUET_logo.svg/800px-NEDUET_logo.svg.png'),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Column(
                                children: const [Text('NED University \nof Engineering \n& Technology', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 15,),
                      const Divider(thickness: 1.5,color: Colors.black,),
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(' Amount', style: TextStyle(fontWeight: FontWeight.bold),),
                            Text('Rs.1200 '),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                GestureDetector(
                  onTap: () => Get.to( () => const CardPaymentScreen(), transition: Transition.zoom),
                  child: creditCard('assets/visa-master.png', 80.0),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: () => Get.to( () => const CardPaymentScreen(), transition: Transition.zoom),
                  child: creditCard('assets/nayapay-sadapay.jpg', 50.0),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: () => Get.to( () => const CardPaymentScreen()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 50.0),
                    width: Get.width * 0.8,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                     
                    ),
                    child: Image.asset('assets/easypaisa.jpg', fit: BoxFit.fill,),
                  ),
                )
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
                      GradientText('Pay with:',colors: const [gradientBlueEnd,gradientBlueStart], gradientType: GradientType.radial, style: const TextStyle(fontSize: 22),),
                      Image.asset(image,width: width,)
                    ],
                  ),
                );
  }
}
