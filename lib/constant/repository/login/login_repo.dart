
import '../../../models/login_api_response.dart';

abstract class LoginRepo{
  Future<LoginResponse?>loginAPI(String userId,String password);
}
