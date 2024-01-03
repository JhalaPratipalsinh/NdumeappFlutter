import 'package:dartz/dartz.dart';
import 'package:ndumeappflutter/data/models/Withdraw_wallet_model.dart';
import 'package:ndumeappflutter/data/models/ndume_wallet_model.dart';

import '../core/failure.dart';
import '../data/models/updatewithdrawal_response_model.dart';

abstract class WalletRepository {
  Future<Either<Failure, NdumeWalletModel>> getNdumeWallet(String vetID);

  Future<Either<Failure, WithdrawWalletModel>> withdrawWallet(
      String amount, String mpeshaToken);

  Future<Either<Failure, UpdatewithdrawalResponseModel>> updateWithdrawalWallet(
      String vetId, String transectionId, String amount);
}
