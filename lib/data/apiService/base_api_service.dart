import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/failure.dart';

enum ApiType { get, post, put, delete }

abstract class BaseAPIService {
  Future<Either<Failure, dynamic>> executeAPI(
      {String url, Map<String, dynamic> queryParameters, ApiType apiType});

  Future<Either<Failure, dynamic>> executeMpehsaAPI(
      {String url, Map<String, dynamic> queryParameters,String token, ApiType apiType});
}
