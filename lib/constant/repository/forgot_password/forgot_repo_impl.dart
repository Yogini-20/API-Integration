

import 'dart:convert';

import 'package:api_integration/models/forgot_api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../models/signup_api_response.dart';
import '../../../services/http_service.dart';
import '../../../services/http_service_impl.dart';
import 'forgot_repo.dart';

class ForgotRepoImpl implements ForgotRepo{
  late HttpService _httpService;

  ForgotRepoImpl(){
    _httpService = Get.put(HttpServiceImpl());
    _httpService.init();
  }

  @override
  Future<ForgotResponse?> forgotAPI(String email,String password) async{
    try {
      final response = await _httpService.forgotRequest(email, password);
      Map<String, dynamic>responseMap = Map.from(jsonDecode(response.toString()));
      return ForgotResponse.fromJson(responseMap);
    }
    on DioException catch(e){
      if (kDebugMode) {
        print(e.error);
      }
    }
    return null;
  }
}
