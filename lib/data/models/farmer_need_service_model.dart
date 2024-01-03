/// success : true
/// message : "Found"
/// data : {"pregnanacyCount":2,"dewormingCount":0}

class FarmerNeedServiceModel {
  FarmerNeedServiceModel({
      bool? success, 
      String? message, 
      Data? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  FarmerNeedServiceModel.fromJson(dynamic json) {
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

/// pregnanacyCount : 2
/// dewormingCount : 0

class Data {
  Data({
      num? pregnanacyCount, 
      num? dewormingCount,
      num? vaccinationCount }){
    _pregnanacyCount = pregnanacyCount;
    _dewormingCount = dewormingCount;
    _vaccinationCount=vaccinationCount;
}

  Data.fromJson(dynamic json) {
    _pregnanacyCount = json['pregnanacyCount'];
    _dewormingCount = json['dewormingCount'];
    _vaccinationCount = json['vaccinationCount'];
  }
  num? _pregnanacyCount;
  num? _dewormingCount;
  num? _vaccinationCount;

  num? get pregnanacyCount => _pregnanacyCount;
  num? get dewormingCount => _dewormingCount;
  num? get vaccinationCount=> _vaccinationCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pregnanacyCount'] = _pregnanacyCount;
    map['dewormingCount'] = _dewormingCount;
    map['vaccinationCount'] = _vaccinationCount;
    return map;
  }

}