import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get/get.dart';
import 'package:project_pp/controllers/qr_controller.dart';

class PayView extends StatefulWidget {
  const PayView({Key? key}) : super(key: key);

  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  bool isLoading = true;
  final qrController = Get.find<QRController>();

  @override
  void initState() {
    super.initState();
    () async {
      await qrController.getPaymentHistory();
      setState(() {
        isLoading = false;
      });
    }();
  }

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
        body: isLoading
            ? const Center(
                child: SpinKitPulse(
                  color: Colors.white,
                  size: 65.0,
                ),
              )
            : qrController.paymentHistory.isEmpty
                ? const Center(
                    child: Text('You don\'t have any trnsaction history'),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.08,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/payment-history.jpg',
                            fit: BoxFit.fill,
                            height: Get.height * 0.25,
                            width: Get.width * 0.9,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              itemCount: qrController.paymentHistory.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: qrController.paymentHistory[index]
                                            ['is_debit']
                                        ? ListTile(
                                            title: const Text(
                                              'Debit Transaction',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            minLeadingWidth: 0,
                                            isThreeLine: true,
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                      text: 'Source: ',
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                '${qrController.paymentHistory[index]['source']}',
                                                            style: const TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic))
                                                      ]),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                RichText(
                                                  text: const TextSpan(
                                                      text: 'Time: ',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                '  28 August, 2022',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 12))
                                                      ]),
                                                )
                                              ],
                                            ),
                                            leading: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.arrow_circle_down,
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '-${qrController.paymentHistory[index]['amount']}/-',
                                                  style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    if (qrController.paymentHistory[
                                                                index][
                                                            'fee_submission'] ==
                                                        null) {
                                                      return;
                                                    }
                                                    await FlutterWindowManager
                                                        .addFlags(
                                                            FlutterWindowManager
                                                                .FLAG_SECURE);
                                                    Get.bottomSheet(
                                                      Container(
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          50),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          50))),
                                                          height:
                                                              Get.height * 0.6,
                                                          child: Stack(
                                                            children: [
                                                              Positioned(
                                                                top: 15,
                                                                left: 15,
                                                                right: 15,
                                                                child: Image
                                                                    .network(
                                                                  '${dotenv.env['media_url']}${qrController.paymentHistory[index]['fee_submission']['card']}',
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 60,
                                                                left:
                                                                    Get.width *
                                                                        0.6,
                                                                child:
                                                                    SpinKitDoubleBounce(
                                                                  color: Colors
                                                                      .lightGreenAccent,
                                                                  size: 35.0,
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'View Point Card >',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListTile(
                                            title: const Text(
                                              'Credit Transaction',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            minLeadingWidth: 0,
                                            isThreeLine: true,
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                      text: 'Source: ',
                                                      style: const TextStyle(
                                                          color: Colors.grey),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                '${qrController.paymentHistory[index]['source']}',
                                                            style: const TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic))
                                                      ]),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                RichText(
                                                  text: const TextSpan(
                                                      text: 'Time: ',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                '  28 August, 2022',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 12))
                                                      ]),
                                                )
                                              ],
                                            ),
                                            leading: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.arrow_circle_up,
                                                  color: Colors.green,
                                                ),
                                              ],
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '+${qrController.paymentHistory[index]['amount']}/-',
                                                  style: const TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ));
                              }),
                        ),
                        SizedBox(height: Get.height * 0.08,)
                      ],
                    ),
                  ),
      ),
    );
  }
}
