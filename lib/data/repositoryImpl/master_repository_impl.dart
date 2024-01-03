import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/core/logger.dart';
import 'package:ndumeappflutter/data/apiService/base_api_service.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/CountyListModel.dart';
import 'package:ndumeappflutter/data/models/SubcountyListModel.dart';
import 'package:ndumeappflutter/data/models/WardListModel.dart';
import 'package:ndumeappflutter/data/models/terms_condition_status_model.dart';
import 'package:ndumeappflutter/repository/master_repository.dart';
import 'package:ndumeappflutter/util/constants.dart';

class MasterRepositoryImpl implements MasterRepository {
  BaseAPIService apiService;
  CountyListModel? county;

  MasterRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, CountyListModel>> getCountyList() async {
    //final token = sessionManager.getToken() as String;
    if (county == null) {
      try {
        final possibleData =
            await apiService.executeAPI(url: countyAPI, queryParameters: {}, apiType: ApiType.get);
        if (possibleData.isLeft()) {
          return left(Failure(possibleData.getLeft()!.error));
        }
        final response = possibleData.getRight();
        county = CountyListModel.fromJson(response);
        return Right(county!);
      } on Exception catch (e) {
        logger.e(e);
        return left(const Failure('Unexpected Error occurred'));
      }
    } else {
      return Right(county!);
    }
  }

  @override
  Future<Either<Failure, SubcountyListModel>> getSubCountyList(String county) async {
    try {
      final possibleData = await apiService.executeAPI(
          url: subCountyAPI, queryParameters: {"county": county}, apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error));
      }
      final response = possibleData.getRight();
      final details = SubcountyListModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, WardListModel>> getWardList(String county, String subCounty) async {
    try {
      final possibleData = await apiService.executeAPI(
          url: wardAPI,
          queryParameters: {"county": county, "subcounty": subCounty},
          apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error));
      }
      final response = possibleData.getRight();
      final details = WardListModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  CountyListModel? getCachedCountyList() => county;

  @override
  Future<Either<Failure, TermsConditionStatusModel>> checkTermsCondition(String vetId) async {
    try {
      final possibleData = await apiService.executeAPI(
          url: checkTandCapi,
          queryParameters: {"vet_id": vetId},
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error));
      }
      final response = possibleData.getRight();
      final details = TermsConditionStatusModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, CommonResponseModel>> updateTermsCondition(String vetId) async {
    try {
      final possibleData = await apiService.executeAPI(
          url: updateTandCapi,
          queryParameters: {"vet_id": vetId},
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error));
      }
      final response = possibleData.getRight();
      final details = CommonResponseModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }
}
