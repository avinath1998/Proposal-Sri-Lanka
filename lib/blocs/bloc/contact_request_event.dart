import 'package:meta/meta.dart';

@immutable
abstract class ContactRequestEvent {}

class SendContactRequestEvent extends ContactRequestEvent {
  final bool isRequesting;
  SendContactRequestEvent(this.isRequesting);
}

class SuccessContactingRequestEvnet extends ContactRequestEvent {
  final bool isRequesting;
  SuccessContactingRequestEvnet(this.isRequesting);
}

class ErrorContactingRequestEvnet extends ContactRequestEvent {
  final String errorMsg;
  ErrorContactingRequestEvnet(this.errorMsg);
}
