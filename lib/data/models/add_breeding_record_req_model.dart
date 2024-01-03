class AddBreedingRecordReqModel {
  String breedingID;
  String cowName;
  String cowId;
  String mainDate;
  String bullName;
  String bullCode;
  String farmerName;
  String semenType;
  String sexType;
  String cost;
  String noStraw;
  String dryingDate;
  String expectedDOB;
  String expectedRepeatDate;
  String mobileNo;
  String pregnancyDate;
  String recordType;
  String pgStatus;
  String repeats;
  String strawBreed;
  int? breed1;
  int? breed2;
  String strimingDate;
  String syncDate;
  String vetID;
  String vetName;
  String isVerified;
  String firstHeat;
  String secondHeat;
  String isRepeat;
  String sourceOfSemen;

  AddBreedingRecordReqModel(
      {this.breedingID = '',
      required this.cowName,
      required this.cowId,
      required this.mainDate,
      required this.bullName,
      required this.bullCode,
      required this.farmerName,
      required this.semenType,
      required this.sexType,
      required this.cost,
      required this.noStraw,
      required this.dryingDate,
      required this.expectedDOB,
      required this.expectedRepeatDate,
      required this.mobileNo,
      required this.pregnancyDate,
      required this.recordType,
      required this.pgStatus,
      required this.repeats,
      required this.strawBreed,
      required this.breed1,
      required this.breed2,
      required this.strimingDate,
      required this.syncDate,
      required this.vetID,
      required this.vetName,
      required this.isVerified,
      required this.firstHeat,
      required this.secondHeat,
      required this.isRepeat,
      required this.sourceOfSemen,
      });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = breedingID;
    map['bull_code'] = bullCode;
    map['bull_name'] = bullName;
    map['cost'] = cost;
    map['cow_id'] = cowId;
    map['cow_name'] = cowName;
    map['drying_date'] = dryingDate;
    map['expected_date_of_birth'] = expectedDOB;
    map['expected_repeat_date'] = expectedRepeatDate;
    map['farmer_name'] = farmerName;
    map['mobile'] = mobileNo;
    map['no_straw'] = noStraw;
    map['pregnancy_date'] = pregnancyDate;
    map['record_type'] = recordType;
    map['pg_status'] = pgStatus;
    map['repeats'] = repeats;
    map['semen_type'] = semenType;
    map['sex_type'] = sexType;
    map['straw_breed'] = strawBreed;
    map['breed1'] = breed1;
    map['breed2'] = breed2;
    map['strimingup_date'] = strimingDate;
    map['sync_at'] = syncDate;
    map['vet_id'] = vetID;
    map['vet_name'] = vetName;
    map['date_dt'] = mainDate;
    map['is_verified'] = isVerified;
    map['first_heat'] = firstHeat;
    map['second_heat'] = secondHeat;
    map['is_repeat'] = isRepeat;
    map['source_of_semen'] = sourceOfSemen;
    return map;
  }
}
