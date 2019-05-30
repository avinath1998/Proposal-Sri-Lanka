import 'package:meta/meta.dart';

@immutable
abstract class ContactRequestState {}

class InitialContactRequestState extends ContactRequestState {}

class ContactRequestSentSuccessState extends ContactRequestState {
  final bool isRequesting;
  final bool hasRequestBeenAccepted;

  ContactRequestSentSuccessState(
      this.isRequesting, this.hasRequestBeenAccepted);
}

class ContactRequestSentErrorState extends ContactRequestState {
  final String errorMsg;

  ContactRequestSentErrorState(this.errorMsg);
}

class ContactRequestSendingState extends ContactRequestState {}
