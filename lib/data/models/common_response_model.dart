/// success : true
/// message : "Found"

class CommonResponseModel {
  CommonResponseModel({
      bool? success, 
      String? message,}){
    _success = success;
    _message = message;
}

  CommonResponseModel.fromJson(dynamic json) {
    _success = json['success'] as bool;
    _message = json['message'] as String;
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