import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/core/either_extension_function.dart';
import 'package:ndumeappflutter/core/failure.dart';
import 'package:ndumeappflutter/data/apiService/base_api_service.dart';
import 'package:ndumeappflutter/data/models/Withdraw_wallet_model.dart';
import 'package:ndumeappflutter/data/models/ndume_wallet_model.dart';
import 'package:ndumeappflutter/repository/wallet_repository.dart';

import '../../injection_container.dart';
import '../../util/common_functions.dart';
import '../../util/constants.dart';
import '../models/updatewithdrawal_response_model.dart';
import '../sessionManager/session_manager.dart';

class WalletRepositoryImpl implements WalletRepository {
  BaseAPIService baseAPIService;
  SessionManager sessionManager;

  WalletRepositoryImpl(this.baseAPIService, this.sessionManager);

  @override
  Future<Either<Failure, NdumeWalletModel>> getNdumeWallet(String vetID) async {
    final possibleData = await baseAPIService.executeAPI(
        url: '$getNdumeWalletAPI$vetID',
        queryParameters: {},
        apiType: ApiType.get);
    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }
    final response = possibleData.getRight();
    final details = NdumeWalletModel.fromJson(response);
    return Right(details);
  }

  @override
  Future<Either<Failure, WithdrawWalletModel>> withdrawWallet(
      String amount, String mpeshaToken) async {
    final mobileNumber = sl<CommonFunctions>()
        .checkNumberIsValid(sessionManager.getUserDetails()!.data!.vetPhone!);
    final possibleData = await baseAPIService.executeMpehsaAPI(
        url: withMpesaAPI,
        queryParameters: {'amount': amount, 'phoneNumber': mobileNumber},
        token: mpeshaToken,
        apiType: ApiType.post);
    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }
    final response = possibleData.getRight();
    final details = WithdrawWalletModel.fromJson(response);
    return Right(details);
  }

  @override
  Future<Either<Failure, UpdatewithdrawalResponseModel>> updateWithdrawalWallet(
      String vetId, String transectionId, String amount) async {
    final possibleData = await baseAPIService.executeAPI(
        url: updateWithdrawalWalletAPI,
        queryParameters: {
          'vet_id': vetId,
          'transaction_id': transectionId,
          'amount': amount
        },
        apiType: ApiType.post);
    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }
    final response = possibleData.getRight();
    final details = UpdatewithdrawalResponseModel.fromJson(response);
    return Right(details);
  }
}
