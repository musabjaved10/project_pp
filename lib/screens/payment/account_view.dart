import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.1,),
            Expanded(
                child: Column(
                  children: [
                    Center(child: Text('Account', style: TextStyle(color: Colors.red),))
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
