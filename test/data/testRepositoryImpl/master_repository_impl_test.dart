import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/apiService/base_api_service.dart';
import 'package:ndumeappflutter/data/models/CountyListModel.dart';
import 'package:ndumeappflutter/data/models/SubcountyListModel.dart';
import 'package:ndumeappflutter/data/models/WardListModel.dart';
import 'package:ndumeappflutter/data/repositoryImpl/master_repository_impl.dart';
import 'package:ndumeappflutter/util/constants.dart';

import 'master_repository_impl_test.mocks.dart';

@GenerateMocks([BaseAPIService])
void main() {
  late MasterRepositoryImpl masterRepositoryImpl;
  late MockBaseAPIService mockBaseService;

  setUp(() {
    mockBaseService = MockBaseAPIService();
    masterRepositoryImpl = MasterRepositoryImpl(mockBaseService);
  });

  group('test for master repository', () {
    final countyList = CountyListModel(
      message: 'Success',
      data: [CountyList(county: 'Dummy')],
      success: true,
    );

    final subCountyList = SubcountyListModel(
      message: 'Success',
      data: [SubcountyList(county: 'Dummy', subcounty: 'Test')],
      success: true,
    );

    final wardList = WardListModel(
      message: 'Success',
      data: [WardList(county: 'Dummy', subcounty: 'Test', ward: 'ward')],
      success: true,
    );

    ///test county list access
    test('should return county list from network source', () async {
      //Arrange
      when(mockBaseService.executeAPI(url: countyAPI, queryParameters: {}, apiType: ApiType.get))
          .thenAnswer((_) async => Right(countyList.toJson()));
      //Act
      final result = await masterRepositoryImpl.getCountyList();

      //Assert
      verify(mockBaseService.executeAPI(url: countyAPI, queryParameters: {}, apiType: ApiType.get));
      expect(result.getRight()!.success!, countyList.success!);
    });

    ///test sub county list access
    test('should return sub county list from network source', () async {
      //Arrange
      when(mockBaseService.executeAPI(
              url: subCountyAPI, queryParameters: {"county": 'Dummy'}, apiType: ApiType.get))
          .thenAnswer((_) async => Right(subCountyList.toJson()));
      //Act
      final result = await masterRepositoryImpl.getSubCountyList('Dummy');

      //Assert
      verify(mockBaseService.executeAPI(
          url: subCountyAPI, queryParameters: {"county": 'Dummy'}, apiType: ApiType.get));
      expect(result.getRight()!.data![0].county!, countyList.data![0].county);
    });

    ///test ward list access
    test('should return ward list from network source', () async {
      //Arrange
      when(mockBaseService.executeAPI(
              url: wardAPI,
              queryParameters: {"county": 'Dummy', "subcounty": 'Test'},
              apiType: ApiType.get))
          .thenAnswer((_) async => Right(wardList.toJson()));
      //Act
      final result = await masterRepositoryImpl.getWardList('Dummy', 'Test');

      //Assert
      verify(mockBaseService.executeAPI(
          url: wardAPI,
          queryParameters: {"county": 'Dummy', "subcounty": 'Test'},
          apiType: ApiType.get));
      expect(result.getRight()!.data![0].subcounty!, wardList.data![0].subcounty!);
    });

    ///test failure if get access
    test('should return failure if something went wrong', () async {
      //Arrange
      when(mockBaseService.executeAPI(url: countyAPI, queryParameters: {}, apiType: ApiType.get))
          .thenAnswer((_) async => const Left(Failure('Something went wrong')));

      //Act
      final result = await masterRepositoryImpl.getCountyList();

      //Assert
      verify(mockBaseService.executeAPI(url: countyAPI, queryParameters: {}, apiType: ApiType.get));
      expect(result.getLeft()!.error, 'Something went wrong');
    });
  });
}
