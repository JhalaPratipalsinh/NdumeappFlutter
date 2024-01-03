import 'dart:convert';

FetchSourceOfSemenListModel fetchSourceOfSemenListModelFromJson(String str) =>
    FetchSourceOfSemenListModel.fromJson(json.decode(str));

String fetchSourceOfSemenListModelToJson(FetchSourceOfSemenListModel data) =>
    json.encode(data.toJson());

class FetchSourceOfSemenListModel {
  bool success;
  String message;
  List<SourceOfSemenList>? sourceOfSemenList;

  FetchSourceOfSemenListModel({
    required this.success,
    required this.message,
    required this.sourceOfSemenList,
  });

  factory FetchSourceOfSemenListModel.fromJson(Map<String, dynamic> json) =>
      FetchSourceOfSemenListModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        sourceOfSemenList: json["data"] == null
            ? null
            : List<SourceOfSemenList>.from(json["data"].map((x) => SourceOfSemenList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(sourceOfSemenList?.map((x) => x.toJson()) ?? []),
      };
}

class SourceOfSemenList {
  int id;
  String semenType;
  String semenSource;
  String createdAt;
  String updatedAt;

  SourceOfSemenList({
    required this.id,
    required this.semenType,
    required this.semenSource,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SourceOfSemenList.fromJson(Map<String, dynamic> json) => SourceOfSemenList(
        id: json["id"] ?? 0,
        semenType: json["semen_type"] ?? "",
        semenSource: json["semen_source"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "semen_type": semenType,
        "semen_source": semenSource,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
