
import 'dart:convert';

import 'package:api_integration/constant/repository/signup/signup_repo.dart';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../models/signup_api_response.dart';
import '../../../services/http_service.dart';
import '../../../services/http_service_impl.dart';

class SignupRepoImpl implements SignupRepo{
  late HttpService _httpService;

  SignupRepoImpl(){
    _httpService = Get.put(HttpServiceImpl());
    _httpService.init();
  }

  @override
  Future<SignUpResponse?> signupAPI(String organizationName,String name, String phone,String email,String password) async{
    try {
      final response = await _httpService.signupRequest(organizationName, name,  phone, email, password);
      Map<String, dynamic>responseMap = Map.from(jsonDecode(response.toString()));
      return SignUpResponse.fromJson(responseMap);
    }
  on DioException catch(e){
      if (kDebugMode) {
        print(e.error);
      }
  }
  return null;
  }
}