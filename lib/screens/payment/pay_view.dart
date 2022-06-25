import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayView extends StatefulWidget {
  const PayView({Key? key}) : super(key: key);

  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  @override
  Widget build(BuildContext context) {
    print('pay built');
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.1,),
            Expanded(
              child: Column(
                children: [
                  Center(child: Text('Pay', style: TextStyle(color: Colors.red),))
                ],
              )
          )
          ],
        ),
      ),
    );
  }
}
