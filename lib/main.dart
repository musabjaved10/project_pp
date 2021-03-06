import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/controllers/map_controller.dart';
import 'package:project_pp/screens/overview_screen/overview_screen.dart';
import 'package:project_pp/screens/registration/register_one.dart';
import 'package:flutter/services.dart';
import 'package:project_pp/screens/registration/register_two.dart';
import 'package:project_pp/screens/tracking/map_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Point Pay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:  '/register-one',
      getPages: [
        GetPage(name: '/register-one', page: ()=> RegisterOne()),
        GetPage(name: '/register-two', page: ()=> RegisterTwo()),
        GetPage(name: '/overview', page: ()=> OverView()),
      ],
    );
  }
}

