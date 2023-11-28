
import 'package:get/get.dart';
import '../../constant/repository/forgot_password/forgot_repo_impl.dart';
import '../../constant/repository/login/login_repo_impl.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>ForgotRepoImpl());
    Get.lazyPut(()=>LoginRepoImpl());
    Get.put(LoginController());
  }
}