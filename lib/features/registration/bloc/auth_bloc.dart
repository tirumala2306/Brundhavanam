import 'dart:developer';

import 'package:brundhavanam/features/registration/bloc/auth_event.dart';
import 'package:brundhavanam/features/registration/bloc/auth_states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<SendOtpEvent>(_sendOtp);

    on<VerifyOtpEvent>(_verifyOtp);
  }

  Future<void> _sendOtp(
    SendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final response = await repository.sendOtp(event.mobile);
      log("OTP RESPONSE = ${response.data}");

      if (response.success) {
        emit(OtpSentSuccess());
      } else {
        emit(AuthError(response.error ?? "Failed to send OTP"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _verifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await repository.verifyOtp(event.mobile, event.otp);

      if (response.success) {
        /// SAVE TOKEN

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString("user_token", response.data!.token);

        emit(OtpVerifySuccess(response.data!));
      } else {
        emit(AuthError("Invalid OTP"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
