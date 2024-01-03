part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class FetchWalletEvent extends WalletEvent {
  final String vetID;

  const FetchWalletEvent({required this.vetID});

  @override
  List<Object?> get props => [vetID];
}

class WithdrawWalletEvent extends WalletEvent {
  final String amount;
  final String mpesaToken;
  const WithdrawWalletEvent({required this.amount, required this.mpesaToken});

  @override
  List<Object?> get props => [amount, mpesaToken];
}

class UpdateWithdrawalWalletEvent extends WalletEvent {
  final String vetID;
  final String transactionId;
  final String amount;

  const UpdateWithdrawalWalletEvent(
      {required this.vetID, required this.transactionId, required this.amount});

  @override
  List<Object?> get props => [vetID, transactionId, amount];
}
