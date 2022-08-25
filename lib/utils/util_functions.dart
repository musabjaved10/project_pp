import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

void showSnackBar(String title, msg, {icon}) {
  Get.snackbar(
    title,
    msg,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.white,
    colorText: Colors.black,
    icon: icon == null && title == 'Success'
        ? const Icon(
      Icons.check_circle,
      color: Colors.blueAccent,
    )
        : icon == null && title == 'Error'
        ? const Icon(
      Icons.dangerous,
      color: Colors.red,
    )
        : icon,
  );
}

showCustomDialog(title) async {
  Get.defaultDialog(
      backgroundColor: Colors.white,
      radius: 8.0,
      titlePadding: const EdgeInsets.all(16.0),
      contentPadding: const EdgeInsets.all(16.0),
      title: '$title',
      titleStyle: const TextStyle(fontSize: 22, color: Colors.black),
      content: const SpinKitFadingCube(
        color: Colors.blueAccent,
        size: 65.0,
      ));
}

closeCustomDialog() {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
  return;
}