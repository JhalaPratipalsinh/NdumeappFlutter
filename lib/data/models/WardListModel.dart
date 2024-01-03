import 'dart:convert';
/// success : true
/// message : "Found"
/// data : [{"county":"Kajiado","subcounty":"Kajiado Central","ward":"Matapato South"}]

WardListModel wardListModelFromJson(String str) => WardListModel.fromJson(json.decode(str));
String wardListModelToJson(WardListModel data) => json.encode(data.toJson());
class WardListModel {
  WardListModel({
      bool? success, 
      String? message, 
      List<WardList>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  WardListModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = [];
    _data!.add(WardList(county: "", subcounty: "", ward: "Select Ward"));
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data?.add(WardList.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<WardList>? _data;
WardListModel copyWith({  bool? success,
  String? message,
  List<WardList>? data,
}) => WardListModel(  success: success ?? _success,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get success => _success;
  String? get message => _message;
  List<WardList>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// county : "Kajiado"
/// subcounty : "Kajiado Central"
/// ward : "Matapato South"

WardList dataFromJson(String str) => WardList.fromJson(json.decode(str));
String dataToJson(WardList data) => json.encode(data.toJson());
class WardList {
  WardList({
      String? county, 
      String? subcounty, 
      String? ward,}){
    _county = county;
    _subcounty = subcounty;
    _ward = ward;
}

  WardList.fromJson(dynamic json) {
    _county = json['county'];
    _subcounty = json['subcounty'];
    _ward = json['ward'];
  }
  String? _county;
  String? _subcounty;
  String? _ward;
WardList copyWith({  String? county,
  String? subcounty,
  String? ward,
}) => WardList(  county: county ?? _county,
  subcounty: subcounty ?? _subcounty,
  ward: ward ?? _ward,
);
  String? get county => _county;
  String? get subcounty => _subcounty;
  String? get ward => _ward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['county'] = _county;
    map['subcounty'] = _subcounty;
    map['ward'] = _ward;
    return map;
  }

}