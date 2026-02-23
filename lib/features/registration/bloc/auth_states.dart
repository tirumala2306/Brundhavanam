import 'package:brundhavanam/features/registration/models/auth_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class OtpSentSuccess extends AuthState {}

class OtpVerifySuccess extends AuthState {
  final AuthModel authModel;

  OtpVerifySuccess(this.authModel);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
