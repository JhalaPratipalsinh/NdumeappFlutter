import 'dart:convert';

/// success : true
/// message : "Found"
/// data : [{"county":"Kajiado","subcounty":"Kajiado Central"},{"county":"Kajiado","subcounty":"Kajiado East"},{"county":"Kajiado","subcounty":"Kajiado West"},{"county":"Kajiado","subcounty":"Kajiado South"},{"county":"Kajiado","subcounty":"Kajiado North"}]

SubcountyListModel subcountyListModelFromJson(String str) =>
    SubcountyListModel.fromJson(json.decode(str));
String subcountyListModelToJson(SubcountyListModel data) =>
    json.encode(data.toJson());

class SubcountyListModel {
  SubcountyListModel({
    bool? success,
    String? message,
    List<SubcountyList>? data,
  }) {
    _success = success;
    _message = message;
    _data = data;
  }

  SubcountyListModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = [];
    _data!.add(SubcountyList(county: '', subcounty: 'Select Subcounty'));
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data?.add(SubcountyList.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<SubcountyList>? _data;
  SubcountyListModel copyWith({
    bool? success,
    String? message,
    List<SubcountyList>? data,
  }) =>
      SubcountyListModel(
        success: success ?? _success,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get success => _success;
  String? get message => _message;
  List<SubcountyList>? get data => _data;

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

SubcountyList dataFromJson(String str) =>
    SubcountyList.fromJson(json.decode(str));
String dataToJson(SubcountyList data) => json.encode(data.toJson());

class SubcountyList {
  SubcountyList({
    String? county,
    String? subcounty,
  }) {
    _county = county;
    _subcounty = subcounty;
  }

  SubcountyList.fromJson(dynamic json) {
    _county = json['county'];
    _subcounty = json['subcounty'];
  }
  String? _county;
  String? _subcounty;
  SubcountyList copyWith({
    String? county,
    String? subcounty,
  }) =>
      SubcountyList(
        county: county ?? _county,
        subcounty: subcounty ?? _subcounty,
      );
  String? get county => _county;
  String? get subcounty => _subcounty;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['county'] = _county;
    map['subcounty'] = _subcounty;
    return map;
  }
}
