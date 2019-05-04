import 'package:meta/meta.dart';

@immutable
abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class RequestingContactState extends ProfileState {}

class RequestedContactState extends ProfileState {}

class NoRequestedContactState extends ProfileState {}

class RequestingContactErrorState extends ProfileState {
  final String errorMsg;

  RequestingContactErrorState(this.errorMsg);
}
