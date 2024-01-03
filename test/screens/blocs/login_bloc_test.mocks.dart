// Mocks generated by Mockito 5.0.7 from annotations
// in ndumeappflutter/test/screens/blocs/login_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:ndumeappflutter/core/failure.dart' as _i5;
import 'package:ndumeappflutter/data/models/CountyListModel.dart' as _i6;
import 'package:ndumeappflutter/data/models/SubcountyListModel.dart' as _i7;
import 'package:ndumeappflutter/data/models/WardListModel.dart' as _i8;
import 'package:ndumeappflutter/data/models/login_model.dart' as _i10;
import 'package:ndumeappflutter/data/models/mpesa_login_model.dart' as _i13;
import 'package:ndumeappflutter/data/models/registration_model.dart' as _i11;
import 'package:ndumeappflutter/data/models/registration_req_model.dart' as _i12;
import 'package:ndumeappflutter/repository/login_registration_repository.dart' as _i9;
import 'package:ndumeappflutter/repository/master_repository.dart' as _i3;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [MasterRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMasterRepository extends _i1.Mock implements _i3.MasterRepository {
  MockMasterRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.CountyListModel>> getCountyList() =>
      (super.noSuchMethod(Invocation.method(#getCountyList, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i6.CountyListModel>>.value(
                  _FakeEither<_i5.Failure, _i6.CountyListModel>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i6.CountyListModel>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.SubcountyListModel>> getSubCountyList(String? county) =>
      (super.noSuchMethod(Invocation.method(#getSubCountyList, [county]),
              returnValue: Future<_i2.Either<_i5.Failure, _i7.SubcountyListModel>>.value(
                  _FakeEither<_i5.Failure, _i7.SubcountyListModel>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i7.SubcountyListModel>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i8.WardListModel>> getWardList(
          String? county, String? subCounty) =>
      (super.noSuchMethod(Invocation.method(#getWardList, [county, subCounty]),
              returnValue: Future<_i2.Either<_i5.Failure, _i8.WardListModel>>.value(
                  _FakeEither<_i5.Failure, _i8.WardListModel>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i8.WardListModel>>);
}

/// A class which mocks [LoginRegistrationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRegistrationRepository extends _i1.Mock implements _i9.LoginRegistrationRepository {
  MockLoginRegistrationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i10.LoginModel>> executeLoginAPI(
          String? mobileNo, String? password) =>
      (super.noSuchMethod(Invocation.method(#executeLoginAPI, [mobileNo, password]),
              returnValue: Future<_i2.Either<_i5.Failure, _i10.LoginModel>>.value(
                  _FakeEither<_i5.Failure, _i10.LoginModel>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i10.LoginModel>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i11.RegistrationModel>> executeRegistrationAPI(
          _i12.RegistrationReqModel? registrationReq) =>
      (super.noSuchMethod(Invocation.method(#executeRegistrationAPI, [registrationReq]),
              returnValue: Future<_i2.Either<_i5.Failure, _i11.RegistrationModel>>.value(
                  _FakeEither<_i5.Failure, _i11.RegistrationModel>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i11.RegistrationModel>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i13.MpesaLoginModel>> executeMpesaLoginAPI() =>
      (super.noSuchMethod(Invocation.method(#executeMpesaLoginAPI, []),
              returnValue: Future<_i2.Either<_i5.Failure, _i13.MpesaLoginModel>>.value(
                  _FakeEither<_i5.Failure, _i13.MpesaLoginModel>()))
          as _i4.Future<_i2.Either<_i5.Failure, _i13.MpesaLoginModel>>);
}