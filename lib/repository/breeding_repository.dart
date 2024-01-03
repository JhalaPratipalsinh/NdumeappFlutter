import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/data/models/add_breeding_record_model.dart';
import 'package:ndumeappflutter/data/models/add_breeding_record_req_model.dart';
import 'package:ndumeappflutter/data/models/breeding_model.dart';

import '../core/failure.dart';
import '../data/models/paid_breeding_record_model.dart';
import '../data/models/source_of_semen_list_model.dart';

abstract class BreedingRepository {
  Future<Either<Failure, AddBreedingRecordModel>> addBreedingRecordAPI(
      {required AddBreedingRecordReqModel addBreedingRecordReq});

  Future<Either<Failure, AddBreedingRecordModel>> updateBreedingRecordAPI(
      {required AddBreedingRecordReqModel addBreedingRecordReq});

  Future<Either<Failure, BreedingModel>> fetchBreedingRecordsAPI(
      {required String mobileNoOrVetId,
      required bool isMobileNo,
      bool isVatId,
      bool isVerified});

  Future<Either<Failure, BreedingData>> getBreedingDetailAPI(
      {required String breedingID});

  Future<Either<Failure, AddBreedingRecordModel>> removeBreedingAPI(
      {required String breedingID});

  Future<Either<Failure, PaidBreedingRecordModel>> getPaidBreedingListAPI(
      {required String vatId});

  Future<Either<Failure, FetchSourceOfSemenListModel>>
      fetchSourceOfSemenListAPI({required String semenType});
}
