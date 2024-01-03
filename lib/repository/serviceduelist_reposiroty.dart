import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/pregnency_service_duelist_model.dart';

import '../core/failure.dart';

abstract class ServiceDueListRepository {
  Future<Either<Failure, PregnencyServiceDuelistModel>>
      getPregnencyDueListAPI({required String apiName,required String vetId,required String fromDate,required String toDate});

  Future<Either<Failure, CommonResponseModel>>
  updateRecordStatus({required String recordId,required String recordType,required String commType,required String status});
}
