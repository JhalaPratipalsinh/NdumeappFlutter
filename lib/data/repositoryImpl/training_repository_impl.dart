import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/training_categorylist_model.dart';
import 'package:ndumeappflutter/data/models/trainingdetail_model.dart';
import 'package:ndumeappflutter/repository/training_repository.dart';

import '../../core/logger.dart';
import '../../injection_container.dart';
import '../../util/constants.dart';
import '../apiService/base_api_service.dart';
import '../models/training_topiclist_model.dart';
import '../sessionManager/session_manager.dart';

class TrainingRepositoryImpl implements TrainingRepository {
  final BaseAPIService baseAPIService;
  SessionManager sessionManager;

  TrainingRepositoryImpl(this.baseAPIService, this.sessionManager);

  @override
  Future<Either<Failure, TrainingCategorylistModel>>
      getTrainingCatListAPI() async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: getTrainingCategory, queryParameters: {}, apiType: ApiType.get);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = TrainingCategorylistModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, TrainingTopiclistModel>> getTrainingTopicListAPI(
      String catId) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: getTrainingTopic,
          queryParameters: {
            'category_id': catId,
            'vet_id':
                sl<SessionManager>().getUserDetails()!.data!.vetId.toString(),
          },
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = TrainingTopiclistModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, TrainingdetailModel>> getTrainingDetailAPI(String trainingId) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: getTrainingDetail,
          queryParameters: {
            'training_id': trainingId,
            'vet_id':
            sl<SessionManager>().getUserDetails()!.data!.vetId.toString(),
          },
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
      }
      final response = possibleData.getRight();
      final details = TrainingdetailModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, CommonResponseModel>> updateTrainingTimeAPI(String trainingId, String time) async {
    try {
      final possibleData = await baseAPIService.executeAPI(
          url: updateTrainingTime,
          queryParameters: {
            'training_id': trainingId,
            'vet_id':
            sl<SessionManager>().getUserDetails()!.data!.vetId.toString(),
            'time':time
          },
          apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error,
            errorCode: possibleData.getLeft()!.errorCode));
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
