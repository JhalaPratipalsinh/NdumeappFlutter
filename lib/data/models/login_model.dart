/// success : true
/// message : "Successfully Login"
/// data : {"vet_id":4,"vet_fname":"Peter","vet_sname":"Koima","vet_email":null,"vet_phone":"254729156241","access_token":"3|BfzswdhXVc8WU6plXrVuDdL3bg1gElnFH3hmO5bN"}

class LoginModel {
  LoginModel({
    bool? success,
    String? message,
    Data? data,
  }) {
    _success = success;
    _message = message;
    _data = data;
  }

  LoginModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _success;
  String? _message;
  Data? _data;

  bool? get success => _success;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// vet_id : 4
/// vet_fname : "Peter"
/// vet_sname : "Koima"
/// vet_email : null
/// vet_phone : "254729156241"
/// access_token : "3|BfzswdhXVc8WU6plXrVuDdL3bg1gElnFH3hmO5bN"

class Data {
  Data({
    int? vetId,
    String? vetFname,
    String? vetSname,
    dynamic vetEmail,
    String? vetPhone,
    String? accessToken,
  }) {
    _vetId = vetId;
    _vetFname = vetFname;
    _vetSname = vetSname;
    _vetEmail = vetEmail;
    _vetPhone = vetPhone;
    _accessToken = accessToken;
  }

  Data.fromJson(dynamic json) {
    _vetId = json['vet_id'];
    _vetFname = json['vet_fname'];
    _vetSname = json['vet_sname'];
    _vetEmail = json['vet_email'];
    _vetPhone = json['vet_phone'];
    _accessToken = json['access_token'];
  }

  int? _vetId;
  String? _vetFname;
  String? _vetSname;
  dynamic _vetEmail;
  String? _vetPhone;
  String? _accessToken;

  int? get vetId => _vetId;

  String? get vetFname => _vetFname;

  String? get vetSname => _vetSname;

  dynamic get vetEmail => _vetEmail;

  String? get vetPhone => _vetPhone;

  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vet_id'] = _vetId;
    map['vet_fname'] = _vetFname;
    map['vet_sname'] = _vetSname;
    map['vet_email'] = _vetEmail;
    map['vet_phone'] = _vetPhone;
    map['access_token'] = _accessToken;
    return map;
  }
}
