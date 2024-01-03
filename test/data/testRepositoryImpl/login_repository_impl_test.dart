import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/data/apiService/base_api_service.dart';
import 'package:ndumeappflutter/data/models/login_model.dart';
import 'package:ndumeappflutter/data/models/registration_model.dart';
import 'package:ndumeappflutter/data/models/registration_req_model.dart';
import 'package:ndumeappflutter/data/repositoryImpl/login_registration_repository_impl.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/util/constants.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([BaseAPIService, SessionManager])
void main() {
  late MockBaseAPIService mockBaseService;
  late MockSessionManager sessionManager;
  late LoginRegistrationRepositoryImpl repository;

  setUp(() {
    mockBaseService = MockBaseAPIService();
    sessionManager = MockSessionManager();
    repository = LoginRegistrationRepositoryImpl(
        apiService: mockBaseService, sessionManager: sessionManager);
  });

  group('test for Login Repository', () {
    final loginData = LoginModel(
        success: true,
        message: 'Success',
        data: Data(
            vetId: 1,
            accessToken: '',
            vetEmail: 'email',
            vetFname: 'test',
            vetPhone: '8160231082',
            vetSname: 'sname'));

    final registrationReqData = RegistrationReqModel(
      vetFName: 'FName',
      vetLName: 'LName',
      vetSName: 'SName',
      vetPhone: '8160231082',
      vetPassword: '0000',
      county: 'county',
      subCounty: 'subCounty',
      ward: 'ward',
      vetKvb: 'vetKvb',
      vetLat: 0.00,
      vetLong: 0.00,
    );

    final registrationData = RegistrationModel(success: true, message: 'Success');

    ///test Login Functionality
    test('should be able to login from network source', () async {
      //Arrange
      when(mockBaseService.executeAPI(
        url: authenticateAPI,
        queryParameters: {'vet_phone': '254070891', 'vet_password': '0000'},
        apiType: ApiType.post,
      )).thenAnswer((_) async => Right(loginData.toJson()));
      //Act
      final result = await repository.executeLoginAPI('254070891', '0000');

      //Assert
      verify(mockBaseService.executeAPI(
          url: authenticateAPI,
          queryParameters: {'vet_phone': '254070891', 'vet_password': '0000'},
          apiType: ApiType.post));
      verify(sessionManager.initiateUserLogin(result.getRight())).called(1);
      expect(result.getRight()!.success!, loginData.success!);
    });

    ///test Registration Functionality
    test('should be able to register from network source', () async {
      //Arrange
      when(mockBaseService.executeAPI(
        url: registerAPI,
        queryParameters: registrationReqData.toJson(),
        apiType: ApiType.post,
      )).thenAnswer((_) async => Right(registrationData.toJson()));

      //Act
      final result = await repository.executeRegistrationAPI(registrationReqData);

      //Assert
      verify(mockBaseService.executeAPI(
          url: registerAPI, queryParameters: registrationReqData.toJson(), apiType: ApiType.post));
      expect(result.getRight()!.success!, loginData.success!);
    });
  });
}
