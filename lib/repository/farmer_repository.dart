import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/data/models/farmer_model.dart';
import 'package:ndumeappflutter/data/models/farmer_need_service_model.dart';

import '../core/failure.dart';

abstract class FarmerRepository {
  Future<Either<Failure, List<FarmerData>>> fetchFarmersAPI({required String vetID,int? start,int? limit});

  Future<Either<Failure, FarmerNeedServiceModel>> fetchFarmersNeedServiceAPI({required String vetID,String? fromDate,String? toDate});
}
