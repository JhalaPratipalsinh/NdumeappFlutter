import 'dart:convert';

/// success : true
/// message : "Found"
/// data : [{"county":"Kajiado"},{"county":"Samburu"},{"county":"Mombasa"},{"county":"Baringo"},{"county":"Isiolo"},{"county":"Vihiga"},{"county":"Kakamega"},{"county":"Busia"},{"county":"Laikipia"},{"county":"Bungoma"},{"county":"Homa Bay"},{"county":"Siaya"},{"county":"Muranga"},{"county":"Nyandarua"},{"county":"Nyeri"},{"county":"Kitui"},{"county":"Embu"},{"county":"Kiambu"},{"county":"Kirinyaga"},{"county":"Narok"},{"county":"Bomet"},{"county":"Kilifi"},{"county":"Kericho"},{"county":"Meru"},{"county":"Machakos"},{"county":"Makueni"},{"county":"Kisumu"},{"county":"Nakuru"},{"county":"Garissa"},{"county":"Kwale"},{"county":"Taita Taveta"},{"county":"Nandi"},{"county":"Nyamira"},{"county":"Wajir"},{"county":"Tharaka-Nithi"},{"county":"Marsabit"},{"county":"Migori"},{"county":"Kisii"},{"county":"Murang'a"},{"county":"Nairobi"},{"county":"Elgeyo-Marakwet"},{"county":"Uasin Gishu"},{"county":"Tana River"},{"county":"Trans Nzoia"},{"county":"West Pokot"},{"county":"Lamu"}]

CountyListModel countyListModelFromJson(String str) => CountyListModel.fromJson(json.decode(str));

String countyListModelToJson(CountyListModel data) => json.encode(data.toJson());

class CountyListModel {
  CountyListModel({
    bool? success,
    String? message,
    List<CountyList>? data,
  }) {
    _success = success;
    _message = message;
    _data = data;
  }

  CountyListModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = [];
    _data!.add(CountyList(county: 'Select County'));
    if (json['data'] != null) {
      json['data'].forEach((v) {
        _data?.add(CountyList.fromJson(v));
      });
    }
  }

  bool? _success;
  String? _message;
  List<CountyList>? _data;

  CountyListModel copyWith({
    bool? success,
    String? message,
    List<CountyList>? data,
  }) =>
      CountyListModel(
        success: success ?? _success,
        message: message ?? _message,
        data: data ?? _data,
      );

  bool? get success => _success;

  String? get message => _message;

  List<CountyList>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountyListModel &&
          runtimeType == other.runtimeType &&
          success == other.success &&
          data == other.data &&
          message == other.message;

  @override
  int get hashCode => success.hashCode ^ data.hashCode ^ message.hashCode;
}

/// county : "Kajiado"

CountyList dataFromJson(String str) => CountyList.fromJson(json.decode(str));

String dataToJson(CountyList data) => json.encode(data.toJson());

class CountyList {
  CountyList({
    String? county,
  }) {
    _county = county;
  }

  CountyList.fromJson(dynamic json) {
    _county = json['county'];
  }

  String? _county;

  CountyList copyWith({
    String? county,
  }) =>
      CountyList(
        county: county ?? _county,
      );

  String? get county => _county;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['county'] = _county;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountyList && runtimeType == other.runtimeType && county == other.county;

  @override
  int get hashCode => county.hashCode;
}
