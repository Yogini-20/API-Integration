import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../models/login_api_response.dart';
import '../../../services/http_service.dart';
import '../../../services/http_service_impl.dart';
import 'login_repo.dart';

class LoginRepoImpl implements LoginRepo{
  late HttpService _httpService;

  LoginRepoImpl(){
    _httpService = Get.put(HttpServiceImpl());
    _httpService.init();
  }


  @override
  Future<LoginResponse?> loginAPI(String userId, String password) async{
    try{
      final response = await _httpService.loginRequest(userId,password);
      Map<String, dynamic>responseMap = Map.from(jsonDecode(response.toString()));
      return LoginResponse.fromJson(responseMap);
    }on DioException catch(e){
      if (kDebugMode) {
        print(e.message);
      }
    }
    return null;
  }
}
