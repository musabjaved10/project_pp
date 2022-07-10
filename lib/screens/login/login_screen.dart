import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/components/rounded_button.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/models/constants.dart';
import 'package:project_pp/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      child: GetBuilder<GlobalController>(
          init: GlobalController(),
          builder: (globalController) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Column(
                children: <Widget>[
                  Container(
                    height: Get.height * 0.30,
                    margin: const EdgeInsets.only(top: 0),
                    padding: const EdgeInsets.only(
                        left: defaultPadding, right: defaultPadding),
                    decoration: const BoxDecoration(
                        color: Color(0xFFf5f7fa),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80))),
                    child: const Center(
                      child: CircleAvatar(
                        radius: 65.0,
                        backgroundImage: AssetImage("assets/images/PointPay.png"),
                        backgroundColor: Color(0xFFf5f7fa),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                  ),
                  //Form input fields
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          CustomTextField(
                            label: 'Email',
                            controller: TextEditingController(),
                            prefixIcon: Icon(Icons.email),
                          ),
                          SizedBox(
                            height: Get.height * 0.1,
                          ),
                          Container(
                              margin: const EdgeInsets.only(bottom: 0),
                              child: RoundedButton(
                                text: 'Proceed',
                                press: () {
                                  //login
                                },
                              )),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            );
          }
      ),
    );
  }
}
