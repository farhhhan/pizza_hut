import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/utils/authRepo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<sentotpEvent>(_sendOtp);
    on<verificationOtpEvent>(_otpverify);
    on<signwithemailandpasswordEvent>(_signWithemail);
    on<SignInevent>(signIn);
  }

  Future<void> _sendOtp(sentotpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(LoadingState());
    try {
      await FirebaseAuthentServices().phoneNumberAuth(
          event.number, event.email, event.name, event.gender, event.context);
      emit(AuthSendSuccess());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
      print(e);
    }
  }

  Future<void> _otpverify(
      verificationOtpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      await Future.delayed(Duration(seconds: 2));
      await FirebaseAuthentServices().checkingOtp(
          event.otp,
          event.name,
          event.gender,
          event.email,
          event.number,
          event.verificationId,
          event.context);
      emit(AuthVerificationSuccess());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
      print(e);
    }
  }

  FutureOr<void> _signWithemail(
      signwithemailandpasswordEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      await Future.delayed(Duration(seconds: 2));
      await FirebaseAuthentServices().registerUser(
          email: event.email,
          gender: event.gender,
          username: event.name,
          phoneNumber: event.number,
          password: event.password,
          context: event.context);
      emit(AuthVerificationSuccess());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
      print(e);
    }
  }

  FutureOr<void> signIn(SignInevent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    try {
      await Future.delayed(Duration(seconds: 2));
      FirebaseAuthentServices()
          .signIn(event.email, event.password, event.context);
      emit(AuthVerificationSuccess());
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
