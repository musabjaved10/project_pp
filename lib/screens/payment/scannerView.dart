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
      body: SizedBox(
        child: Column(
          children: [Expanded(
              child: Column(
                children: [
                  Text('Scanner')
                ],
              )
          )
          ],
        ),
      ),
    );
  }
}
