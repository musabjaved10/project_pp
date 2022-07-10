import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/screens/overview_screen/overview_screen.dart';
import 'package:project_pp/screens/payment/account_view.dart';
import 'package:project_pp/screens/payment/backtoOverview.dart';
import 'package:project_pp/screens/payment/pay_view.dart';
import 'package:project_pp/screens/payment/payment_home.dart';
import 'package:project_pp/screens/payment/scannerView.dart';
import 'package:project_pp/screens/tracking/map_screen.dart';

class BottomNavigationController extends GetxController {
  int currentIndex = 1;

  updateIndex(int index) {
    currentIndex = index;
    update();
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const PayView();

      case 1:
        return const ScannerView();

      case 2:
        return const AccountScreen();

      default:
        return const PayView();
    }
  }
}
