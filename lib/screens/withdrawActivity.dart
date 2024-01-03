import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/walletBloc/wallet_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';

import '../data/sessionManager/session_manager.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../resources/image_resources.dart';
import '../util/common_functions.dart';
import 'blocs/loginBloc/login_bloc.dart';
import 'widgets/custom_button.dart';
import 'widgets/inputfields.dart';

class WithdrawActivity extends StatefulWidget {
  final String walletAmount;
  final int minAmount;
  final int maxAmount;

  const WithdrawActivity({required this.walletAmount, Key? key, required this.minAmount, required this.maxAmount})
      : super(key: key);

  @override
  State<WithdrawActivity> createState() => _WithdrawActivityState();
}

class _WithdrawActivityState extends State<WithdrawActivity> {
  final withdrawController = TextEditingController();
  String responseMsg="";

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const MpesaLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    /*return BlocListener<WalletBloc, WalletState>(
      listener: (_, state) {
        if (state is HandleWalletErrorState) {
          showMessage(state.message);
        } else if (state is HandleWithdrawWalletState) {
          showMessage(state.response.responseDescription!);
          Navigator.of(context).pop();
        }
      },*/
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorConstants.colorPrimaryDark,
        appBar: AppBar(
          backgroundColor: ColorConstants.appColor,
          title: const Text(
            'Withdraw Amount',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => onWillPop(),
          ),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (_, tokenState) {
            if (tokenState is MasterLoadingState) {
              return const LoadingWidget();
            } else if (tokenState is MpesaLoginResponseState) {
              print("Mpesha token : " + tokenState.response.token!);
              return Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Wallet Amount : ${widget.walletAmount} Ksh',
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'You can withdraw this amount by clicking on button',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.yellow),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                     InputTextField(
                         controller: withdrawController,
                         hint: "Enter withdrawal amount",
                         inputType: TextInputType.number,
                         inputIcon: ImageResources.withdrawIcon),
                     const SizedBox(
                       height: 20,
                     ),
                    BlocBuilder<WalletBloc, WalletState>(
                      builder: (_, state) {
                        if (state is LoadingWalletState) {
                          return const LoadingWidget();
                        } else if (state is HandleWithdrawWalletState) {
                          responseMsg=state.response.responseDescription!;
                          updateWalletStatus(state.response.conversationID!);
                          return Text(
                            responseMsg,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                          );
                        } else if (state is UpdateWithdrawalState) {
                          String vetId = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
                          context.read<WalletBloc>().add(FetchWalletEvent(vetID: vetId));
                          Navigator.pop(context);
                          showMessage("Your withdraw request sucessfully placed..");
                          return Text(
                            responseMsg,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                          );
                        } else {
                          return ButtonWidget(
                            buttonText: 'Withdraw',
                            onPressButton: () async {
                              validateAmountAndWithdraw(
                                  tokenState.response.token!);
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Plese wait we are loading..",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
      onWillPop: onWillPop,
    );
  }

  Future<bool> onWillPop() {
    String vetId = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
    context.read<WalletBloc>().add(FetchWalletEvent(vetID: vetId));
    Navigator.pop(context);
    return Future.value(true);
  }

  void updateWalletStatus(String transectionId) {
    context.read<WalletBloc>().add(UpdateWithdrawalWalletEvent(
        vetID: sl<SessionManager>().getUserDetails()!.data!.vetId.toString(),
        transactionId: transectionId,
        amount: withdrawController.text));
  }

  void validateAmountAndWithdraw(String mpeshaToken) {

    double walletAmount = double.parse(withdrawController.text);

    if(walletAmount > double.parse(widget.walletAmount)){
      return showMessage('you can not withdraw more than your balance');
    } else if (walletAmount < widget.minAmount) {
      return showMessage('you can not withdraw below ksh${widget.minAmount}');
    }else if(walletAmount > widget.maxAmount){
      return showMessage('you are trying to withdrawal more than ksh${widget.maxAmount}, please enter less amount than maximum amount limit');
    } else {
      context.read<WalletBloc>().add(WithdrawWalletEvent(
          amount: '$walletAmount', mpesaToken: mpeshaToken));
    }
  }

  void showMessage(String message, {int duration = 2}) {
    sl<CommonFunctions>()
        .showSnackBar(context: context, message: message, duration: duration);
  }
}
