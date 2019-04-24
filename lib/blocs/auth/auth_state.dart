import 'package:meta/meta.dart';
import 'package:proposal/models/user.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class SignedInState extends AuthState {
  final String user;
  SignedInState(this.user);
}

class SigningInErrorState extends AuthState {
  final String error;

  SigningInErrorState(this.error);
}

class SigningOutErrorState extends AuthState {
  final String error;

  SigningOutErrorState(this.error);
}

class SignedOutState extends AuthState {}
