import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/cubits/breedingRecordChangeTabCubit/breeding_record_change_tab_cubit.dart';

import '../../data/models/breeding_model.dart';
import '../../resources/color_constants.dart';

class BreedingRecordsTabWidget extends StatefulWidget {
  final List<BreedingData> totalBreedingData;

  const BreedingRecordsTabWidget({required this.totalBreedingData, Key? key}) : super(key: key);

  @override
  State<BreedingRecordsTabWidget> createState() => _BreedingRecordsTabWidgetState();
}

class _BreedingRecordsTabWidgetState extends State<BreedingRecordsTabWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = context.read<BreedingRecordChangeTabCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    int totalBreedingCount = widget.totalBreedingData.length;
    int newBreedingCount = widget.totalBreedingData
        .where((e) {
          if (e.repeats == null) {
            return false;
          }
          return e.repeats == '0';
        })
        .toList()
        .length;
    int repeatBreedingCount = widget.totalBreedingData
        .where((e) {
          if (e.repeats == null) {
            return false;
          }
          return e.repeats != '0';
        })
        .toList()
        .length;

    return TabBar(
      indicatorColor: ColorConstants.appColor,
      labelColor: ColorConstants.textColor2,
      controller: _tabController,
      unselectedLabelColor: ColorConstants.textColor2,
      indicator:
          BoxDecoration(color: ColorConstants.appColor, borderRadius: BorderRadius.circular(12)),
      onTap: (index) {
        context.read<BreedingRecordChangeTabCubit>().changeTab(index);
      },
      tabs: ['Total AIs', 'New AIs', 'Repeat AIs'].map((e) {
        if (e == "Total AIs") {
          return Tab(
            height: 70,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$totalBreedingCount',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  e,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (e == "New AIs") {
          return Tab(
            height: 70,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$newBreedingCount',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  e,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return Tab(
            height: 70,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$repeatBreedingCount',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        }
      }).toList(),
    );
  }
}
