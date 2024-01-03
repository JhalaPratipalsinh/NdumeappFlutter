import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/login_model.dart';
import 'package:ndumeappflutter/data/models/mpesa_login_model.dart';
import 'package:ndumeappflutter/data/models/registration_model.dart';
import 'package:ndumeappflutter/data/models/registration_req_model.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/repository/login_registration_repository.dart';

import '../../core/logger.dart';
import '../../util/constants.dart';
import '../apiService/base_api_service.dart';

class LoginRegistrationRepositoryImpl implements LoginRegistrationRepository {
  final BaseAPIService apiService;
  final SessionManager sessionManager;

  const LoginRegistrationRepositoryImpl({required this.apiService, required this.sessionManager});

  @override
  Future<Either<Failure, LoginModel>> executeLoginAPI(String mobileNo, String password) async {
    //final token = sessionManager.getToken() as String;
    try {
      final possibleData = await apiService.executeAPI(
        url: authenticateAPI,
        queryParameters: {'vet_phone': mobileNo, 'vet_password': password},
        apiType: ApiType.post,
      );
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error));
      }
      final response = possibleData.getRight();
      final details = LoginModel.fromJson(response);
      if (details.success!) {
        sessionManager.initiateUserLogin(details);
      } else {
        return left(Failure(details.message!));
      }
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, RegistrationModel>> executeRegistrationAPI(
      RegistrationReqModel registrationReq) async {
    //final token = sessionManager.getToken() as String;
    try {
      final possibleData = await apiService.executeAPI(
          url: registerAPI, queryParameters: registrationReq.toJson(), apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error));
      }
      final response = possibleData.getRight();
      final details = RegistrationModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, MpesaLoginModel>> executeMpesaLoginAPI() async {
    try {
      final possibleData = await apiService.executeAPI(
        url: mpesaLoginAPI,
        queryParameters: {"username": "ndume@gmail.com", "password": "ApONDSMply"},
        apiType: ApiType.post,
      );
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error));
      }
      final response = possibleData.getRight();
      final details = MpesaLoginModel.fromJson(response);
      //sessionManager.setMpesaToken(details.token!);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, CommonResponseModel>> changePasswordAPI(String oldPass,String newPass) async {
    try {
      final possibleData = await apiService.executeAPI(
          url: changePasswordapi, queryParameters: {"vet_id":sessionManager.getUserDetails()!.data!.vetId,"vet_old_password":oldPass,"vet_new_password":newPass}, apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error));
      }
      final response = possibleData.getRight();
      final details = CommonResponseModel.fromJson(response);
      return Right(details);
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure('Unexpected Error occurred'));
    }
  }

  @override
  Future<Either<Failure, CommonResponseModel>> forgotPassword(String mobile) async {
    try {
      final possibleData = await apiService.executeAPI(
          url: forgotapi, queryParameters: {"vet_phone":mobile}, apiType: ApiType.post);
      if (possibleData.isLeft()) {
        return left(Failure(possibleData.getLeft()!.error));
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
