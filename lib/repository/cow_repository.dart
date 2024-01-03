import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/models/cow_breeds_group_model.dart';
import 'package:ndumeappflutter/data/models/cow_list_model.dart';
import 'package:ndumeappflutter/data/models/register_cow_req_model.dart';

import '../data/models/register_cow_model.dart';

abstract class CowRepository {
  Future<Either<Failure, List<CowRecordsModel>>> callCowRecordsAPI(
      {required String mobileNumber, bool fetchNewRecord = true});

  Future<Either<Failure, CowBreedsGroupModel>> fetchCowBreedAndGroupAPI();

  Future<Either<Failure, RegisterCowModel>> registerNewCowAPI(
      {required RegisterCowReqModel registerCowReq});

  List<CowRecordsModel> getCowList();
}
