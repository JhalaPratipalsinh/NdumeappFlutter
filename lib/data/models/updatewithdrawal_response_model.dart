class UpdatewithdrawalResponseModel {
  bool? _success;
  String? _message;

  UpdatewithdrawalResponseModel({bool? success, String? message}) {
    if (success != null) {
      this._success = success;
    }
    if (message != null) {
      this._message = message;
    }
  }

  bool? get success => _success;
  set success(bool? success) => _success = success;
  String? get message => _message;
  set message(String? message) => _message = message;

  UpdatewithdrawalResponseModel.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['message'] = this._message;
    return data;
  }
}
