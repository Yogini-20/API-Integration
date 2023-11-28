
import 'package:api_integration/models/forgot_api_response.dart';

import '../../../models/signup_api_response.dart';

abstract class ForgotRepo{
  Future<ForgotResponse?>forgotAPI(String email,String password);
}