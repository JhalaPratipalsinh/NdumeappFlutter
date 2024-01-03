import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/breedingBloc/breeding_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/breeding_record_item_widget.dart';
import 'package:ndumeappflutter/screens/widgets/breeding_records_tab_widget.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';

import '../../data/models/breeding_model.dart';
import '../../data/sessionManager/session_manager.dart';
import '../../injection_container.dart';
import '../../resources/color_constants.dart';
import '../../util/constants.dart';
import '../cubits/breedingRecordChangeTabCubit/breeding_record_change_tab_cubit.dart';

class BreedingRecordsWidget extends StatefulWidget {
  const BreedingRecordsWidget({Key? key}) : super(key: key);

  @override
  State<BreedingRecordsWidget> createState() => _BreedingRecordsWidgetState();
}

class _BreedingRecordsWidgetState extends State<BreedingRecordsWidget> {
  final _filterByCowController = TextEditingController();
  List<BreedingData> totalBreedingData = [];
  List<BreedingData> newBreedingData = [];
  List<BreedingData> repeatBreedingData = [];
  List<BreedingData> tempTotalBreedingData = [];
  List<BreedingData> tempNewBreedingData = [];
  List<BreedingData> tempRepeatBreedingData = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedingBloc, BreedingState>(
      builder: (_, state) {
        if (state is LoadingBreedingState) {
          return const LoadingWidget();
        }
        if (state is HandleBreedingListState) {
          totalBreedingData = state.response.data!;
          newBreedingData = totalBreedingData.where((e) {
            if (e.repeats == null) {
              return false;
            }
            return e.repeats == '0';
          }).toList();
          repeatBreedingData = totalBreedingData.where((e) {
            if (e.repeats == null) {
              return false;
            }
            return e.repeats != '0';
          }).toList();

          return Container(
            color: ColorConstants.colorPrimaryDark,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                BreedingRecordsTabWidget(
                  totalBreedingData: totalBreedingData,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<BreedingRecordChangeTabCubit, int>(
                  builder: (_, state) {
                    return Expanded(
                      child: Column(
                        children: [
                          TextField(
                            autofocus: false,
                            controller: _filterByCowController,
                            keyboardType: TextInputType.name,
                            textAlign: TextAlign.start,
                            cursorColor: Colors.white,
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                            onChanged: (String query) {
                              tempTotalBreedingData = totalBreedingData.where((element) {
                                String title = element.cowName!.toLowerCase();
                                return title.contains(query);
                              }).toList();

                              tempNewBreedingData = newBreedingData.where((element) {
                                String title = element.cowName!.toLowerCase();
                                return title.contains(query);
                              }).toList();

                              tempRepeatBreedingData = repeatBreedingData.where((element) {
                                String title = element.cowName!.toLowerCase();
                                return title.contains(query);
                              }).toList();

                              setState(() {});
                            },
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
                          const SizedBox(
                            height: 10,
                          ),
                          if (state == 0) ...[
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (_, i) {
                                  return InkWell(
                                    onTap: () async {
                                      final breeding = _filterByCowController.text.isEmpty
                                          ? totalBreedingData[i]
                                          : tempTotalBreedingData[i];
                                      moveToBreedingDetail(breeding);
                                    },
                                    child: BreedingRecordItemWidget(
                                      breedingData: _filterByCowController.text.isEmpty
                                          ? totalBreedingData[i]
                                          : tempTotalBreedingData[i],
                                    ),
                                  );
                                },
                                itemCount: _filterByCowController.text.isEmpty
                                    ? totalBreedingData.length
                                    : tempTotalBreedingData.length,
                                separatorBuilder: (BuildContext context, int index) {
                                  return const Divider();
                                },
                              ),
                            )
                          ],
                          if (state == 1) ...[
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (_, i) {
                                  return InkWell(
                                    onTap: () {
                                      final breeding = _filterByCowController.text.isEmpty
                                          ? newBreedingData[i]
                                          : tempNewBreedingData[i];
                                      moveToBreedingDetail(breeding);
                                    },
                                    child: BreedingRecordItemWidget(
                                      breedingData: _filterByCowController.text.isEmpty
                                          ? newBreedingData[i]
                                          : tempNewBreedingData[i],
                                    ),
                                  );
                                },
                                itemCount: _filterByCowController.text.isEmpty
                                    ? newBreedingData.length
                                    : tempNewBreedingData.length,
                                separatorBuilder: (BuildContext context, int index) {
                                  return const Divider();
                                },
                              ),
                            )
                          ],
                          if (state == 2) ...[
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (_, i) {
                                  return InkWell(
                                    onTap: () {
                                      final breeding = _filterByCowController.text.isEmpty
                                          ? repeatBreedingData[i]
                                          : tempRepeatBreedingData[i];
                                      moveToBreedingDetail(breeding);
                                    },
                                    child: BreedingRecordItemWidget(
                                      breedingData: _filterByCowController.text.isEmpty
                                          ? repeatBreedingData[i]
                                          : tempRepeatBreedingData[i],
                                    ),
                                  );
                                },
                                itemCount: _filterByCowController.text.isEmpty
                                    ? repeatBreedingData.length
                                    : tempRepeatBreedingData.length,
                                separatorBuilder: (BuildContext context, int index) {
                                  return const Divider();
                                },
                              ),
                            )
                          ],
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          );
        }
        return const Center(
          child: Text("Data not Found \n please Add some records",style: TextStyle(color: Colors.black,fontSize: 18,),textAlign: TextAlign.center,),
        );
      },
    );
  }

  void moveToBreedingDetail(BreedingData breeding) async {
    await Navigator.of(context).pushNamed(breedingRecordDetail, arguments: {
      'breedingID': '${breeding.id!}',
      'repeats': breeding.repeats == null ? '0' : breeding.repeats!
    });
    if (!mounted) return;
    final vetID = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
    context.read<BreedingBloc>().add(FetchBreedingEvent(mobileNoOrVetId: vetID, isMobileNo: false));
  }
}
