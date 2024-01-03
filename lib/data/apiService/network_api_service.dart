import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/core/logger.dart';
import 'package:ndumeappflutter/data/apiService/base_api_service.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';

class NetworkAPIService implements BaseAPIService {
  final Dio dio;
  final Connectivity connectivity;
  final SessionManager sessionManager;

  const NetworkAPIService(
      {required this.dio,
      required this.connectivity,
      required this.sessionManager});

  @override
  Future<Either<Failure, dynamic>> executeAPI(
      {String? url,
      Map<String, dynamic>? queryParameters,
      ApiType? apiType}) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      logger.i('$url Request:  $queryParameters');
      String token = '';
      if (sessionManager.isUserLoggedIn()) {
        token = sessionManager.getToken();
      }

      logger.i('Access Token:  $token');

      try {
        late Response response;
        if (apiType == ApiType.get) {
          response = queryParameters!.isEmpty
              ? await dio.get(
                  url!,
                  options: Options(
                    headers: {"Authorization": 'Bearer $token'},
                  ),
                )
              : await dio.get(
                  url!,
                  queryParameters: queryParameters,
                  options: Options(
                    headers: {"Authorization": 'Bearer $token'},
                  ),
                );
        } else if (apiType == ApiType.post) {
          response = await dio.post(url!,
              data: queryParameters,
              options: Options(
                headers: {"Authorization": 'Bearer $token'},
              ));
        } else if (apiType == ApiType.delete) {
          response = await dio.delete(url!,
              data: queryParameters,
              options: Options(
                headers: {"Authorization": 'Bearer $token'},
              ));
        } else {
          response = await dio.put(url!,
              data: queryParameters,
              options: Options(
                headers: {"Authorization": 'Bearer $token'},
              ));
        }

        logger.i('$url Response : ${response.data}');

        return right(response.data);
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 422 || e.response!.statusCode == 404) {
            final message = e.response!.data['message'].toString();
            logger.i(
                '$url Response : $message \nStatus Code : ${e.response!.statusCode}');
            return left(Failure(message, errorCode: e.response!.statusCode!));
          }
        }
        return left(Failure(e.message!));
      } on SocketException catch (e) {
        logger.e(e);
        return left(const Failure('Please check the network connection'));
      } on Exception catch (e) {
        logger.e(e);
        return left(const Failure('Unexpected Error occurred'));
      }
    } else {
      return left(const Failure('Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> executeMpehsaAPI(
      {String? url,
      Map<String, dynamic>? queryParameters,
      String? token,
      ApiType? apiType}) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      logger.i('$url Request:  $queryParameters');
      logger.i('Access Token:  $token');

      try {
        late Response response;
        if (apiType == ApiType.get) {
          response = queryParameters!.isEmpty
              ? await dio.get(
                  url!,
                  options: Options(
                    headers: {"Authorization": 'Bearer $token'},
                  ),
                )
              : await dio.get(
                  url!,
                  queryParameters: queryParameters,
                  options: Options(
                    headers: {"Authorization": 'Bearer $token'},
                  ),
                );
        } else if (apiType == ApiType.post) {
          response = await dio.post(url!,
              data: queryParameters,
              options: Options(
                headers: {"Authorization": 'Bearer $token'},
              ));
        } else if (apiType == ApiType.delete) {
          response = await dio.delete(url!,
              data: queryParameters,
              options: Options(
                headers: {"Authorization": 'Bearer $token'},
              ));
        } else {
          response = await dio.put(url!,
              data: queryParameters,
              options: Options(
                headers: {"Authorization": 'Bearer $token'},
              ));
        }

        logger.i('$url Response : ${response.data}');

        return right(response.data);
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 422 || e.response!.statusCode == 404) {
            final message = e.response!.data['message'].toString();
            logger.i(
                '$url Response : $message \nStatus Code : ${e.response!.statusCode}');
            return left(Failure(message, errorCode: e.response!.statusCode!));
          }
        }
        return left(Failure(e.message!));
      } on SocketException catch (e) {
        logger.e(e);
        return left(const Failure('Please check the network connection'));
      } on Exception catch (e) {
        logger.e(e);
        return left(const Failure('Unexpected Error occurred'));
      }
    } else {
      return left(const Failure('Please check your internet connection'));
    }
  }
}
