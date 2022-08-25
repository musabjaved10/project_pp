import 'package:flutter/material.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() press;
  double borderRadius;
  // final Color color, textColor;
  RoundedButton({
    Key? key,
    this.borderRadius = 50,
    required this.text,
    required this.press,
    // this.press,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
      child: GradientText(
        text,
        style: TextStyle(
          fontSize: 20.0,
        ),
        gradientType: GradientType.radial,
        radius: 2.5,
        colors: [gradientBlueStart, gradientBlueEnd],
      ),
      onPressed: press,

    );
  }
}