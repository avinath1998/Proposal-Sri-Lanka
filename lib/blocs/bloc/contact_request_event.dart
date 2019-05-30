import 'package:meta/meta.dart';

@immutable
abstract class ContactRequestEvent {}

class SendContactRequestEvent extends ContactRequestEvent {
  final bool isRequesting;
  SendContactRequestEvent(this.isRequesting);
}

class SuccessContactingRequestEvnet extends ContactRequestEvent {
  final bool isRequesting;
  final bool hasContactBeenAccepted;
  SuccessContactingRequestEvnet(this.isRequesting, this.hasContactBeenAccepted);
}

class ErrorContactingRequestEvnet extends ContactRequestEvent {
  final String errorMsg;
  ErrorContactingRequestEvnet(this.errorMsg);
}
