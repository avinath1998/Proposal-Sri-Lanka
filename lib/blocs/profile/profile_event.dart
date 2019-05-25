import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class FetchContactFullDetails extends ProfileEvent {}

class FetchedContactFullDetails extends ProfileEvent {}

class FetchingContactDetailsError extends ProfileEvent {
  final String errorMsg;

  FetchingContactDetailsError(this.errorMsg);
}
