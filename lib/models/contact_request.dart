class ContactRequest {
  String senderId;
  String receiverId;
  bool hasReceiverAccepted;

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      "receiverId": receiverId,
      "hasReceiverAccepted": hasReceiverAccepted
    };
  }

  ContactRequest fromMap(Map<String, dynamic> data) {
    ContactRequest request = new ContactRequest();
    request.senderId = data['senderId'];
    request.receiverId = data['receiverId'];
    request.hasReceiverAccepted = data['hasReceiverAccepted'];
    return request;
  }
}
