class PregnencyServiceDuelistModel {
  PregnencyServiceDuelistModel({
      bool? success, 
      String? message, 
      List<PregnencyDue>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  PregnencyServiceDuelistModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PregnencyDue.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<PregnencyDue>? _data;

  bool? get success => _success;
  String? get message => _message;
  List<PregnencyDue>? get data => _data;

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

class PregnencyDue {
  PregnencyDue({
      num? id,
      String? cowId, 
      String? cowName,
      String? farmerName, 
      String? mobile,
      String? date,
      String? treatmentDate,
      num? isVerified, 
      num? walletAmount, 
      num? isPaid, 
      num? withdrawId,
      String? verifiedBy}){
    _id = id;
    _cowId = cowId;
    _cowName = cowName;
    _farmerName = farmerName;
    _mobile = mobile;
    _date =date;
    _treatmentDate=treatmentDate;
    _isVerified = isVerified;
    _walletAmount = walletAmount;
    _isPaid = isPaid;
    _withdrawId = withdrawId;
    _verifiedBy = verifiedBy;
}

  PregnencyDue.fromJson(dynamic json) {
    _id = json['id'];
    _cowId = json['cow_id'];
    _cowName = json['cow_name'];
    _farmerName = json['farmer_name'];
    _mobile = json['mobile'];
    _date = json['date_dt'];
    _treatmentDate=json['treatment_date'];
    _isVerified = json['is_verified'];
    _walletAmount = json['wallet_amount'];
    _isPaid = json['is_paid'];
    _withdrawId = json['withdraw_id'];
    _verifiedBy = json['verified_by'];
  }
  num? _id;
  String? _cowId;
  String? _cowName;
  String? _farmerName;
  String? _mobile;
  String? _date;
  String? _treatmentDate;
  num? _isVerified;
  num? _walletAmount;
  num? _isPaid;
  num? _withdrawId;
  String? _verifiedBy;

  num? get id => _id;
  String? get cowId => _cowId;
  String? get cowName => _cowName;
  String? get farmerName => _farmerName;
  String? get mobile => _mobile;
  String? get date => _date;
  String? get treatmentDate => _treatmentDate;
  num? get isVerified => _isVerified;
  num? get walletAmount => _walletAmount;
  num? get isPaid => _isPaid;
  num? get withdrawId => _withdrawId;
  String? get verifiedBy => _verifiedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cow_id'] = _cowId;
    map['cow_name'] = _cowName;
    map['farmer_name'] = _farmerName;
    map['mobile'] = _mobile;
    map['date_dt'] = _date;
    map['treatment_date'] = _treatmentDate;
    map['is_verified'] = _isVerified;
    map['wallet_amount'] = _walletAmount;
    map['is_paid'] = _isPaid;
    map['withdraw_id'] = _withdrawId;
    map['verified_by'] = _verifiedBy;

    return map;
  }

}