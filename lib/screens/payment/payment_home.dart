import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/controllers/bottom_nav_controller.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


class PaymentHomeScreen extends StatefulWidget {
  const PaymentHomeScreen({Key? key}) : super(key: key);

  @override
  State<PaymentHomeScreen> createState() => _PaymentHomeScreenState();
}

class _PaymentHomeScreenState extends State<PaymentHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavigationController>(
      init: BottomNavigationController(),
      builder: (navController) {
        return Scaffold(
          extendBody: true,
          body: navController.getViewForIndex(navController.currentIndex),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0)
            ),
            child: SalomonBottomBar(
              itemPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              currentIndex: navController.currentIndex,
              onTap: (index) => navController.updateIndex(index),
              items: [
                SalomonBottomBarItem(
                  title: const Text('Payments'),
                  icon: const Icon(Icons.paypal),
                  selectedColor: Colors.blueAccent,
                ),

                /// Likes
                SalomonBottomBarItem(
                  title: const Text('Scanner'),
                  icon: const Icon(Icons.document_scanner),
                  selectedColor: Colors.blueAccent,
                ),

                SalomonBottomBarItem(
                  title: const Text('Account'),
                  icon: const Icon(Icons.person),
                  selectedColor: Colors.blueAccent,
                ),
              ],

            ),
          ),
        );
      }
    );
  }
}
