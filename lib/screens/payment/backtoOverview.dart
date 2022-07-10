import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/screens/overview_screen/overview_screen.dart';

class BackToOverView extends StatefulWidget {
  const BackToOverView({Key? key}) : super(key: key);

  @override
  State<BackToOverView> createState() => _BackToOverViewState();
}

class _BackToOverViewState extends State<BackToOverView> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Get.off(() => OverView()));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
