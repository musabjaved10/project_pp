import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/components/rounded_button.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/utils/util_functions.dart';
import 'package:project_pp/widgets/custom_text_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
      super.initState();
      ()async{
        showCustomDialog('Please wait');
        await Future.delayed(Duration(seconds: 2));
        closeCustomDialog();
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
      child: GetBuilder<GlobalController>(
          init: GlobalController(),
          builder: (globalController) {
            return Scaffold(
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
                            controller: globalController.emailController!,
                            prefixIcon: Icon(Icons.email),
                          ),
                          CustomTextField(
                            label: 'Password',
                            controller: globalController.passController!,
                            prefixIcon: Icon(Icons.lock_open),
                            hasIcon: true,
                            isPassObscure: true,
                          ),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          RoundedButton(
                            text: 'Login',
                            press: () {
                              globalController.login(globalController.emailController!.text, globalController.passController!.text);
                            },
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: Get.width * 0.8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                ),
                                child: GradientText(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontStyle: FontStyle.italic
                                  ),
                                  gradientType: GradientType.radial,
                                  radius: 2.5,
                                  colors: [gradientBlueStart, gradientBlueEnd],
                                ),
                                onPressed: (){
                                  Get.toNamed('/register-one');
                                },

                              ),
                            ),
                          ),
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
