
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../constant/repository/signup/signup_repo.dart';
import '../../constant/repository/signup/signup_repo_impl.dart';
import '../../constant/routes.dart';


class SignupController extends GetxController {

  final formKey = GlobalKey<FormState>();
  RxBool passToggle = true.obs;
  var connectionStatus=0.obs;
  final Connectivity connectivity=Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController orgController = TextEditingController();

  late SignupRepo _signupRepo;
  SignupController(){
    _signupRepo = Get.find<SignupRepoImpl>();
    }

  signup()async{
    final response = await  _signupRepo.signupAPI(orgController.text,nameController.text,phoneController.text,emailController.text,passwordController.text);
    print("response ${response!.status!}");
    if (response.status==1) {
      Get.snackbar("Snack bar", "${response.message}",backgroundColor: Colors.green);
    } else if (response.status==2) {
      Get.snackbar("Snack bar", "${response.message}",backgroundColor: Colors.red);
    } else if (response.status==3) {
      Get.snackbar("Snack bar", "${response.message}",backgroundColor: Colors.red);
    }else if (response.status==4) {
      Get.snackbar("Snack bar", "${response.message}",backgroundColor: Colors.red);
    }
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

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    connectivitySubscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try{
      result=await connectivity.checkConnectivity();
    }on PlatformException catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return updateConnectionStatus(result);
  }

  updateConnectionStatus(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.wifi:
        connectionStatus.value=1;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value=2;
        break;
        case ConnectivityResult.none:
        connectionStatus.value=0;
        break;
      default:Get.snackbar("Network Error", "Failed to get network connection");
      break;
    }
  }

  checkConnection(){
    if(connectionStatus.value==1||connectionStatus.value==2){
      Get.offAllNamed(RoutesConstant.loginPage);
    }else{
      Get.snackbar("No internet Connection", "Check your Internet Connection");
    }
  }

  RxBool isTry=false.obs;
  bool isValid(){
    return  isTry.value=formKey.currentState!.validate();
  }
}

