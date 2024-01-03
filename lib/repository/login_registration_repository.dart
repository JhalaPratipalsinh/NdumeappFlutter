import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/data/models/Common_response_model.dart';
import 'package:ndumeappflutter/data/models/login_model.dart';
import 'package:ndumeappflutter/data/models/mpesa_login_model.dart';
import 'package:ndumeappflutter/data/models/registration_model.dart';
import 'package:ndumeappflutter/data/models/registration_req_model.dart';

import '../core/failure.dart';

abstract class LoginRegistrationRepository {
  Future<Either<Failure, LoginModel>> executeLoginAPI(String mobileNo, String password);

  Future<Either<Failure, RegistrationModel>> executeRegistrationAPI(
      RegistrationReqModel registrationReq);

  Future<Either<Failure, MpesaLoginModel>> executeMpesaLoginAPI();

  Future<Either<Failure, CommonResponseModel>> changePasswordAPI(String oldPass,String newPass);

  Future<Either<Failure, CommonResponseModel>> forgotPassword(String mobile);
}
