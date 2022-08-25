import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/components/rounded_button.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/screens/overview_screen/overview_screen.dart';
import 'package:project_pp/screens/registration/register_one.dart';
import 'package:project_pp/widgets/custom_text_field.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegisterTwo extends StatefulWidget {
  static const routeName = '/register-twp';

  const RegisterTwo({Key? key}) : super(key: key);

  @override
  State<RegisterTwo> createState() => _RegisterTwoState();
}

class _RegisterTwoState extends State<RegisterTwo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF66a6ff), Color(0xFF89f7fe)],
        ),
      ),
      child: GetBuilder<GlobalController>(builder: (globalController) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: Get.height * 0.1,
                ),
                GestureDetector(
                  onTap: () { globalController.pickImage();},
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: globalController.proImg == null
                                ? AssetImage("assets/images/pic-upload.png")
                                : FileImage(globalController.proImg!,) as ImageProvider
                      )
                    ),
                  ),
                //   CircleAvatar(
                //     radius: 55.0,
                //     backgroundImage: globalController.proImg == null
                //         ? AssetImage("assets/images/pic-upload.png")
                //         : Image.file(globalController.proImg!) as ImageProvider,
                //     backgroundColor: Color(0xFFf5f7fa),
                //   ),
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                //Form input fields
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CustomTextField(
                            hasIcon: true,
                            isPassObscure: true,
                            label: 'Password',
                            prefixIcon: Icon(Icons.password),
                            controller: globalController.passController!),
                        CustomTextField(
                            hasIcon: true,
                            isPassObscure: true,
                            label: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock),
                            controller:
                                globalController.confirmPassController!),
                        CustomTextField(
                            label: 'Department',
                            prefixIcon: Icon(Icons.account_balance),
                            controller: globalController.departmentController!),
                        CustomTextField(
                            label: 'Roll no.',
                            prefixIcon: Icon(Icons.format_list_numbered),
                            controller: globalController.rollNumController!),
                        SizedBox(
                          height: size.width * 0.1,
                        ),
                        RoundedButton(
                          text: 'Submit',
                          press: () {
                            Get.to(() => OverView(),
                                transition: Transition.rightToLeftWithFade,
                                duration: Duration(milliseconds: 600));
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.white,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(18.0)),
                //     padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                //   ),
                //   onPressed: () {},
                //   child: GradientText(
                //     'Proceed',
                //     style: TextStyle(
                //       fontSize: 20.0,
                //     ),
                //     gradientType: GradientType.radial,
                //     radius: 2.5,
                //     colors: [gradientBlueStart, gradientBlueEnd],
                //   ),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
