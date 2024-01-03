import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/apiService/base_api_service.dart';
import 'package:ndumeappflutter/data/models/add_breeding_record_model.dart';
import 'package:ndumeappflutter/data/models/breeding_model.dart';
import 'package:ndumeappflutter/data/models/source_of_semen_list_model.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/injection_container.dart';
import 'package:ndumeappflutter/repository/breeding_repository.dart';

import '../../core/logger.dart';
import '../../util/constants.dart';
import '../models/add_breeding_record_req_model.dart';
import '../models/paid_breeding_record_model.dart';

class BreedingRepositoryImpl implements BreedingRepository {
  BaseAPIService baseAPIService;

  BreedingRepositoryImpl(this.baseAPIService);

  @override
  Future<Either<Failure, AddBreedingRecordModel>> addBreedingRecordAPI(
      {required AddBreedingRecordReqModel addBreedingRecordReq}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: addBreedingAPI,
          queryParameters: addBreedingRecordReq.toJson(),
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = AddBreedingRecordModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, BreedingModel>> fetchBreedingRecordsAPI(
      {required String mobileNoOrVetId,
      required bool isMobileNo,
      bool isVatId = false,
      bool isVerified = false}) async {
    try {
      Map<String, String> queryParameters;

      if (isMobileNo && isVatId) {
        queryParameters = {
          'mobile': mobileNoOrVetId,
          'vet_id':
              sl<SessionManager>().getUserDetails()!.data!.vetId.toString(),
          'is_verified': "0,1,2"
        };
      } else if (isVerified) {
        queryParameters = {
          isMobileNo ? 'mobile' : 'vet_id': mobileNoOrVetId,
          'is_verified': "1",
          'is_paid': '1'
        };
      } else {
        queryParameters = {
          isMobileNo ? 'mobile' : 'vet_id': mobileNoOrVetId,
          'is_verified': "0,1,2"
        };
      }
      final possibleData = await baseAPIService.executeAPI(
          url: getBreedingAPI,
          queryParameters: queryParameters,
          apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = BreedingModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, AddBreedingRecordModel>> updateBreedingRecordAPI(
      {required AddBreedingRecordReqModel addBreedingRecordReq}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: updateBreedingAPI,
          queryParameters: addBreedingRecordReq.toJson(),
          apiType: ApiType.put);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = AddBreedingRecordModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, BreedingData>> getBreedingDetailAPI(
      {required String breedingID}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: getBreedingAPI,
          queryParameters: {'id': breedingID},
          apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = BreedingModel.fromJson(response);
      if (details.data!.isEmpty) {
        return Right(BreedingData());
      }
      return Right(details.data![0]);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, AddBreedingRecordModel>> removeBreedingAPI(
      {required String breedingID}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: '$deleteBreedingRecordAPI$breedingID',
          queryParameters: {},
          apiType: ApiType.delete);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = AddBreedingRecordModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, PaidBreedingRecordModel>> getPaidBreedingListAPI(
      {required String vatId}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: getPaidBreedingAPI + vatId,
          queryParameters: {},
          apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = PaidBreedingRecordModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, FetchSourceOfSemenListModel>>
      fetchSourceOfSemenListAPI({required String semenType}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: fetchSourceOfSemenAPI,
          queryParameters: {"semen_type": semenType},
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = FetchSourceOfSemenListModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }
}
