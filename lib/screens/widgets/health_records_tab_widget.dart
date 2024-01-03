import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/cubits/healthRecordChangeTabCubit/health_record_change_tab_cubit.dart';

import '../../resources/color_constants.dart';

class HealthRecordsTabWidget extends StatefulWidget {
  final int treatmentCount;
  final int vaccineCount;
  final int dewormerCount;

  const HealthRecordsTabWidget(
      {required this.treatmentCount,
      required this.vaccineCount,
      required this.dewormerCount,
      Key? key})
      : super(key: key);

  @override
  State<HealthRecordsTabWidget> createState() => _HealthRecordsTabWidgetState();
}

class _HealthRecordsTabWidgetState extends State<HealthRecordsTabWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = context.read<HealthRecordChangeTabCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: ColorConstants.appColor,
      labelColor: ColorConstants.textColor2,
      controller: _tabController,
      unselectedLabelColor: ColorConstants.textColor2,
      indicator:
          BoxDecoration(color: ColorConstants.appColor, borderRadius: BorderRadius.circular(12)),
      onTap: (index) {
        context.read<HealthRecordChangeTabCubit>().changeTab(index);
      },
      tabs: ['TREATMENT', 'VACCINATION', 'DEWORMINGS']
          .map((e) => Tab(
                height: 70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (e == 'TREATMENT') ...[
                      Text(
                        '${widget.treatmentCount}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                    if (e == 'VACCINATION') ...[
                      Text(
                        '${widget.vaccineCount}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                    if (e == 'DEWORMINGS') ...[
                      Text(
                        '${widget.dewormerCount}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      e,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
