

import '../../../models/signup_api_response.dart';

abstract class SignupRepo{
  Future<SignUpResponse?>signupAPI(String organizationName,String name, String phone,String email,String password);
}