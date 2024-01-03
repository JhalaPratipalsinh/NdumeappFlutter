/// success : true
/// message : "Found"
/// total_health_record : 6
/// total_verified_helath_record : 0
/// total_health_amount : 0
/// total_breeding_record : 59
/// total_verified_breeding_record : 1
/// total_breeding_amount : 0

class NdumeWalletModel {
  NdumeWalletModel({
    bool? success,
    String? message,
    int? totalHealthRecord,
    int? totalVerifiedHealthRecord,
    int? totalHealthAmount,
    int? totalBreedingRecord,
    int? totalVerifiedBreedingRecord,
    int? totalBreedingAmount,
    int? total_paid_helath_record,
    int? total_paid_breeding_record,
    int? total_withdrawl_amount,
    int? min_withdrawl_amount,
    int? max_withdrawl_amount,
  }) {
    _success = success;
    _message = message;
    _totalHealthRecord = totalHealthRecord;
    _totalVerifiedHealthRecord = totalVerifiedHealthRecord;
    _totalHealthAmount = totalHealthAmount;
    _totalBreedingRecord = totalBreedingRecord;
    _totalVerifiedBreedingRecord = totalVerifiedBreedingRecord;
    _totalBreedingAmount = totalBreedingAmount;
    _totalPaidHelathRecord=total_paid_helath_record;
    _totalPaidBreedingRecord=total_paid_breeding_record;
    _totalWithdrawlAmount=total_withdrawl_amount;
    _minWithdrawlAmount=min_withdrawl_amount;
    _maxWithdrawalAmount=max_withdrawl_amount;
  }

  NdumeWalletModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalHealthRecord = json['total_health_record'];
    _totalVerifiedHealthRecord = json['total_verified_helath_record'];
    _totalHealthAmount = json['total_health_amount'];
    _totalBreedingRecord = json['total_breeding_record'];
    _totalVerifiedBreedingRecord = json['total_verified_breeding_record'];
    _totalBreedingAmount = json['total_breeding_amount'];
    _totalPaidHelathRecord=json['total_paid_helath_record'];
    _totalPaidBreedingRecord=json['total_paid_breeding_record'];
    _totalWithdrawlAmount=json['total_withdrawl_amount'];
    _minWithdrawlAmount=json['minimum_amount'];
    _maxWithdrawalAmount=json['maximum_amount'];
  }

  bool? _success;
  String? _message;
  int? _totalHealthRecord;
  int? _totalVerifiedHealthRecord;
  int? _totalHealthAmount;
  int? _totalBreedingRecord;
  int? _totalVerifiedBreedingRecord;
  int? _totalBreedingAmount;
  int? _totalPaidHelathRecord;
  int? _totalPaidBreedingRecord;
  int? _totalWithdrawlAmount;
  int? _minWithdrawlAmount;
  int? _maxWithdrawalAmount;

  bool? get success => _success;

  String? get message => _message;

  int? get totalHealthRecord => _totalHealthRecord;

  int? get totalVerifiedHealthRecord => _totalVerifiedHealthRecord;

  int? get totalHealthAmount => _totalHealthAmount;

  int? get totalBreedingRecord => _totalBreedingRecord;

  int? get totalVerifiedBreedingRecord => _totalVerifiedBreedingRecord;

  int? get totalBreedingAmount => _totalBreedingAmount;

  int? get totalPaidBreedingRecord => _totalPaidBreedingRecord;

  int? get totalPaidHelathRecord => _totalPaidHelathRecord;

  int? get totalWithdrawlAmount => _totalWithdrawlAmount;

  int? get  minWithdrawlAmount=> _minWithdrawlAmount;

  int? get  maxWithdrawalAmount=> _maxWithdrawalAmount;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_health_record'] = _totalHealthRecord;
    map['total_verified_helath_record'] = _totalVerifiedHealthRecord;
    map['total_health_amount'] = _totalHealthAmount;
    map['total_breeding_record'] = _totalBreedingRecord;
    map['total_verified_breeding_record'] = _totalVerifiedBreedingRecord;
    map['total_breeding_amount'] = _totalBreedingAmount;
    map['total_paid_helath_record'] = _totalPaidHelathRecord;
    map['total_paid_breeding_record'] = _totalPaidBreedingRecord;
    map['total_withdrawl_amount'] = _totalWithdrawlAmount;
    map['minimum_amount'] = _minWithdrawlAmount;
    map['maximum_amount'] = _maxWithdrawalAmount;
    return map;
  }
}
