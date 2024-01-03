import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/apiService/base_api_service.dart';
import 'package:ndumeappflutter/data/models/cow_breeds_group_model.dart';
import 'package:ndumeappflutter/data/models/register_cow_model.dart';
import 'package:ndumeappflutter/data/models/register_cow_req_model.dart';
import 'package:ndumeappflutter/repository/cow_repository.dart';

import '../../core/logger.dart';
import '../../util/constants.dart';
import '../models/cow_list_model.dart';

class CowRepositoryImpl implements CowRepository {
  final BaseAPIService baseAPIService;
  final List<CowRecordsModel> _cowRecords = [];
  CowBreedsGroupModel? _cowBreedsGroupModel;

  CowRepositoryImpl(this.baseAPIService);

  @override
  Future<Either<Failure, List<CowRecordsModel>>> callCowRecordsAPI(
      {required String mobileNumber, bool fetchNewRecord = true}) async {
    try {
      if (fetchNewRecord) {
        final possibleData = await baseAPIService.executeAPI(
            url: '$cowCalfRecordAPI$mobileNumber', queryParameters: {}, apiType: ApiType.get);
        if (possibleData.isLeft()) {
          return left(
              Failure(possibleData.getLeft()!.error, errorCode: possibleData.getLeft()!.errorCode));
        }
        final response = possibleData.getRight();
        final details = CowListModel.fromJson(response);
        _cowRecords.clear();
        _cowRecords.addAll(details.cowRecords!);
        return Right(_cowRecords);
      }
      return Right(_cowRecords);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, CowBreedsGroupModel>> fetchCowBreedAndGroupAPI() async {
    try {
      if (_cowBreedsGroupModel == null) {
        final possibleData = await baseAPIService.executeAPI(
            url: cowBreedingAndGroupAPI, queryParameters: {}, apiType: ApiType.get);
        if (possibleData.isLeft()) {
          return left(
              Failure(possibleData.getLeft()!.error, errorCode: possibleData.getLeft()!.errorCode));
        }
        final response = possibleData.getRight();
        _cowBreedsGroupModel = CowBreedsGroupModel.fromJson(response);
        return Right(_cowBreedsGroupModel!);
      }
      return Right(_cowBreedsGroupModel!);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, RegisterCowModel>> registerNewCowAPI(
      {required RegisterCowReqModel registerCowReq}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: registerCowAPI, queryParameters: registerCowReq.toJson(), apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(
            Failure(possibleData.getLeft()!.error, errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final data = RegisterCowModel.fromJson(response);
      return Right(data);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  List<CowRecordsModel> getCowList() => _cowRecords;
}
