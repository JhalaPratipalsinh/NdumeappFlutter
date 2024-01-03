import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/training_categorylist_model.dart';

import '../core/failure.dart';
import '../data/models/add_breeding_record_model.dart';
import '../data/models/training_topiclist_model.dart';
import '../data/models/trainingdetail_model.dart';

abstract class TrainingRepository{
  Future<Either<Failure, TrainingCategorylistModel>> getTrainingCatListAPI();

  Future<Either<Failure, TrainingTopiclistModel>> getTrainingTopicListAPI(String catId);

  Future<Either<Failure, TrainingdetailModel>> getTrainingDetailAPI(String trainingId);

  Future<Either<Failure, CommonResponseModel>> updateTrainingTimeAPI(String trainingId,String time);
}