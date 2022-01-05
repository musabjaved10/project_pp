import 'package:flutter/material.dart';
import 'package:project_pp/components/rounded_button.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/screens/registration/register_two.dart';

class RegisterOne extends StatelessWidget {
  const RegisterOne({Key? key}) : super(key: key);
  final String dropdownValue = 'NEDUET';
  static const routeName = '/register-one';

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
          child: Column(
            children: <Widget>[
              Container(
                height: size.height * 0.30,
                margin: EdgeInsets.only(top: 0),
                padding:
                    EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                decoration: BoxDecoration(
                    color: Color(0xFFf5f7fa),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80))),
                child: Center(
                  child: CircleAvatar(
                    radius: 65.0,
                    backgroundImage: AssetImage("assets/images/PointPay.png"),
                    backgroundColor: Color(0xFFf5f7fa),
                  ),
                ),
              ),
              SizedBox(height: size.height* 0.1,),
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
                    labelText: 'Name',
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
                    labelText: 'Email',
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
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      labelText: 'Select Your University',
                      border: InputBorder.none
                  ),

                  value: dropdownValue,
                  icon: const Icon(Icons.school),
                  elevation: 16,
                  style: const TextStyle(color: Colors.lightBlueAccent),
                  // underline: Container(
                  //   height: 2,
                  //   color: Colors.deepPurpleAccent,
                  // ),
                  // onChanged: (String? newValue) {
                  //   setState(() {
                  //     dropdownValue = newValue!;
                  //   });
                  // },
                  items: <String>['NEDUET', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: size.height* 0.07,),
              Container(
                  margin: EdgeInsets.only(bottom: 0),
                  child: RoundedButton(text: 'Proceed', press: (){
                    Navigator.of(context).pushNamed(RegisterTwo.routeName);
                  },)
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
      ),
    );
  }
}
