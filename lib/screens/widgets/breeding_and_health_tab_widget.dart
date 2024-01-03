import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/color_constants.dart';
import '../cubits/breedingAndHealthChangeTabCubit/breeding_and_health_change_tab_cubit.dart';

class BreedingAndHealthTabWidget extends StatefulWidget {
  const BreedingAndHealthTabWidget({Key? key}) : super(key: key);

  @override
  State<BreedingAndHealthTabWidget> createState() => _BreedingAndHealthTabWidgetState();
}

class _BreedingAndHealthTabWidgetState extends State<BreedingAndHealthTabWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.white,
      labelColor: ColorConstants.textColor2,
      controller: _tabController,
      unselectedLabelColor: ColorConstants.textColor2,
      indicatorWeight: 4,
      onTap: (index) {
        context.read<BreedingAndHealthChangeTabCubit>().changeTab(index);
      },
      tabs: ['BREEDING', 'HEALTH']
          .map((e) => Tab(
                height: 60,
                child: Text(
                  e,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ))
          .toList(),
    );
  }
}
