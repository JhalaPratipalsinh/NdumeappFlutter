import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';
import 'package:ndumeappflutter/screens/blocs/farmerBloc/farmer_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/healthRecordBloc/health_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/trainingBloc/trainingk_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/breeding_records_widget.dart';
import 'package:ndumeappflutter/screens/widgets/changePasswordWidget.dart';
import 'package:ndumeappflutter/screens/widgets/drawer_widget.dart';
import 'package:ndumeappflutter/screens/widgets/health_records_widget.dart';
import 'package:ndumeappflutter/screens/widgets/home_widget.dart';
import 'package:ndumeappflutter/screens/widgets/ndume_wallet_widget.dart';

import '../data/sessionManager/session_manager.dart';
import '../injection_container.dart';
import '../resources/image_resources.dart';
import 'blocs/breedingBloc/breeding_bloc.dart';
import 'blocs/walletBloc/wallet_bloc.dart';
import 'cubits/homeChangeWidgetCubit/home_change_widget_cubit.dart';
import 'trainingCategoryListActivity.dart';
import 'widgets/myFarmers/my_farmer_widget.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity>
    with SingleTickerProviderStateMixin {
  late List<Widget> _widgetOptions;
  final PageStorageBucket _bucket = PageStorageBucket();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _widgetOptions = <Widget>[
      const HomeWidget(
        key: PageStorageKey('home'),
      ),
      const TrainingCategoryList(
        key: PageStorageKey('trainingCategory'),
      ),
      const MyFarmerWidget(
        key: PageStorageKey('myFarmers'),
      ),
      const BreedingRecordsWidget(
        key: PageStorageKey('breedingRecords'),
      ),
      const HealthRecordsWidget(
        key: PageStorageKey('healthRecords'),
      ),
      const NdumeWalletWidget(
        key: PageStorageKey('ndumeWallet'),
      ),
      const ChangePasswordWidget(
        key: PageStorageKey('changePassword'),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() {
          if (context.read<HomeChangeWidgetCubit>().state == 0) {
            return true;
          } else {
            context.read<HomeChangeWidgetCubit>().changeHomeWidget(0);
            return false;
          }
        });
      },
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          backgroundColor: ColorConstants.appColor,
          leading: Builder(builder: (ctx) {
            return IconButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    ImageResources.menuIcon,
                    color: ColorConstants.colorAccent,
                  ),
                ));
          }),
          title: BlocBuilder<HomeChangeWidgetCubit, int>(
            builder: (_, pos) {
              String title = '';
              if (pos == 0) {
                title = 'Home';
              } else if (pos == 1) {
                title = 'Training categories';
                context.read<TrainingkBloc>().add(const GetTrainingCategoryList());
              } else if (pos == 2) {
                title = 'My Farmers';
                // final vetID =
                //     '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
                // context.read<FarmerBloc>().add(FetchFarmersEvent(vetID: vetID));
              } else if (pos == 3) {
                title = 'Breeding Records';
                final vetID =
                    '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
                context.read<BreedingBloc>().add(FetchBreedingEvent(
                    mobileNoOrVetId: vetID, isMobileNo: false));
              } else if (pos == 4) {
                title = 'Health Records';
                final vetID =
                    '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
                context.read<HealthBloc>().add(FetchHealthRecordEvent(
                    mobileNoOrVetId: vetID, isMobileNo: false));
              } else if (pos == 5) {
                title = 'Ndume Wallet';
                String vetId =
                    '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
                context.read<WalletBloc>().add(FetchWalletEvent(vetID: vetId));
              } else if (pos == 6) {
                title = 'Change Password';
              }
              return Text(
                title,
                style: const TextStyle(color: ColorConstants.colorAccent),
              );
            },
          ),
        ),
        body: BlocBuilder<HomeChangeWidgetCubit, int>(
          builder: (_, state) {
            return IndexedStack(
              index: state,
              children: _widgetOptions,
            );
          },
        ),
        /*bottomNavigationBar: BlocBuilder<HomeChangeWidgetCubit, int>(
          builder: (_, pos) {
            if (pos == 0) {
              return menu();
            } else if (pos == 6) {
              return menu();
            } else {
              return SizedBox();
            }
          },
        ),*/
      ),
    );
  }

  /*Widget menu() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: ColorConstants.colorPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(0.0, -3.0), //(x,y)
            blurRadius: 1.0,
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: ColorConstants.colorAccent,
        unselectedLabelColor: ColorConstants.colorAccent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        indicatorColor: Colors.white,
        onTap: (int index) {
          if (index == 0) {
            context.read<HomeChangeWidgetCubit>().changeHomeWidget(0);
          } else {
            context.read<HomeChangeWidgetCubit>().changeHomeWidget(6);
          }
        },
        tabs: [
          Tab(
            text: "Farmer",
            icon: Image.asset(
              'assets/icons/ic_tab_farmer.png',
              // Path to your custom icon asset
              width: 24, // Customize the icon size
              height: 24,
              color: ColorConstants.colorAccent,
            ),
            iconMargin: EdgeInsets.all(4),
          ),
          Tab(
            text: "Training",
            icon: Image.asset(
              'assets/icons/ic_tab_training.png',
              // Path to your custom icon asset
              width: 24, // Customize the icon size
              height: 24,
              color: ColorConstants.colorAccent,
            ),
            iconMargin: EdgeInsets.all(4),
          ),
        ],
      ),
    );
  }*/
}
