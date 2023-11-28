import 'package:api_integration/features/signup/signUp_controller.dart';
import 'package:get/get.dart';


import '../../constant/repository/signup/signup_repo_impl.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupRepoImpl());
    Get.put(SignupController());
  }

}