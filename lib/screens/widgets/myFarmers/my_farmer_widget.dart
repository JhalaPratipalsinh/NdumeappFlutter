import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/myFarmers/widgets/farmers_in_need_of_service_widget.dart';
import '../../../resources/color_constants.dart';
import '../../cubits/myfarmersChangeTabCubit/my_farmers_change_tab_cubit.dart';
import 'widgets/my_farmers_data_widget.dart';
import 'widgets/my_farmers_tab_widget.dart';

class MyFarmerWidget extends StatefulWidget {
  const MyFarmerWidget({Key? key}) : super(key: key);

  @override
  State<MyFarmerWidget> createState() => _MyFarmerWidgetState();
}

class _MyFarmerWidgetState extends State<MyFarmerWidget> {
  //final _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      appBar: AppBar(
        title: null,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(15),
            child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: MyFarmersTabWidget())),
      ),
      body: BlocBuilder<MyFarmersChangeTabCubit, int>(builder: (_, state) {
        return state == 0
            ? const MyFarmersDataWidget()
            : const FarmersInNeedOfServiceWidget();
      }),
    );
  }
}
