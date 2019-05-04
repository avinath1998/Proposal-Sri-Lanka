import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class RequestContactEvent extends ProfileEvent {}

class RequestedContactEvent extends ProfileEvent {}

class NoRequestedContactEvent extends ProfileEvent {}

class RequestingContactErrorEvent extends ProfileEvent {
  final String errorMsg;

  RequestingContactErrorEvent(this.errorMsg);
}
