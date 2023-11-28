
import 'package:api_integration/features/forgot_password/update_controller.dart';
import 'package:get/get.dart';

import '../../constant/repository/forgot_password/forgot_repo_impl.dart';


class UpdateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ForgotRepoImpl());
    Get.put(UpdateController());
  }

}