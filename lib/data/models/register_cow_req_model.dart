class RegisterCowReqModel {
  final String breedID;
  final String title;
  final String groupID;
  final String mobileNo;
  final String birthDate;
  final String calvingLactations;
  final String cowBreedID1;
  final String cowBreedID2;

  RegisterCowReqModel(
      {required this.breedID,
      required this.title,
      required this.groupID,
      required this.mobileNo,
      required this.birthDate,
      required this.calvingLactations,
      required this.cowBreedID1,
      required this.cowBreedID2});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['breed_id'] = breedID;
    map['title'] = title;
    map['group_id'] = groupID;
    map['mobile_number'] = mobileNo;
    map['date_of_birth'] = birthDate;
    map['calving_lactation'] = calvingLactations;
    map['cow_breeding_1'] = cowBreedID1;
    map['cow_breeding_2'] = cowBreedID2;
    return map;
  }
}
