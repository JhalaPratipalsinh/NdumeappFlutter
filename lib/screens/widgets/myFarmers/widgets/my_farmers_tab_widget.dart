import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/color_constants.dart';
import '../../../cubits/myfarmersChangeTabCubit/my_farmers_change_tab_cubit.dart';

class MyFarmersTabWidget extends StatefulWidget {
  const MyFarmersTabWidget({Key? key}) : super(key: key);

  @override
  State<MyFarmersTabWidget> createState() => _MyFarmersTabWidgetState();
}

class _MyFarmersTabWidgetState extends State<MyFarmersTabWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: ColorConstants.appColor,
      labelColor: ColorConstants.textColor2,
      controller: _tabController,
      unselectedLabelColor: ColorConstants.textColor2,
      indicator: BoxDecoration(
          color: ColorConstants.appColor,
          borderRadius: BorderRadius.circular(12)),
      onTap: (index) {
        context.read<MyFarmersChangeTabCubit>().changeTab(index);
      },
      tabs: const [
        Tab(
          height: 50,
          child: Text(
            'My Farmers',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Tab(
          height: 50,
          child: Text(
            'Farmers in need of service',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
