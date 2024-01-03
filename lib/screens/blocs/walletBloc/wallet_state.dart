part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  const WalletInitial();

  @override
  List<Object> get props => [];
}

class LoadingWalletState extends WalletState {
  const LoadingWalletState();

  @override
  List<Object> get props => [];
}

class HandleWalletState extends WalletState {
  final NdumeWalletModel response;

  const HandleWalletState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleWithdrawWalletState extends WalletState {
  final WithdrawWalletModel response;

  const HandleWithdrawWalletState({required this.response});

  @override
  List<Object> get props => [response];
}

class UpdateWithdrawalState extends WalletState {
  final UpdatewithdrawalResponseModel response;

  const UpdateWithdrawalState({required this.response});

  @override
  List<Object> get props => [response];
}

class HandleWalletErrorState extends WalletState {
  final String message;
  final int errorCode;

  const HandleWalletErrorState({required this.message, this.errorCode = 0});

  @override
  List<Object> get props => [message, errorCode];
}
