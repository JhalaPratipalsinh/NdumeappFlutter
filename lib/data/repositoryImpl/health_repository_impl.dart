import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/apiService/base_api_service.dart';
import 'package:ndumeappflutter/data/models/add_health_record_model.dart';
import 'package:ndumeappflutter/data/models/add_health_record_req_model.dart';
import 'package:ndumeappflutter/data/models/health_model.dart';
import 'package:ndumeappflutter/data/models/paid_health_record_model.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/injection_container.dart';
import 'package:ndumeappflutter/repository/health_repository.dart';

import '../../core/logger.dart';
import '../../util/constants.dart';

class HealthRepositoryImpl implements HealthRepository {
  final BaseAPIService baseAPIService;

  HealthRepositoryImpl(this.baseAPIService);

  @override
  Future<Either<Failure, AddHealthRecordModel>> addHealthRecordAPI(
      {required AddHealthRecordReqModel addHealthRecordReqModel}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: addHealthAPI,
          queryParameters: addHealthRecordReqModel.toJson(),
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = AddHealthRecordModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<HealthData>>> fetchHealthRecordAPI(
      {required String mobileNoOrVetId,
      required bool isMobileNo,
      bool isVatId = false,
      bool isVerified=false}) async {
    try {
      var queryParameters;

      if (isMobileNo && isVatId) {
        queryParameters = {
          'mobile': mobileNoOrVetId,
          'vet_id':
              sl<SessionManager>().getUserDetails()!.data!.vetId.toString(),
          'is_verified': "0,1,2"
        };
      }else if(isVerified){
        queryParameters = {
          isMobileNo ? 'mobile' : 'vet_id': mobileNoOrVetId,
          'is_verified': "1",
          'is_paid':'1'
        };
      }
      else {
        queryParameters = {
          isMobileNo ? 'mobile' : 'vet_id': mobileNoOrVetId,
          'is_verified': "0,1,2"
        };
      }

      final possibleData = await baseAPIService.executeAPI(
          url: getHealthRecordsAPI,
          queryParameters: queryParameters,
          apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = HealthModel.fromJson(response);
      return Right(details.data!);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, HealthData>> fetchHealthRecordDetailAPI(
      {required String healthId}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: getHealthRecordsAPI,
          queryParameters: {'id': healthId},
          apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = HealthModel.fromJson(response);
      return Right(details.data!.first);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, AddHealthRecordModel>> updateHealthRecordAPI(
      {required AddHealthRecordReqModel addHealthRecordReqModel}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: updateHealthAPI,
          queryParameters: addHealthRecordReqModel.toJson(),
          apiType: ApiType.put);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = AddHealthRecordModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, AddHealthRecordModel>> removeHealthRecordDetailAPI(
      {required String healthId}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: '$deleteHealthRecordAPI$healthId',
          queryParameters: {},
          apiType: ApiType.delete);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = AddHealthRecordModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<PaidHealthRecord>>> getPaidHealthRecordAPI({required String vetId}) async{
    try {

      final possibleData = await baseAPIService.executeAPI(
          url: getPaidHealthingAPI+vetId,
          queryParameters: {},
          apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = PaidHealthRecordModel.fromJson(response);
      return Right(details.paidHealthRecord!);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }
}
