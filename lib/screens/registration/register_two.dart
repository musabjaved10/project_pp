import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/components/rounded_button.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/screens/overview_screen/overview_screen.dart';
import 'package:project_pp/screens/registration/register_one.dart';
import 'package:project_pp/utils/util_functions.dart';
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
      decoration: const BoxDecoration(
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
                  height: Get.height * 0.06,
                ),
                GestureDetector(
                  onTap: () {
                    globalController.pickImage();
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: globalController.proImg == null
                                ? const AssetImage(
                                    "assets/images/pic-upload.png")
                                : FileImage(
                                    globalController.proImg!,
                                  ) as ImageProvider)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  globalController.pickCardFront();
                                },
                                child: Container(
                                  height: 80,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: globalController.cardFront ==
                                                  null
                                              ? const AssetImage(
                                                  "assets/id-card-front.png")
                                              : FileImage(
                                                  globalController.cardFront!,
                                                ) as ImageProvider)),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('ID Card-Front')
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  globalController.pickCardBack();
                                },
                                child: Container(
                                  height: 80,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: globalController.cardBack ==
                                                  null
                                              ? const AssetImage(
                                                  "assets/id-card-back.jpg")
                                              : FileImage(
                                                  globalController.cardBack!,
                                                ) as ImageProvider)),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text('ID Card-Back')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: size.width * 0.1,
                ),
                //Form input fields
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CustomTextField(
                            label: 'Mobile No.',
                            hintText: "+923331234567",
                            inputType: TextInputType.phone,
                            prefixIcon: const Icon(Icons.phone_android),
                            controller: globalController.phoneController!),
                        CustomTextField(
                            hasIcon: true,
                            isPassObscure: true,
                            label: 'Password',
                            prefixIcon: const Icon(Icons.password),
                            controller: globalController.passController!),
                        CustomTextField(
                            hasIcon: true,
                            isPassObscure: true,
                            label: 'Confirm Password',
                            prefixIcon: const Icon(Icons.lock),
                            controller:
                                globalController.confirmPassController!),
                        CustomTextField(
                            label: 'Roll no.',
                            hintText: 'Dept-SeatNum (e.g CS-1912345)',
                            prefixIcon: const Icon(Icons.format_list_numbered),
                            controller: globalController.rollNumController!),
                        SizedBox(
                          height: size.width * 0.1,
                        ),
                        RoundedButton(
                          text: 'Submit',
                          press: () {
                            if (globalController.passController!.text.isEmpty ||
                                globalController
                                    .confirmPassController!.text.isEmpty ||
                                globalController
                                    .rollNumController!.text.isEmpty) {
                              return showSnackBar('Details required',
                                  'Please fill all the details',
                                  icon: const Icon(Icons.edit));
                            }
                            if (globalController.passController!.text !=
                                globalController.confirmPassController!.text) {
                              return showSnackBar(
                                  'Error', 'Passwords do not match',
                                  icon: const Icon(Icons.key));
                            }
                            if(globalController.rollNumController!.text.length < 8 || globalController.rollNumController!.text.length > 8){
                              return showSnackBar(
                                  'Roll Number', 'Please enter roll number in correct format',
                                  icon: const Icon(Icons.key));
                            }
                            if (globalController.cardBack == null ||
                                globalController.cardFront == null) {
                              return showSnackBar('ID Card',
                                  'Please upload ID card image of both sides',
                                  icon: const Icon(Icons.add_card));
                            }
                            if (globalController.proImg == null) {
                              return showSnackBar('Profile Picture',
                                  'Upload profile image by tapping the profile icon',
                                  icon: const Icon(Icons.image));
                            }
                            globalController.signUpWithEmailAndPassword(
                                globalController.emailController!.text,
                                globalController.passController!.text,
                                globalController.confirmPassController!.text,
                                globalController.firstNameController!.text,
                                globalController.lastNameController!.text,
                                globalController.phoneController!.text,
                                globalController.orgController!.text,
                                globalController.rollNumController!.text);
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
