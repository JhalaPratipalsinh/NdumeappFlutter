import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/models/add_farmer_req_model.dart';
import 'package:ndumeappflutter/data/models/common_response_model.dart';
import 'package:ndumeappflutter/repository/home_repository.dart';
import 'package:ndumeappflutter/util/constants.dart';

import '../../core/logger.dart';
import '../../features/location_manager.dart';
import '../apiService/base_api_service.dart';
import '../models/find_farmer_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final BaseAPIService apiService;
  final LocationManager locationManager;

  HomeRepositoryImpl(this.apiService, this.locationManager);

  @override
  Future<Either<Failure, FindOrAddFarmerModel>> addFarmerAPI(
      {required AddFarmerReqModel addFarmerReq}) async {
    await locationManager.fetchLocationData();
    if (locationManager.locationData != null) {
      addFarmerReq.latitude = locationManager.locationData!.latitude!;
      addFarmerReq.longitude = locationManager.locationData!.longitude!;
    }
    try {
      final possibleData = await apiService.executeAPI(
          url: storeFarmerAPI, queryParameters: addFarmerReq.toJson(), apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(
            Failure(possibleData.getLeft()!.error, errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = FindOrAddFarmerModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, FindOrAddFarmerModel>> searchFarmerAPI(
      {required String mobileNumber}) async {
    try {
      final possibleData = await apiService.executeAPI(
          url: findFarmerAPI,
          queryParameters: {'mobile_number': mobileNumber},
          apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(
            Failure(possibleData.getLeft()!.error, errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = FindOrAddFarmerModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, CommonResponseModel>> updateFarmerAPI({required String farmerVetId,required String gender,required String county,required String subcounty,required String ward}) async{
    try {
      final possibleData = await apiService.executeAPI(
          url: updateFarmer,
          queryParameters: {'farmer_vet_id': farmerVetId,"gender":gender,"county":county,"subcounty":subcounty,"ward":ward},
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
