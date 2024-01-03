import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/screens/blocs/breedingBloc/breeding_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/healthRecordBloc/health_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:ndumeappflutter/util/common_functions.dart';
import 'package:ndumeappflutter/util/constants.dart';

import '../data/models/breeding_model.dart';
import '../data/models/health_model.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../resources/image_resources.dart';
import 'cubits/breedingAndHealthChangeTabCubit/breeding_and_health_change_tab_cubit.dart';
import 'widgets/breeding_and_health_tab_widget.dart';

class FarmerDetailActivity extends StatefulWidget {
  final String farmerName;
  final String mobileNumber;

  const FarmerDetailActivity({required this.farmerName, required this.mobileNumber, Key? key})
      : super(key: key);

  @override
  State<FarmerDetailActivity> createState() => _FarmerDetailActivityState();
}

class _FarmerDetailActivityState extends State<FarmerDetailActivity> {
  final _filterByCowController = TextEditingController();
  List<BreedingData> breedingData = [];
  List<BreedingData> tempBreedingData = [];
  List<HealthData> healthData = [];
  List<HealthData> tempHealthData = [];

  @override
  void initState() {
    super.initState();
    context
        .read<BreedingBloc>()
        .add(FetchBreedingEvent(mobileNoOrVetId: widget.mobileNumber, isMobileNo: true,isVatId:true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreedingAndHealthChangeTabCubit, int>(
      listener: (_, tabState) {
        if (tabState == 0) {
          context
              .read<BreedingBloc>()
              .add(FetchBreedingEvent(mobileNoOrVetId: widget.mobileNumber, isMobileNo: true,isVatId:true));
        } else {
          context
              .read<HealthBloc>()
              .add(FetchHealthRecordEvent(mobileNoOrVetId: widget.mobileNumber, isMobileNo: true,isVatId:true));
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.colorPrimaryDark,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorConstants.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            widget.farmerName,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BreedingAndHealthTabWidget(),
            const Divider(
              height: 0.5,
              color: Colors.white,
            ),
            BlocBuilder<BreedingAndHealthChangeTabCubit, int>(builder: (_, tabState) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        autofocus: false,
                        controller: _filterByCowController,
                        keyboardType: TextInputType.name,
                        textAlign: TextAlign.start,
                        onChanged: (String query) {
                          tempBreedingData = breedingData.where((element) {
                            String title = element.cowName!.toLowerCase();
                            return title.contains(query);
                          }).toList();

                          tempHealthData = healthData.where((element) {
                            String title = element.cowName!.toLowerCase();
                            return title.contains(query);
                          }).toList();

                          setState(() {});
                        },
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          fillColor: ColorConstants.transparent,
                          focusColor: Colors.grey,
                          counterText: "",
                          hintStyle: const TextStyle(color: Colors.white),
                          hintText: 'Filter by Cow',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    tabState == 0
                        ? BlocBuilder<BreedingBloc, BreedingState>(buildWhen: (_, state) {
                            if (state is HandleBreedingDetailState ||
                                state is LoadingBreedingDetailState) {
                              return false;
                            }
                            return true;
                          }, builder: (_, state) {
                            if (state is LoadingBreedingState) {
                              return const LoadingWidget();
                            } else if (state is HandleErrorBreedingState) {
                              return const Center(
                                  child: Text(
                                'No Breeding Record found!!',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ));
                            } else if (state is HandleBreedingListState) {
                              breedingData = state.response.data!;
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        '${breedingData.length} Breeding Record',
                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (_, i) {
                                            return InkWell(
                                              onTap: () async {
                                                final result = await Navigator.of(context)
                                                    .pushNamed(breedingRecordDetail, arguments: {
                                                  'breedingID': '${state.response.data![i].id}',
                                                  'repeats': state.response.data![i].repeats == null
                                                      ? '0'
                                                      : state.response.data![i].repeats!
                                                });

                                                if (result != null && mounted) {
                                                  context.read<BreedingBloc>().add(
                                                      FetchBreedingEvent(
                                                          mobileNoOrVetId: widget.mobileNumber,
                                                          isMobileNo: true,isVatId: true));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(12),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      ImageResources.cowAvatar,
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          _filterByCowController.text.isEmpty
                                                              ? breedingData[i].cowName!
                                                              : tempBreedingData[i].cowName!,
                                                          style: const TextStyle(
                                                              color: Colors.white, fontSize: 16),
                                                        ),
                                                        Text(
                                                          _filterByCowController.text.isEmpty
                                                              ? (breedingData[i].repeats == '0'
                                                                  ? 'New AI'
                                                                  : 'Repeat AI')
                                                              : (tempBreedingData[i].repeats == '0'
                                                                  ? 'New AI'
                                                                  : 'Repeat AI'),
                                                          style: const TextStyle(
                                                              color: Colors.white, fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      _filterByCowController.text.isEmpty
                                                          ? sl<CommonFunctions>()
                                                              .convertDateToDDMMMYYYY(
                                                                  breedingData[i].dateDt!)
                                                          : sl<CommonFunctions>()
                                                              .convertDateToDDMMMYYYY(
                                                                  tempBreedingData[i].dateDt!),
                                                      style: const TextStyle(
                                                          color: Colors.white, fontSize: 16),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: _filterByCowController.text.isEmpty
                                              ? breedingData.length
                                              : tempBreedingData.length),
                                    )
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          })
                        : BlocBuilder<HealthBloc, HealthState>(buildWhen: (_, state) {
                      return state is LoadingHealthRecordState ||
                                state is HandleHealthRecordListState ||
                                state is HandleHealthRecordErrorState;
                          }, builder: (_, state) {
                      if (state is LoadingHealthRecordState) {
                              return const LoadingWidget();
                            } else if (state is HandleHealthRecordErrorState) {
                              return const Center(
                                  child: Text(
                                'No Health Record found!!',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ));
                            } else if (state is HandleHealthRecordListState) {
                              healthData = state.response;
                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        '${healthData.length} Health Record',
                                        style: const TextStyle(color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (_, i) {
                                            return InkWell(
                                              onTap: () async {
                                                final result = await Navigator.of(context)
                                                    .pushNamed(healthRecordDetail, arguments: {
                                                  'healthID': '${healthData[i].id}',
                                                  'healthCat':'${healthData[i].healthCategory}'
                                                });
                                                if (mounted) {
                                                  context.read<HealthBloc>().add(
                                                      FetchHealthRecordEvent(
                                                          mobileNoOrVetId: widget.mobileNumber,
                                                          isMobileNo: true,isVatId: true));
                                                }
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(12),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      ImageResources.cowAvatar,
                                                      height: 50,
                                                      width: 50,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          _filterByCowController.text.isEmpty
                                                              ? healthData[i].cowName!
                                                              : tempHealthData[i].cowName!,
                                                          style: const TextStyle(
                                                              color: Colors.white, fontSize: 16),
                                                        ),
                                                        Text(
                                                          _filterByCowController.text.isEmpty
                                                              ? healthData[i].healthCategory!
                                                              : tempHealthData[i].healthCategory!,
                                                          style: const TextStyle(
                                                              color: Colors.white, fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      _filterByCowController.text.isEmpty
                                                          ? healthData[i].treatmentDate != null
                                                              ? sl<CommonFunctions>()
                                                                  .convertDateToDDMMMYYYY(
                                                                      healthData[i].treatmentDate!)
                                                              : ''
                                                          : tempHealthData[i].treatmentDate != null
                                                              ? sl<CommonFunctions>()
                                                                  .convertDateToDDMMMYYYY(
                                                                      tempHealthData[i]
                                                                          .treatmentDate!)
                                                              : "",
                                                      style: const TextStyle(
                                                          color: Colors.white, fontSize: 16),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: _filterByCowController.text.isEmpty
                                              ? healthData.length
                                              : tempHealthData.length),
                                    )
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          })
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
