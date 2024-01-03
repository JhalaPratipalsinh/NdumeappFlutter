import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';
import 'package:ndumeappflutter/resources/image_resources.dart';
import 'package:ndumeappflutter/screens/blocs/walletBloc/wallet_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/custom_button.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import '../../injection_container.dart';
import '../../util/constants.dart';
import '../blocs/breedingBloc/breeding_bloc.dart';
import '../blocs/healthRecordBloc/health_bloc.dart';

class NdumeWalletWidget extends StatefulWidget {
  const NdumeWalletWidget({Key? key}) : super(key: key);

  @override
  State<NdumeWalletWidget> createState() => _NdumeWalletWidgetState();
}

class _NdumeWalletWidgetState extends State<NdumeWalletWidget> {
  @override
  void initState() {
    super.initState();
//    context.read<LoginBloc>().add(const MpesaLoginEvent());
    //fetchWalletDetails();
    /*String vetId = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
    context.read<WalletBloc>().add(FetchWalletEvent(vetID: vetId));*/
  }

  void fetchWalletDetails() {
    String vetId = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
    context.read<WalletBloc>().add(FetchWalletEvent(vetID: vetId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          /*child: Center(child: Text(
            "Under Progress",
            style: const TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),),*/
          child: BlocBuilder<WalletBloc, WalletState>(
            builder: (_, state) {
              if (state is LoadingWalletState) {
                return const LoadingWidget();
              } else if (state is HandleWalletState) {
                final wallet = state.response;
                int totalBalance =
                (wallet.totalBreedingAmount! + wallet.totalHealthAmount!)-wallet.totalWithdrawlAmount!;
                return Column(
                  children: [
                    NdumeWalletChildWidget(
                        title: 'Total Breeding Record',
                        icon: ImageResources.breedingIcon,
                        details: '${wallet.totalBreedingRecord!}'),
                    const Divider(
                      color: Colors.white,
                    ),
                    NdumeWalletChildWidget(
                        title: 'Total Health Record',
                        icon: ImageResources.healthRecordIcon,
                        details: '${wallet.totalHealthRecord!}'),
                    const Divider(
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () {
                        final vetID = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
                        context
                            .read<BreedingBloc>()
                            .add(FetchBreedingEvent(mobileNoOrVetId: vetID, isMobileNo: false,isVerified: true));
                        Navigator.pushNamed(context, verifiedBreedingRecordList,
                            arguments: '');
                      },
                      child: NdumeWalletChildWidget(
                          title: 'Verified Breeding Records',
                          icon: ImageResources.checkboxIcon,
                          details: '${wallet.totalVerifiedBreedingRecord}'),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () {
                        final vetID = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
                        context
                            .read<HealthBloc>()
                            .add(FetchHealthRecordEvent(mobileNoOrVetId: vetID, isMobileNo: false,isVerified: true));
                        Navigator.pushNamed(context, verifiedHealthRecordList,
                            arguments: '');
                      },
                      child: NdumeWalletChildWidget(
                          title: 'Verified Health Records',
                          icon: ImageResources.checkboxIcon,
                          details: '${wallet.totalVerifiedHealthRecord}'),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    NdumeWalletChildWidget(
                        title: 'Total Balance',
                        icon: ImageResources.balanceIcon,
                        details: 'Ksh. $totalBalance'),
                    const Divider(
                      color: Colors.white,
                    ),
                    NdumeWalletChildWidget(
                        title: 'Total amount withdrawn',
                        icon: ImageResources.withdrawIcon,
                        details: 'Ksh. ${wallet.totalWithdrawlAmount}'),
                    const Divider(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonWidget(
                      buttonText: 'Withdraw',
                      onPressButton: () {
                        Navigator.pushNamed(context, walletWithdraw,
                            arguments: {
                              'totalBalance': '${totalBalance}',
                              'minAmount': wallet.minWithdrawlAmount,
                              'maxAmount': wallet.maxWithdrawalAmount,
                            });
                      },
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "Data not Found",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class NdumeWalletChildWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String details;

  const NdumeWalletChildWidget({
    required this.title,
    required this.icon,
    required this.details,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: 50,
          width: 50,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              color: ColorConstants.appColor,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
              child: Text(
            details,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        )
      ],
    );
  }
}
