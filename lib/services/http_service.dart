
import 'package:dio/dio.dart';

abstract class HttpService {
  void init();
  Future<Response>signupRequest(String organizationName,String name, String phone,String email,String password);
  Future<Response> loginRequest(String userId,String password);
  Future<Response> forgotRequest(String userId,String password);
}
