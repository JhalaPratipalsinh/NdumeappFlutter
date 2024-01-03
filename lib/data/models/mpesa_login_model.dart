class MpesaLoginModel {
  MpesaLoginModel({
    required this.message,
    required this.token,
  });

  String? message;
  String? token;

  MpesaLoginModel.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    return map;
  }
}
