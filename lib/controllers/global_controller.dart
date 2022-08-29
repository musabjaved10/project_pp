import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_pp/screens/login/login_screen.dart';
import 'package:project_pp/screens/overview_screen/overview_screen.dart';
import 'package:project_pp/utils/util_functions.dart';

class GlobalController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  RxBool isLoading = false.obs;
  File? proImg;
  File? cardFront;
  File? cardBack;
  XFile? profileImgTemp;
  XFile? cardBackTmp;
  XFile? cardFrontTmp;
  Map userData = {};
  Map userAccountData = {};

  String? get user => _user.value?.email;
  String? get uid => _auth.currentUser!.uid;

  TextEditingController? emailController,
      passController,
      confirmPassController,
      rollNumController,
      firstNameController,
      orgController,
      phoneController,
      lastNameController;

  @override
  void onReady() async{
    await Future.delayed(Duration(seconds: 4));
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    if (_auth.currentUser != null) {
       getUserData();
       getAccountData();
    }
    getAllOrganizations();
    _user.bindStream(_auth.authStateChanges());
    ever(_user, _setInitialView);
    emailController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    rollNumController = TextEditingController();
    phoneController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    orgController = TextEditingController();
  }

  _setInitialView(User? user) async{
    print('heyy');
    if(user == null){
      Get.offAll(()=> LoginScreen());
    }else{
      await Future.delayed(Duration(seconds: 5));
      closeCustomDialog();
      Get.offAll(() => OverView());
    }
  }

  List organizations = [];

  Future getAllOrganizations() async {
    // print('get orgs() called');
    try {
      final url = Uri.parse('${dotenv.env['db_url']}/organization');
      final res =
          await http.get(url, headers: {"api-key": "${dotenv.env['api_key']}"});
      final data = jsonDecode(res.body);
      print('data for orgs $data');
      // print('getUserStats() response $data');
      if (data['status'] != 200 && data['errors'] != null) {
        showSnackBar('Error', data['errors'].values.first);
        return;
      }
      organizations = data['success']['data']['organization'];
      print(organizations);
      update();
      // ignore: empty_catches
    } catch (e) {
      print(e);
      showSnackBar('Error', 'Unable to fetch organizations');
    }
  }

  //Function to login User
  Future login( String email, String password) async {
    print(email);
    print(password);
    if(email.isEmpty || password.isEmpty){
      return showSnackBar('Required fields are missing', 'Email and Password are required.', icon: Icon(Icons.login, color: Colors.blueAccent,));
    }
      showCustomDialog('Logging in...');
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print('signInWithEmailAndPassword with value: $value');
      }).catchError((onError) {
        closeCustomDialog();
        showSnackBar('Error', onError.message);
      });
  }

  Future signUpWithEmailAndPassword(
      String email,
      String password,
      confirmPassword,
      String first_name,
      String last_name,
      String phone,
      organization,
      rollNum,
      ) async {
    isLoading.value = true;
    showCustomDialog('Signing Up...');
    UserCredential? credential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((u) async {
      try {
        var postUri = Uri.parse('${dotenv.env['db_url']}/student/${_auth.currentUser!.uid}');
        var request = http.MultipartRequest("POST", postUri);
        Map<String, String> userDataForApi = {
          'first_name': first_name,
          'last_name': last_name,
          'phone': phone,
          'email': email,
          'organization_id': organization,
          "roll_no": rollNum,
          "password": password
        };
        Map<String, String> headers = {"api-key": "${dotenv.env['api_key']}"};
        request.headers.addAll(headers);
        request.fields.addAll(userDataForApi);
        request.files.add( await http.MultipartFile.fromPath(
            'profile_picture', profileImgTemp!.path,
            contentType: MediaType('image', 'jpeg')));
        request.files.add( await http.MultipartFile.fromPath(
            'id_card_front_pic', cardFrontTmp!.path,
            contentType: MediaType('image', 'jpeg')));request.files.add( await http.MultipartFile.fromPath(
            'id_card_back_pic', cardBackTmp!.path,
            contentType: MediaType('image', 'jpeg')));

         request.send().then((response) async{
           var res = await response.stream.bytesToString();
           print(jsonDecode(res));
         });
      } catch (e) {
        closeCustomDialog();
        FirebaseAuth.instance.currentUser!.delete();
        Get.snackbar('Error', 'Error',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
      }
    }).catchError((onError) {
      closeCustomDialog();
      showSnackBar('Error', onError.message);
    });
  }

  Future signOut() async {
    await showCustomDialog('Signing Out...');
    userData = {};
    userAccountData = {};
    firstNameController?.clear();
    emailController?.clear();
    passController?.clear();
    confirmPassController?.clear();
    rollNumController?.clear();
    orgController?.clear();
    phoneController?.clear();
    proImg = null;
    cardFront = null;
    cardBack = null;
    await _auth.signOut();
    closeCustomDialog();
  }

  void pickImage() async {
    print("IMAGE PICKED SUCCESSFULLY");
    profileImgTemp = await ImagePicker().pickImage(source: ImageSource.gallery);
    print('image type is');
    print(Uri.parse(profileImgTemp!.path));
    if (profileImgTemp == null) return;
    final img = File(profileImgTemp!.path);
    proImg = img;

    update();
  }

  void pickCardFront() async {
    cardFrontTmp = await ImagePicker().pickImage(source: ImageSource.camera,);
    print(Uri.parse(cardFrontTmp!.path));
    if (cardFrontTmp == null) return;
    cardFront = File(cardFrontTmp!.path);
    update();
  }
  void pickCardBack() async {
    cardBackTmp = await ImagePicker().pickImage(source: ImageSource.camera,);
    print(Uri.parse(cardBackTmp!.path));
    if (cardBackTmp == null) return;
    cardBack = File(cardBackTmp!.path);
    update();
  }
  int count = 5;
  getUserData() async {
    print(count);
    isLoading.value = true;
    print('getUserData() calleddd');
    print('getUserData() ${_auth.currentUser!.email}');
    try {
      final userId = _auth.currentUser?.uid;
      final url = Uri.parse('${dotenv.env['db_url']}/student/$userId');
      await Future.delayed(Duration(seconds: 1));
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": "$userId"});
      final data = jsonDecode(res.body);
      print('res for getUserData() $data');
      if (data['status'] != 200 && data['errors'] != null) {
        if(count != 0 && userData.isEmpty){
          count -=1 ;
          await getUserData();
          return;
        }
        return _auth.signOut();

      }
      userData = data['success']['data'];

      print('user data is $userData');
      // phoneController.text = userData['phone'] ?? '';
      isLoading.value = false;
      update();
      getAccountData();
      return;
    } catch (e) {
      print("error in userdata $e");
      isLoading.value = false;
    }

  }
  getAccountData() async {
    // print('getAccount() called');
    try {
      final userId = _auth.currentUser?.uid;
      final url = Uri.parse('${dotenv.env['db_url']}/account');
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": "$userId"});
      final data = jsonDecode(res.body);
      // print('res for getUserData() $data');
      if (data['status'] != 200 && data['errors'] != null) {
        // _auth.currentUser!.delete();
        // await signOut();
        showSnackBar('Error', data['errors'].values.first);
      }
      userAccountData = data['success']['data']['account'];
      isLoading.value = false;
      update();
      return;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
