/// ConversationID : "AG_20221017_2050651f120867d2a0fa"
/// OriginatorConversationID : "41349-95605270-1"
/// ResponseCode : "0"
/// ResponseDescription : "Accept the service request successfully."

class WithdrawWalletModel {
  WithdrawWalletModel({
    String? conversationID,
    String? originatorConversationID,
    String? responseCode,
    String? responseDescription,
  }) {
    _conversationID = conversationID;
    _originatorConversationID = originatorConversationID;
    _responseCode = responseCode;
    _responseDescription = responseDescription;
  }

  WithdrawWalletModel.fromJson(dynamic json) {
    _conversationID = json['ConversationID'];
    _originatorConversationID = json['OriginatorConversationID'];
    _responseCode = json['ResponseCode'];
    _responseDescription = json['ResponseDescription'];
  }

  String? _conversationID;
  String? _originatorConversationID;
  String? _responseCode;
  String? _responseDescription;

  String? get conversationID => _conversationID;

  String? get originatorConversationID => _originatorConversationID;

  String? get responseCode => _responseCode;

  String? get responseDescription => _responseDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ConversationID'] = _conversationID;
    map['OriginatorConversationID'] = _originatorConversationID;
    map['ResponseCode'] = _responseCode;
    map['ResponseDescription'] = _responseDescription;
    return map;
  }
}
