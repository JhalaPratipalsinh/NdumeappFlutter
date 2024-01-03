import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ndumeappflutter/data/models/CountyListModel.dart';
import 'package:ndumeappflutter/data/models/SubcountyListModel.dart';
import 'package:ndumeappflutter/data/models/login_model.dart';
import 'package:ndumeappflutter/data/models/registration_model.dart';
import 'package:ndumeappflutter/data/models/registration_req_model.dart';
import 'package:ndumeappflutter/repository/login_registration_repository.dart';
import 'package:ndumeappflutter/repository/master_repository.dart';
import 'package:ndumeappflutter/screens/blocs/loginBloc/login_bloc.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([MasterRepository, LoginRegistrationRepository])
void main() {
  late MockMasterRepository masterRepository;
  late MockLoginRegistrationRepository loginRegistrationRepository;

  setUp(() {
    masterRepository = MockMasterRepository();
    loginRegistrationRepository = MockLoginRegistrationRepository();
  });

  group('test for Login Bloc with master repository', () {
    final countyList = CountyListModel(
      message: 'Success',
      data: [CountyList(county: 'Dummy')],
      success: true,
    );
    final subCountyList = SubcountyListModel(
      message: 'Success',
      data: [SubcountyList(county: 'Dummy', subcounty: 'SubCounty')],
      success: true,
    );

    test('Get County with Bloc Test', () async {
      final bloc = LoginBloc(masterRepository, loginRegistrationRepository);
      when(masterRepository.getCountyList())
          .thenAnswer((realInvocation) async => Right(countyList));
      bloc.add(const GetCountyEvent());
      emitsInOrder([
        LoginInitial(),
        const MasterLoadingState(),
        SetCountyState(countyList: countyList),
      ]);
    });

    test('Get Sub County with Bloc Test', () async {
      when(masterRepository.getSubCountyList('SubCounty'))
          .thenAnswer((realInvocation) async => Right(subCountyList));

      final bloc = LoginBloc(masterRepository, loginRegistrationRepository);

      bloc.add(const GetSubCountyEvent('SubCounty'));
      emitsInOrder([
        const MasterLoadingState(),
        SetSubCountyState(subCountyList: subCountyList),
      ]);
    });

    /*blocTest<LoginBloc, LoginState>(
      'Get County with Bloc Test',
      build: () { 
        when(masterRepository.getCountyList()).thenAnswer((realInvocation) async => Right(countyList));
        return LoginBloc(masterRepository, loginRegistrationRepository);},
      act: (bloc) {
        bloc.add(const GetCountyEvent());
      },
      expect: () => <LoginState>[
        LoginInitial(),
        const MasterLoadingState(),
        SetCountyState(countyList: countyList),
      ],
    );*/
  });

  group('test for Login Bloc with login repository', () {
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

    test('Initiate Login Event Test and check the Success response', () async {
      final bloc = LoginBloc(masterRepository, loginRegistrationRepository);
      when(loginRegistrationRepository.executeLoginAPI('8160231082', '0000'))
          .thenAnswer((realInvocation) async => Right(loginData));
      bloc.add(const InitiateLoginEvent('8160231082', '0000'));
      emitsInOrder([
        const MasterLoadingState(),
        LoginResponseState(response: loginData),
      ]);
    });

    test('Initiate Registration Event and Test check the Success response', () async {
      final bloc = LoginBloc(masterRepository, loginRegistrationRepository);
      when(loginRegistrationRepository.executeRegistrationAPI(registrationReqData))
          .thenAnswer((realInvocation) async => Right(registrationData));
      bloc.add(InitiateRegistrationEvent(registrationReqData));
      emitsInOrder([
        const MasterLoadingState(),
        RegistrationResponseState(response: registrationData),
      ]);
    });
  });
}
