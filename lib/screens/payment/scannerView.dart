import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({Key? key}) : super(key: key);

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.1,),
            Expanded(
                child: Column(
                  children: [
                    Center(child: Text('Scan', style: TextStyle(color: Colors.red),))
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
