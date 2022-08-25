import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/components/rounded_button.dart';
import 'package:project_pp/controllers/qr_controller.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
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
        body: GetBuilder<QRController>(
          builder: (controller) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width * 0.8,
                    height: Get.height * 0.25,
                    child: Image.asset('assets/giphy.gif', fit: BoxFit.fitWidth,),
                  ),
                  SizedBox(height: 50,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    width: Get.width * 0.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.document_scanner_outlined),
                        TextButton(child: GradientText('Scan Now', style: TextStyle(fontSize: 22), colors: [gradientBlueEnd, gradientBlueStart], gradientType: GradientType.radial,),
                          onPressed: (){
                            controller.scanQR(context);
                          },
                        ),

                      ],
                    ),

                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
