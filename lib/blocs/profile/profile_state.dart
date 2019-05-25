import 'package:meta/meta.dart';

@immutable
abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class SuccessFetchingFullDetailsState extends ProfileState {}

class ErrorFetchingFullDetailsState extends ProfileState {
  final String errorMsg;

  ErrorFetchingFullDetailsState(this.errorMsg);
}

class FetchingFullDetailsState extends ProfileState {}
