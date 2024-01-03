import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/addBreedingRecordActivity.dart';
import 'package:ndumeappflutter/screens/addHealthRecordTreatmentActivity.dart';
import 'package:ndumeappflutter/screens/widgets/breeding_and_health_tab_widget.dart';
import 'package:ndumeappflutter/util/constants.dart';

import '../resources/color_constants.dart';
import '../resources/image_resources.dart';
import 'cubits/breedingAndHealthChangeTabCubit/breeding_and_health_change_tab_cubit.dart';

class BreedingRecordManagementActivity extends StatefulWidget {
  const BreedingRecordManagementActivity({Key? key}) : super(key: key);

  @override
  State<BreedingRecordManagementActivity> createState() => _BreedingRecordManagementActivityState();
}

class _BreedingRecordManagementActivityState extends State<BreedingRecordManagementActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.colorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: BlocBuilder<BreedingAndHealthChangeTabCubit, int>(
          builder: (_, state) {
            return Text(
              state == 0 ? 'Breeding Record Management' : 'Health Record Management',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const BreedingAndHealthTabWidget(),
          const Divider(
            height: 0.5,
            color: Colors.white,
          ),
          Expanded(
            child: BlocBuilder<BreedingAndHealthChangeTabCubit, int>(
              builder: (_, state) {
                return state == 0
                    ? ListView(
                        shrinkWrap: true,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, /*addHealthRecord*/ addBreedingRecord,
                                  arguments: BreedingType.newBreeding);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Text(
                                    'New Artificial Insemination (AI)',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    ImageResources.rightArrowIcon,
                                    height: 30,
                                    width: 30,
                                    color: ColorConstants.appColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, /*addHealthRecord*/ addBreedingRecord,
                                  arguments: BreedingType.repeatBreeding);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Text(
                                    'Repeat Artificial Insemination (AI)',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    ImageResources.rightArrowIcon,
                                    height: 30,
                                    width: 30,
                                    color: ColorConstants.appColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, addPregnancyStatus);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Text(
                                    'Confirm Pregnancy',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    ImageResources.rightArrowIcon,
                                    height: 30,
                                    width: 30,
                                    color: ColorConstants.appColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, viewEditBreedingRecords);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Text(
                                    'Farmers History on Breeding',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    ImageResources.rightArrowIcon,
                                    height: 30,
                                    width: 30,
                                    color: ColorConstants.appColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, addHealthRecord,
                                  arguments: HealthType.treatment);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Text(
                                    'Treatment',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    ImageResources.rightArrowIcon,
                                    height: 30,
                                    width: 30,
                                    color: ColorConstants.appColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, addHealthRecord,
                                  arguments: HealthType.vaccine);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Text(
                                    'Vaccine',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    ImageResources.rightArrowIcon,
                                    height: 30,
                                    width: 30,
                                    color: ColorConstants.appColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, addHealthRecord,
                                  arguments: HealthType.dewormer);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Text(
                                    'Dewormer',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    ImageResources.rightArrowIcon,
                                    height: 30,
                                    width: 30,
                                    color: ColorConstants.appColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                         /* InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(viewEditHealthRecords,
                                  arguments: {'isEditable': true});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Text(
                                    'View Health Record',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    ImageResources.rightArrowIcon,
                                    height: 30,
                                    width: 30,
                                    color: ColorConstants.appColor,
                                  )
                                ],
                              ),
                            ),
                          ),*/
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(viewEditHealthRecords,
                                  arguments: {'isEditable': false});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  const Text(
                                    'Farmers History on Treatment',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  const Spacer(),
                                  Image.asset(
                                    ImageResources.rightArrowIcon,
                                    height: 30,
                                    width: 30,
                                    color: ColorConstants.appColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //context.read<BreedingAndHealthChangeTabCubit>().changeTab(index);
  }
}
