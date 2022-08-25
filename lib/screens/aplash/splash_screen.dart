import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/screens/login/login_screen.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/screens/overview_screen/overview_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _globalController = Get.find<GlobalController>();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      if(_globalController.user == null){
        Get.offAll(() => const LoginScreen());
      }else{
        Get.offAll(const OverView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: double.infinity,
        decoration:  const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [gradientBlueStart, gradientBlueEnd])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.08,
              ),
              CircleAvatar(
                radius: Get.height * 0.09,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset('assets/images/ned-logo.jpg'),
                ),
              ),
              SizedBox(
                height: Get.height * 0.4,
                width: Get.height * 0.4,
                child: Image.asset(
                  'assets/images/PointPay.png',
                ),
              ),
              const Text(
                'NEDUET - Point Pay',
                style: TextStyle(color:  Color(0xdd003c78), fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Track & pay on the go!',
                style: TextStyle(color: Color(0x88003c78), fontSize: 22, fontStyle: FontStyle.italic),
              ),
              const Spacer(),
              const Text('Powered by:'),
              const Text('National Center for Cyber Security (NCCS)'),
              SizedBox(
                height: Get.height * 0.05,
              )
            ],
          ),
        ),
      ),
    );
  }}
