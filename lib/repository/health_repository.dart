import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/data/models/add_health_record_model.dart';
import 'package:ndumeappflutter/data/models/add_health_record_req_model.dart';
import 'package:ndumeappflutter/data/models/health_model.dart';

import '../core/failure.dart';
import '../data/models/paid_health_record_model.dart';

abstract class HealthRepository {
  Future<Either<Failure, AddHealthRecordModel>> addHealthRecordAPI(
      {required AddHealthRecordReqModel addHealthRecordReqModel});

  Future<Either<Failure, AddHealthRecordModel>> updateHealthRecordAPI(
      {required AddHealthRecordReqModel addHealthRecordReqModel});

  Future<Either<Failure, List<HealthData>>> fetchHealthRecordAPI(
      {required String mobileNoOrVetId, required bool isMobileNo,bool isVatId,bool isVerified});

  Future<Either<Failure, HealthData>> fetchHealthRecordDetailAPI({required String healthId});

  Future<Either<Failure, AddHealthRecordModel>> removeHealthRecordDetailAPI(
      {required String healthId});

  Future<Either<Failure, List<PaidHealthRecord>>> getPaidHealthRecordAPI(
      {required String vetId});
}
