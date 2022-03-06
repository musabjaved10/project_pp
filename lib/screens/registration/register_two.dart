import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/components/rounded_button.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/screens/overview_screen/overview_screen.dart';
import 'package:project_pp/screens/registration/register_one.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RegisterTwo extends StatelessWidget {
  static const routeName = '/register-twp';

  const RegisterTwo({Key? key}) : super(key: key);

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
                  backgroundImage: AssetImage("assets/images/pic-upload.png"),
                  backgroundColor: Color(0xFFf5f7fa),
                ),
                SizedBox(
                  height: size.width * 0.15,
                ),
                //Form input fields

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(
                    //     color: Colors.lightBlueAccent,
                    //     width: 3.0
                    // )
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(
                    //     color: Colors.lightBlueAccent,
                    //     width: 3.0
                    // )
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(
                    //     color: Colors.lightBlueAccent,
                    //     width: 3.0
                    // )
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Department',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    // border: Border.all(
                    //     color: Colors.lightBlueAccent,
                    //     width: 3.0
                    // )
                  ),
                  child: TextField(
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Roll no.',
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 0),
                    child: RoundedButton(
                      text: 'Submit',
                      press: () {
                        Get.to(() => OverView(),transition: Transition.rightToLeftWithFade, duration: Duration(milliseconds: 600));
                      },
                    )),

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
        ),
      ),
    );
  }
}
