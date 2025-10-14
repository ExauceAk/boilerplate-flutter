import '../../data/models/user.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class MeLoaded extends AuthState {
  final User user;

  MeLoaded(this.user);
}

class AuthSuccess extends AuthState {
  //final User user;
  final String message;
  AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
