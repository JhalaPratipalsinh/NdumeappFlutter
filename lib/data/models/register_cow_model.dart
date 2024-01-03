/// success : true
/// message : "Stored Cow"

class RegisterCowModel {
  RegisterCowModel({
    bool? success,
    String? message,
  }) {
    _success = success;
    _message = message;
  }

  RegisterCowModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
  }

  bool? _success;
  String? _message;

  bool? get success => _success;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    return map;
  }
}
