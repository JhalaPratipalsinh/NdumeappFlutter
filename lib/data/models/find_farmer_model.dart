/// success : true
/// message : "Found Record"
/// data : {"farmer_vet_id":2229,"farmer_id":null,"farmer_name":"Peninah","mobile_number":"254708581516","county":"Kiambu","subcounty":"Kikuyu","ward":"Kikuyu"}

class FindOrAddFarmerModel {
  FindOrAddFarmerModel({
    bool? success,
    String? message,
    FarmerDataModel? data,
  }) {
    _success = success;
    _message = message;
    _data = data;
  }

  FindOrAddFarmerModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? FarmerDataModel.fromJson(json['data']) : null;
  }

  bool? _success;
  String? _message;
  FarmerDataModel? _data;

  bool? get success => _success;

  String? get message => _message;

  FarmerDataModel? get data => _data;

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

/// farmer_vet_id : 2229
/// farmer_id : null
/// farmer_name : "Peninah"
/// mobile_number : "254708581516"
/// county : "Kiambu"
/// subcounty : "Kikuyu"
/// ward : "Kikuyu"

class FarmerDataModel {
  FarmerDataModel(
      {int? farmerVetId,
      dynamic farmerId,
      String? farmerName,
      String? mobileNumber,
      String? county,
      String? subcounty,
      String? ward,
      int? vetId,
      dynamic farmerType,
      String? gender}) {
    _farmerVetId = farmerVetId;
    _farmerId = farmerId;
    _farmerName = farmerName;
    _mobileNumber = mobileNumber;
    _county = county;
    _subcounty = subcounty;
    _ward = ward;
    _vetId = vetId;
    _farmerType = farmerType;
    _gender=gender;
  }

  FarmerDataModel.fromJson(dynamic json) {
    _farmerVetId = json['farmer_vet_id'];
    _farmerId = json['farmer_id'];
    _farmerName = json['farmer_name'];
    _mobileNumber = json['mobile_number'];
    _county = json['county'];
    _subcounty = json['subcounty'];
    _ward = json['ward'];
    _vetId = json['vet_id'];
    _farmerType = json['farmer_type'];
    _gender=json['gender'];
  }

  int? _farmerVetId;
  dynamic _farmerId;
  String? _farmerName;
  String? _mobileNumber;
  String? _county;
  int? _vetId;
  String? _subcounty;
  String? _ward;
  dynamic _farmerType;
  String? _gender;

  int? get farmerVetId => _farmerVetId;

  dynamic get farmerId => _farmerId;

  String? get farmerName => _farmerName;

  String? get mobileNumber => _mobileNumber;

  String? get county => _county;

  String? get subcounty => _subcounty;

  String? get ward => _ward;

  int? get vetId => _vetId;

  dynamic get farmerType => _farmerType;

  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['farmer_vet_id'] = _farmerVetId;
    map['farmer_id'] = _farmerId;
    map['farmer_name'] = _farmerName;
    map['mobile_number'] = _mobileNumber;
    map['county'] = _county;
    map['subcounty'] = _subcounty;
    map['ward'] = _ward;
    map['vet_id'] = _vetId;
    map['farmer_type'] = _farmerType;
    map['gender']=_gender;
    return map;
  }
}
