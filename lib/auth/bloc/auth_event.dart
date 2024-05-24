part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class sentotpEvent extends AuthEvent {
  final String number;
  final String email;
  final String name;
  final String gender;
  final BuildContext context;

  const sentotpEvent({required this.number,required this.email,required this.name,required this.gender,required this.context});

  @override
  List<Object> get props => [number, email, name, gender, context];
}

class verificationOtpEvent extends AuthEvent {
  final String otp;
  final String name;
  final String gender;
  final String email;
  final String number;
  final String verificationId;
  final BuildContext context;

   verificationOtpEvent({required this.otp,required this.name,required this.gender,required this.email,required this.number,required this.verificationId,required this.context});

  @override
  List<Object> get props => [otp, name, gender, email, number, verificationId, context];
}

class signwithemailandpasswordEvent extends AuthEvent {
  final String name;
  final String gender;
  final String email;
  final String number;
  final BuildContext context;
  final String password;

   signwithemailandpasswordEvent({required this.password,required this.name,required this.gender,required this.email,required this.number,required this.context});

  @override
  List<Object> get props => [ name, gender, email, number, context];
}
class SignInevent extends AuthEvent{
  final String email;
  final String password;
  BuildContext context;
  SignInevent({required this.email,required this.password,required this.context});
  @override
  List<Object> get props => [email,password,context];
}