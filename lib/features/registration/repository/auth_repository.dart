import 'dart:developer';

import 'package:brundhavanam/services/api_services/api_constants.dart';
import 'package:brundhavanam/services/api_services/api_response.dart';
import 'package:brundhavanam/services/api_services/crud_service.dart';
import '../models/auth_model.dart';

class AuthRepository {
  final AppService appService;

  AuthRepository(this.appService);

  /// SEND OTP
  Future<ApiResponse<String>> sendOtp(String mobile) {
    return appService.post<String>(
       "/api/v1/auth/otp/send",
      body: {"mobile": mobile},
      fromJson: (json) {
        log("FULL RESPONSE = $json");
        return json as String;
      },
    );
  }

  /// VERIFY OTP
  Future<ApiResponse<AuthModel>> verifyOtp(String mobile, String otp) {
    return appService.post<AuthModel>(
      ApiConstants.verifyOtp,

      body: {"mobile": mobile, "otp": otp},

      fromJson: (json) => AuthModel.fromJson(json),
    );
  }
}
