import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/bindings/map_binding.dart';
import 'package:project_pp/bindings/payment_binding.dart';
import 'package:project_pp/controllers/map_controller.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/screens/payment/payment_home.dart';
import 'package:project_pp/screens/tracking/map_screen.dart';

class OverView extends StatelessWidget {
  const OverView({Key? key}) : super(key: key);
  static const routeName = '/overview';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [gradientBlueStart, gradientBlueEnd])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: size.width * 0.15,
                ),
                CircleAvatar(
                  radius: 55.0,
                  backgroundImage: AssetImage('assets/images/PointPay.png'),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: size.width * 0.15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: ClipRRect(
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.pin_drop_outlined,
                              color: Colors.red,
                            )),
                        Expanded(
                            flex: 9,
                            child: TextButton(
                              onPressed: () {
                                Get.to(()=> const MapScreen(),transition: Transition.zoom, duration: Duration(milliseconds: 600), binding: MapBinding());
                              },
                              child: const Text('Start Tracking'),
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: ClipRRect(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.account_balance_wallet_outlined,
                              color: Colors.green,
                            )),
                        Expanded(
                            flex: 9,
                            child: TextButton(
                              onPressed: () {
                                Get.to(()=> PaymentHomeScreen(), binding: PaymentBinding());
                              },
                              child: const Text('Payments'),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
