
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constant/repository/forgot_password/forgot_repo.dart';
import '../../constant/repository/forgot_password/forgot_repo_impl.dart';

class UpdateController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UpdateController(){
    _forgotRepo = Get.find<ForgotRepoImpl>();
  }
  late ForgotRepo _forgotRepo;


  forgot()async{
    final response = await  _forgotRepo.forgotAPI(emailController.text,passwordController.text);
    print("response ${response!.status!}");
    if (response.status==0) {
      Get.snackbar("Snack bar", "${response.message}",backgroundColor: Colors.green);
    } else if (response.status==1) {
      Get.snackbar("Snack bar", "${response.message}",backgroundColor: Colors.red);
    } else if (response.status==3) {
      Get.snackbar("Snack bar", "${response.message}",backgroundColor: Colors.red);
    }else if (response.status==4) {
      Get.snackbar("Snack bar", "${response.message}",backgroundColor: Colors.red);
    }
  }



  final formKey = GlobalKey<FormState>();
  final resKey = GlobalKey<FormState>();

  var connectionStatus=0.obs;
  final Connectivity connectivity=Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

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
      print(e.toString());
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
      return;
    }else{
      Get.snackbar("No internet Connection", "Check your Internet Connection");
    }
  }
}