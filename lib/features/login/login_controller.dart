
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/repository/login/login_repo.dart';
import '../../constant/repository/login/login_repo_impl.dart';
import '../../constant/routes.dart';

class LoginController extends GetxController {

  late LoginRepo _loginRepo;

  LoginController(){
_loginRepo = Get.find<LoginRepoImpl>();
  }


  late StreamSubscription subscription;
  RxBool isDeviceConnected = false.obs;
  RxBool isAlertSet = false.obs;
  final key = GlobalKey<FormState>();
  RxBool passToggle = true.obs;
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // final Stream<QuerySnapshot> dataStream =
  //     FirebaseFirestore.instance.collection('data').snapshots();

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected.value =
              await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected.value && isAlertSet.value == false) {
            showDialogBox();
            isAlertSet.value = true;
          }
        },
      );

  checkConnected() async {
    isDeviceConnected.value = await InternetConnectionChecker().hasConnection;
    if (isDeviceConnected.value) {
      return;
    } else {
      showDialogBox();
    }
  }

  @override
  void onInit() {
    getConnectivity();
    super.onInit();
  }

  showDialogBox() {
    Get.defaultDialog(
        title: "No Internet Connection",
        middleText: "Check your Internet Connection");
  }


  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 8) {
      return "Password must be of 8 characters";
    }
    return null;
  }

  login() async {
    String emailId = emailController.text;
    String password = passController.text;
    final response = await _loginRepo.loginAPI(emailId, password);
      if (response?.status == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("Email", emailId);
      prefs.setBool("isLogIn", true);
      Get.snackbar("title", "${response!.message}");
      Get.offAllNamed(RoutesConstant.navigatePage);
    }else{
          Get.snackbar("title", "${response!.message}");
      }
  }

}
