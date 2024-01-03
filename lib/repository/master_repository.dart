import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/SubcountyListModel.dart';
import 'package:ndumeappflutter/data/models/WardListModel.dart';
import 'package:ndumeappflutter/data/models/terms_condition_status_model.dart';

import '../data/models/CountyListModel.dart';


abstract class MasterRepository{

  Future<Either<Failure, CountyListModel>> getCountyList();

  Future<Either<Failure, SubcountyListModel>> getSubCountyList(String county);

  Future<Either<Failure, WardListModel>> getWardList(String county, String subCounty);

  Future<Either<Failure, TermsConditionStatusModel>> checkTermsCondition(String vetId);

  Future<Either<Failure, CommonResponseModel>> updateTermsCondition(String vetId);

  CountyListModel? getCachedCountyList();
}