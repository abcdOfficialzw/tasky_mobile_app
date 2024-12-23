import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String username;
  final String password;

  const SignInEvent({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class SignupEvent extends AuthEvent {
  final String fullname;
  final String username;
  final String password;
  final String confirmPassword;

  const SignupEvent({
    required this.fullname,
    required this.username,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [fullname, username, password, confirmPassword];
}

class LogoutEvent extends AuthEvent {}
