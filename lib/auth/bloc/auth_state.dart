part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class LoadingState extends AuthState {}

class AuthSendSuccess extends AuthState {}

class AuthVerificationSuccess extends AuthState {}

class ErrorState extends AuthState {
  final String message;

  const ErrorState({required this.message});

  @override
  List<Object> get props => [message];
}