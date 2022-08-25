import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/components/rounded_button.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/screens/models/constants.dart';
import 'package:project_pp/screens/registration/register_two.dart';
import 'package:project_pp/widgets/custom_text_field.dart';

class RegisterOne extends StatefulWidget {
  const RegisterOne({Key? key}) : super(key: key);
  static const routeName = '/register-one';

  @override
  State<RegisterOne> createState() => _RegisterOneState();
}

class _RegisterOneState extends State<RegisterOne> {
  String _dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  height: size.height * 0.30,
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
                          label: 'First Name',
                          controller: globalController.firstNameController!,
                          prefixIcon: Icon(Icons.draw),
                        ),
                        CustomTextField(
                          label: 'Last Name',
                          controller: globalController.lastNameController!,
                          prefixIcon: Icon(Icons.draw),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                labelText: 'Select Your University',
                                border: InputBorder.none),
                            icon: const Icon(Icons.school, size: 35,),
                            elevation: 10,
                            borderRadius: BorderRadius.circular(12),
                            items: globalController.organizations.map((item) {
                              return  DropdownMenuItem(
                                value: item['id'].toString(),
                                child: Text(item['abbr'],),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              print(newVal);
                              setState(() {
                                _dropdownValue = newVal.toString();
                              });
                            },
                            value: _dropdownValue.isNotEmpty ? _dropdownValue : null,
                          ),
                        ),
                        CustomTextField(
                          label: 'Email',
                          controller: TextEditingController(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        RoundedButton(
                          text: 'Proceed',
                          press: () {
                            Get.to(() => const RegisterTwo(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 600));
                          },
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
