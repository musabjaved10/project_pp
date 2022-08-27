import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  final Rxn<User> _user = Rxn<User>();
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

  TextEditingController? emailController,
      passController,
      confirmPassController,
      rollNumController,
      firstNameController,
      orgController,
      lastNameController;

  @override
  void onReady() {
    super.onReady();
    if (_auth.currentUser != null) {
      getUserData();
    }
    getAllOrganizations();
    _user.bindStream(_auth.authStateChanges());
    ever(_user, (callback) => () async{
      if (user == null) {
        Get.offAll(() => LoginScreen());
      } else {
        getUserData();
        Get.offAll(() => OverView());
      }
    });
    emailController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
    rollNumController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    orgController = TextEditingController();
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

  Future getUserStats() async {
    // print('getUserStats() called');
    try {
      final userId = _auth.currentUser?.uid;
      final url = Uri.parse('${dotenv.env['db_url']}/user/$userId?stats=true');
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": "$userId"});
      final data = jsonDecode(res.body);
      // print('getUserStats() response $data');
      if (data['status'] != 200 && data['errors'] != null) {
        showSnackBar('Error', data['errors'].values.first);
        return;
      }
      update();
      // ignore: empty_catches
    } catch (e) {}
  }

  Future signUpWithEmailAndPassword(
      String email,
      String password,
      confirmPassword,
      String first_name,
      String last_name,
      String phone,
      organization,
      File image) async {
    isLoading.value = true;
    showCustomDialog('Signing Up...');
    UserCredential? credential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((u) async {

      Map<String, String> userDataForApi = {
        'first_name': first_name,
        'last_name': last_name,
        'phone': phone,
        'email': email,
        'organization_id': organization
      };

      try {
        final url = Uri.parse('${dotenv.env['db_url']}/user/${u.user!.uid}');
        final res = await http.post(url,
            headers: {
              'api-key': '${dotenv.env['api_key']}',
              'Content-Type': 'application/json'
            },
            body: jsonEncode(userDataForApi));
        final resData = jsonDecode(res.body);

        if (resData['status'] == 200) {
          await getUserData();
          await getUserStats();
          isLoading.value = false;
          closeCustomDialog();
        } else if ((resData['status'] != 200) && (resData['errors'] != null)) {
          closeCustomDialog();
          isLoading.value = false;
          showSnackBar('Error', '${resData['errors'].values.first}');
          _auth.currentUser!.delete();
          await signOut();
        }
      } catch (e) {
        closeCustomDialog();
        FirebaseAuth.instance.currentUser!.delete();
        Get.snackbar('Error', 'Error',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
      } finally {
        isLoading.value = false;
      }
    }).catchError((onError) {
      closeCustomDialog();
      showSnackBar('Error', onError.message);
    });
  }

  Future signOut() async {
    await showCustomDialog('Signing Out...');
    userData = {};
    firstNameController?.clear();
    emailController?.clear();
    passController?.clear();
    await _auth.signOut();
  }

  void pickImage() async {
    print("IMAGE PICKED SUCCESSFULLY");
    profileImgTemp = await ImagePicker().pickImage(source: ImageSource.gallery);
    print('image type is');
    print(Uri.parse(profileImgTemp!.path));
    if (profileImgTemp == null) return;
    final img = File(profileImgTemp!.path);
    proImg = img;
    var postUri = Uri.parse('${dotenv.env['db_url']}/student/4WhTzlx2aHUIoqt28m3jl4evu9L2');
    var request = http.MultipartRequest("POST", postUri);
    Map<String, String> userDataForApi = {
      'first_name': 'Musab',
      'last_name': 'Javed',
      'phone': '+923333231282',
      'email': 'musab@example.com',
      'organization_id': "1",
      "roll_no": "CS-18041",
      "password": "password"
    };
    Map<String, String> headers = {"api-key": "${dotenv.env['api_key']}"};
    request.headers.addAll(headers);
    request.fields.addAll(userDataForApi);
    request.files.add( await http.MultipartFile.fromPath(
        'profile_picture', profileImgTemp!.path,
        contentType: MediaType('image', 'jpeg')));

    request.files.add( await http.MultipartFile.fromPath(
        'id_card_front_pic', profileImgTemp!.path,
        contentType: MediaType('image', 'jpeg')));request.files.add( await http.MultipartFile.fromPath(
        'id_card_back_pic', profileImgTemp!.path,
        contentType: MediaType('image', 'jpeg')));

    // request.files.add( http.MultipartFile.fromBytes(
    //     'profile_picture', await File.fromUri(Uri.parse(profileImgTemp!.path)).readAsBytes(),
    //     contentType: MediaType('image', 'jpeg')));

    request.send().then((response) async{
      print('printing responbse for image');
      print(response.headers);
      print(response.stream);
      print(response.statusCode);
      print(response.request);
      if (response.statusCode == 200) print("Uploaded!");
      var res = await response.stream.bytesToString();
      print(res);
    });
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

  convertImage() async {
    var postUri = Uri.parse('${dotenv.env['db_url']}/student/4WhTzlx2aHUIoqt28m3jl4evu9L2');
    var request = http.MultipartRequest("POST", postUri);
    Map<String, String> userDataForApi = {
      'first_name': 'Musab',
      'last_name': 'Javed',
      'phone': '+923333231282',
      'email': 'musab@example.com',
      'organization_id': "1",
      "roll_no": "CS-18041"
    };
    Map<String, String> headers = {"api-key": "${dotenv.env['api_key']}"};
    request.headers.addAll(headers);
    request.fields.addAll(userDataForApi);
    request.files.add( http.MultipartFile.fromBytes(
        'profile_picture', await File.fromUri(Uri.parse(profileImgTemp!.path)).readAsBytes(),
        contentType: MediaType('image', 'jpeg')));

    request.send().then((response) {
      print('printing responbse for image');
      print(response);
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child("4WhTzlx2aHUIoqt28m3jl4evu9L2");

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask.catchError(((e) {
      print("Error in snapshot upload task ${e.message}");
    }));

    String imageDwnUrl = await snapshot.ref.getDownloadURL().catchError((e) {
      print("Error in snapshot getImageURL task ${e.message}");
    });
    print('Profile pick updated to firebase successfully!');
    print('url is $imageDwnUrl');
    return imageDwnUrl;
  }

  getUserData() async {
    isLoading.value = true;
    // print('getUserData() called');
    try {
      final userId = _auth.currentUser?.uid;
      final url = Uri.parse('${dotenv.env['db_url']}/user/$userId');
      final res = await http.get(url,
          headers: {"api-key": "${dotenv.env['api_key']}", "uid": "$userId"});
      final data = jsonDecode(res.body);
      // print('res for getUserData() $data');
      if (data['status'] != 200 && data['errors'] != null) {
        // _auth.currentUser!.delete();
        // await signOut();
        showSnackBar('Error', data['errors'].values.first);
      }
      userData = data['success']['data'];
      // phoneController.text = userData['phone'] ?? '';
      isLoading.value = false;
      update();
      return;
    } catch (e) {
      isLoading.value = false;
    }

    getUserAccountData() async {
      isLoading.value = true;
      // print('getUserData() called');
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
        userAccountData = data['success']['account'];
        // phoneController.text = userData['phone'] ?? '';
        isLoading.value = false;
        update();
        return;
      } catch (e) {
        isLoading.value = false;
      }
    }
  }
}
