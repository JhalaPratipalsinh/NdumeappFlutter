import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/apiService/base_api_service.dart';
import 'package:ndumeappflutter/data/models/farmer_model.dart';
import 'package:ndumeappflutter/data/models/farmer_need_service_model.dart';
import 'package:ndumeappflutter/repository/farmer_repository.dart';

import '../../core/logger.dart';
import '../../screens/blocs/farmerBloc/farmer_bloc.dart';
import '../../util/constants.dart';

class FarmerRepositoryImpl implements FarmerRepository {
  final BaseAPIService baseAPIService;

  FarmerRepositoryImpl(this.baseAPIService);

  @override
  Future<Either<Failure, List<FarmerData>>> fetchFarmersAPI({required String vetID,int? start,int? limit}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: getFarmersAPI,
          queryParameters: {'vet_id': vetID, 'is_verified': "0,1,2",'start':start,'limit':limit},
          apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(
            Failure(possibleData.getLeft()!.error, errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = FarmerModel.fromJson(response);
      return Right(details.data!);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, FarmerNeedServiceModel>> fetchFarmersNeedServiceAPI({required String vetID, String? fromDate, String? toDate}) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: getFarmersServiceCountAPI,
          queryParameters: {'vet_id': vetID, 'from_date': fromDate,'to_date':toDate},
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(
            Failure(possibleData.getLeft()!.error, errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = FarmerNeedServiceModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }
}
