import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ndumeappflutter/data/models/Withdraw_wallet_model.dart';
import 'package:ndumeappflutter/data/models/ndume_wallet_model.dart';

import '../../../core/logger.dart';
import '../../../data/models/updatewithdrawal_response_model.dart';
import '../../../repository/wallet_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletRepository repository;

  WalletBloc(this.repository) : super(const WalletInitial()) {
    on<WalletEvent>((event, emit) async {
      try {
        emit(const LoadingWalletState());
        if (event is FetchWalletEvent) {
          final possibleData = await repository.getNdumeWallet(event.vetID);
          final data = possibleData.fold(
              (l) => HandleWalletErrorState(message: l.error),
              (r) => HandleWalletState(response: r));
          emit(data);
        } else if (event is WithdrawWalletEvent) {
          final possibleData =
              await repository.withdrawWallet(event.amount, event.mpesaToken);
          final data = possibleData.fold(
              (l) => HandleWalletErrorState(message: l.error),
              (r) => HandleWithdrawWalletState(response: r));
          emit(data);
        } else if (event is UpdateWithdrawalWalletEvent) {
          final possibleData =
          await repository.updateWithdrawalWallet(event.vetID, event.transactionId,event.amount);
          final data = possibleData.fold(
                  (l) => HandleWalletErrorState(message: l.error),
                  (r) => UpdateWithdrawalState(response: r));
          emit(data);
        }
      } catch (e) {
        logger.e(e.toString());
        emit(HandleWalletErrorState(message: e.toString()));
      }
    });
  }
}
