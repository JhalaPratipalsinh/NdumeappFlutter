import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/pregnency_service_duelist_model.dart';
import 'package:ndumeappflutter/repository/serviceduelist_reposiroty.dart';

import '../../core/logger.dart';
import '../../util/constants.dart';
import '../apiService/base_api_service.dart';

class ServiceDueListRepositoryImpl implements ServiceDueListRepository{

  final BaseAPIService baseAPIService;

  ServiceDueListRepositoryImpl(this.baseAPIService);

  @override
  Future<Either<Failure, PregnencyServiceDuelistModel>> getPregnencyDueListAPI({required String apiName,required String vetId, required String fromDate,required String toDate}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: apiName,
          queryParameters: {'vet_id': vetId, 'from_date': fromDate,'to_date':toDate},
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(
            Failure(possibleData.getLeft()!.error, errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = PregnencyServiceDuelistModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, CommonResponseModel>> updateRecordStatus({required String recordId, required String recordType, required String commType, required String status}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: updateRecordStatusAPI,
          queryParameters: {'record_id': recordId, 'communication_type': commType,'record_type':recordType,'communication_status':status},
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(
            Failure(possibleData.getLeft()!.error, errorCode: possibleData.getLeft()!.errorCode));
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