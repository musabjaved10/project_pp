

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{
  TextEditingController?
      emailController,
      passController,
      confirmPassController,
      departmentController,
      rollNumController,
      fullNameController;

  @override
  void onInit(){
    super.onInit();
    emailController= TextEditingController();
    passController= TextEditingController();
    confirmPassController= TextEditingController();
    departmentController= TextEditingController();
    rollNumController= TextEditingController();
    fullNameController= TextEditingController();
  }

}