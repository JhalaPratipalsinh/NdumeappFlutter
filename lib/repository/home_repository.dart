import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/models/add_farmer_req_model.dart';
import 'package:ndumeappflutter/data/models/common_response_model.dart';
import 'package:ndumeappflutter/data/models/find_farmer_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, FindOrAddFarmerModel>> searchFarmerAPI({required String mobileNumber});

  Future<Either<Failure, FindOrAddFarmerModel>> addFarmerAPI(
      {required AddFarmerReqModel addFarmerReq});

  Future<Either<Failure, CommonResponseModel>> updateFarmerAPI(
      {required String farmerVetId,required String gender,required String county,required String subcounty,required String ward});
}
