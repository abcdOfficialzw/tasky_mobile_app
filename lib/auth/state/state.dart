import 'package:equatable/equatable.dart';
import 'package:tasky/auth/models/data/user_profile_response_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserProfileResponseModel userProfileResponseModel;

  const Authenticated({required this.userProfileResponseModel});

  @override
  List<Object?> get props => [userProfileResponseModel];
}

class AuthError extends AuthState {
  final String error;

  const AuthError({required this.error});

  @override
  List<Object?> get props => [error];
}
