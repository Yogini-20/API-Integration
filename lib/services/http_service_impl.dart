import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constant/url_constant.dart';
import 'http_service.dart';

class HttpServiceImpl implements HttpService{
late Dio _dio;

@override
  void init(){
_dio = Dio(BaseOptions(baseUrl: ConstantURL.baseUrl));
}


  @override
  Future<Response> signupRequest(String organizationName,String name, String phone,String email,String password) async{
    Response response;
    try{
      if (kDebugMode) {
        print(ConstantURL.baseUrl+ConstantURL.signup+'orgName=$organizationName&name=$name&phoneNumber=$phone&emailId=$email&password=$password');
      }
      response = await _dio.post(ConstantURL.signup+'orgName=$organizationName&name=$name&phoneNumber=$phone&emailId=$email&password=$password');
    }on DioException catch(e){
      print(e.error);
      throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> loginRequest(String userId, String password) async{
    Response response;
    try{
      print(ConstantURL.baseUrl+ConstantURL.login+'userId=$userId&password=$password');
      response = await _dio.post(ConstantURL.login+'userId=$userId&password=$password');
    }on DioException catch(e){
      print(e.message);
    throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> forgotRequest(String userId, String password) async {
    Response response;
    try{
      print(ConstantURL.baseUrl+ConstantURL.forgot+'userId=$userId&password=$password');
      response = await _dio.post(ConstantURL.forgot+'userId=$userId&password=$password');
    }on DioException catch(e){
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

}