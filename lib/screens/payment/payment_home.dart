import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/controllers/bottom_nav_controller.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';


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
          bottomNavigationBar: DotNavigationBar(
            currentIndex: navController.currentIndex,
            onTap: (index) => navController.updateIndex(index),
            items: [
              DotNavigationBarItem(
                icon: Icon(Icons.home),
                selectedColor: Colors.purple,
              ),

              /// Likes
              DotNavigationBarItem(
                icon: Icon(Icons.document_scanner),
                selectedColor: Colors.blueAccent,
              ),

              DotNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                selectedColor: Colors.blueAccent,
              ),
            ],

          ),
        );
      }
    );
  }
}
