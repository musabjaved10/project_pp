import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_pp/controllers/global_controller.dart';
import 'package:project_pp/screens/payment/profile_screen.dart';
import 'package:project_pp/screens/payment/topup_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  void initState(){
    super.initState();
    Get.find<GlobalController>().getAccountData();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF66a6ff), Color(0xFF89f7fe)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<GlobalController>(
          builder: (globalController) {
            return SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      height: Get.height * 0.25,
                      width: Get.width * 0.95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.blue,
                          Colors.lightGreen,
                        ],
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: SizedBox()),
                          Text(
                            'Hi, ${globalController.userData['student']['user']['first_name']}',
                            style: const TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 25,),
                          Row(
                            children: [
                              const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 30,),
                              const SizedBox(width: 10,),
                              const Text('Balance: ', style: TextStyle(color: Colors.white),),
                              Text('${globalController.userAccountData['balance']}/-',style: const TextStyle(color: Colors.white),)
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: SizedBox(
                        width: Get.width * 0.95,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)
                              ),
                              child: ListTile(
                                onTap: (){
                                  Get.to(() => TopUpScreen());
                                },
                                dense: true,
                                leading: const Icon(Icons.account_balance_wallet_rounded, color: Colors.black,),
                                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18,),
                                title: const Text('Top-up wallet', style: TextStyle(fontSize: 14),),
                                minLeadingWidth: 0,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)
                              ),
                              child: ListTile(
                                onTap: ()=> Get.to(() => ProfileScreen()),
                                dense: true,
                                leading: const Icon(Icons.person, color: Colors.black,),
                                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18,),
                                title: const Text('View Profile', style: TextStyle(fontSize: 14),),
                                minLeadingWidth: 0,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)
                              ),
                              child: ListTile(
                                onTap: (){
                                  globalController.signOut();
                                },
                                dense: true,
                                leading: const Icon(Icons.logout, color: Colors.black,),
                                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18,),
                                title: const Text('Logout', style: TextStyle(fontSize: 14),),
                                minLeadingWidth: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
