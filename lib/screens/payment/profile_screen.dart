import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:project_pp/controllers/global_controller.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final controller = Get.find<GlobalController>();

  @override
  void initState() {
    super.initState();
    print('hello');
    print(controller.userData['student']['user']['last_name']);
    print(controller.userData['profile_picture']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'assets/point-2.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 10,
                  blurRadius: 5,
                  offset: const Offset(0, 7), // changes position of shadow
                ),
              ],
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: Get.height * 0.085,
                              child: ClipRRect(
                                child: Image.network(
                                    '${dotenv.env['media_url']}${controller.userData['student']['profile_picture']}'),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 70,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    width: 60,
                                    imageUrl: '${dotenv.env['media_url']}${controller.userData['student']['id_card_front_pic']}',
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.blueAccent,)),
                                    errorWidget: (context, url, error) => SizedBox(child: Image.asset('assets/id-card-front.png')),
                                  )
                                  // Image.network('${dotenv.env['media_url']}${controller.userData['student']['id_card_front_pic']}', fit: BoxFit.fill,),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  height: 60,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    width: 60,
                                    imageUrl: '${dotenv.env['media_url']}${controller.userData['student']['id_card_back_pic']}',
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.blueAccent,)),
                                    errorWidget: (context, url, error) => SizedBox(child: Image.asset('assets/id-card-back.jpg')),
                                  )

                                  // Image.network('${dotenv.env['media_url']}${controller.userData['student']['id_card_back_pic']}', fit: BoxFit.fill,),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(
                          '${controller.userData['student']['user']['first_name']} ${controller.userData['student']['user']['last_name']}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${controller.userData['student']['status'].toUpperCase()}',
                          style: const TextStyle(
                              color: Colors.lightGreenAccent,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: Get.width * 0.08),
                            children: [
                              TextField(
                                myController: controller.firstNameController,
                                labelText: 'First Name',
                                initialValue: controller.userData['student']['user']['first_name'],
                              ),
                              TextField(
                                myController: controller.lastNameController,
                                labelText: 'Last Name',
                                initialValue: controller.userData['student']['user']['last_name'],
                              ),
                              TextField(
                                myController: controller.emailController,
                                labelText: 'Email',
                                initialValue: controller.userData['student']['user']['email'],
                                readOnly: true,
                              ),
                              TextField(
                                myController: controller.phoneController,
                                labelText: 'Phone',
                                initialValue: controller.userData['student']['phone'],
                                readOnly: true,
                              ),
                              TextField(
                                myController: controller.phoneController,
                                labelText: 'Roll No.',
                                initialValue: controller.userData['student']['roll_no'],
                                readOnly: true,
                              ),

                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   width: Get.width * 0.4,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10.0),
                  //     color: Colors.white,
                  //   ),
                  //   child: TextButton(
                  //     onPressed: () {},
                  //     child: Text('Update Profile'),
                  //   ),
                  // ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class TextField extends GetWidget<GlobalController> {
  final myController;
  final labelText;
  final initialValue;
  final bool readOnly;

  const TextField(
      {Key? key,
        required this.myController,
        required this.labelText,
        required this.initialValue,
        this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: Colors.white),
      child: TextFormField(
        readOnly: readOnly,
        onChanged: (value) => myController.text = value,
        initialValue: initialValue,
        decoration: InputDecoration(
          label: Text('$labelText'),
        ),
      ),
    );
  }
}
