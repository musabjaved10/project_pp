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
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: Get.height * 0.25,
                  width: Get.width * 0.95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
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
                      Expanded(child: SizedBox()),
                      Text(
                        'Hi, Musab',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 25,),
                      Row(
                        children: [
                          Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 30,),
                          SizedBox(width: 10,),
                          Text('Balance: ', style: TextStyle(color: Colors.white),),
                          Text('Rs. 1500/-',style: TextStyle(color: Colors.white),)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 18),
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
                            onTap: (){},
                            dense: true,
                            leading: Icon(Icons.account_balance_wallet_rounded, color: Colors.black,),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18,),
                            title: Text('Topup wallet', style: TextStyle(fontSize: 14),),
                            minLeadingWidth: 0,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)
                          ),
                          child: ListTile(
                            onTap: (){},
                            dense: true,
                            leading: Icon(Icons.person, color: Colors.black,),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18,),
                            title: Text('View Profile', style: TextStyle(fontSize: 14),),
                            minLeadingWidth: 0,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)
                          ),
                          child: ListTile(
                            onTap: (){},
                            dense: true,
                            leading: Icon(Icons.logout, color: Colors.black,),
                            trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 18,),
                            title: Text('Logout', style: TextStyle(fontSize: 14),),
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
        ),
      ),
    );
  }
}
