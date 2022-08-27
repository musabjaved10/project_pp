import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  void initState(){
    super.initState();
    ()async{

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
        body: isLoading ? Center(
          child: SpinKitPulse(
            color: Colors.white,
            size: 65.0,
          ),
        ),
      ),
    );
  }
}
