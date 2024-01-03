import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/logger.dart';
import '../data/models/paid_health_record_model.dart';
import '../data/sessionManager/session_manager.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../util/constants.dart';
import 'blocs/healthRecordBloc/health_bloc.dart';
import 'cubits/healthRecordChangeTabCubit/health_record_change_tab_cubit.dart';
import 'widgets/health_records_tab_widget.dart';
import 'widgets/loading_widget.dart';
import 'widgets/paid_health_record_item_widget.dart';

class PaidHealtRecordActivity extends StatefulWidget {
  const PaidHealtRecordActivity({Key? key}) : super(key: key);

  @override
  State<PaidHealtRecordActivity> createState() =>
      _PaidHealtRecordActivityState();
}

class _PaidHealtRecordActivityState extends State<PaidHealtRecordActivity> {
  final _filterByCowController = TextEditingController();
  List<PaidHealthRecord> treatmentHealthData = [];
  List<PaidHealthRecord> vaccineHealthData = [];
  List<PaidHealthRecord> dewormerHealthData = [];
  List<PaidHealthRecord> tempTreatmentHealthData = [];
  List<PaidHealthRecord> tempVaccineHealthData = [];
  List<PaidHealthRecord> tempDewormerHealthData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      appBar: AppBar(
        backgroundColor: ColorConstants.colorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Paid Health Record',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: BlocBuilder<HealthBloc, HealthState>(
        builder: (_, state) {
          if (state is LoadingHealthRecordState) {
            return const LoadingWidget();
          } else if (state is PaidHealthRecordListState) {
            treatmentHealthData = state.response
                .where((element) => element.healthCategory == 'Treatment')
                .toList();
            vaccineHealthData = state.response
                .where((element) => element.healthCategory == 'Vaccine')
                .toList();
            dewormerHealthData = state.response
                .where((element) => element.healthCategory == 'Dewormer')
                .toList();

            logger.i("the list is coming empty");
            return Container(
              color: ColorConstants.colorPrimaryDark,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  HealthRecordsTabWidget(
                    treatmentCount: treatmentHealthData.length,
                    vaccineCount: vaccineHealthData.length,
                    dewormerCount: dewormerHealthData.length,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<HealthRecordChangeTabCubit, int>(
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
                                  style:
                                  const TextStyle(fontSize: 16, color: Colors.white),
                                  onChanged: (String query) {
                                    tempTreatmentHealthData =
                                        treatmentHealthData.where((element) {
                                          String title = element.cowName!.toLowerCase();
                                          return title.contains(query);
                                        }).toList();

                                    tempVaccineHealthData =
                                        vaccineHealthData.where((element) {
                                          String title = element.cowName!.toLowerCase();
                                          return title.contains(query);
                                        }).toList();

                                    tempDewormerHealthData =
                                        dewormerHealthData.where((element) {
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
                                          onTap: () {
                                            final healthData =
                                            _filterByCowController.text.isEmpty
                                                ? treatmentHealthData[i]
                                                : tempTreatmentHealthData[i];
                                            moveToHealthDetail(healthData);
                                          },
                                          child: PaidHealthRecordItemWidget(
                                            healthData:
                                            _filterByCowController.text.isEmpty
                                                ? treatmentHealthData[i]
                                                : tempTreatmentHealthData[i],
                                          ),
                                        );
                                      },
                                      itemCount: _filterByCowController.text.isEmpty
                                          ? treatmentHealthData.length
                                          : tempTreatmentHealthData.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
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
                                            final healthData =
                                            _filterByCowController.text.isEmpty
                                                ? vaccineHealthData[i]
                                                : tempVaccineHealthData[i];
                                            moveToHealthDetail(healthData);
                                          },
                                          child: PaidHealthRecordItemWidget(
                                            healthData:
                                            _filterByCowController.text.isEmpty
                                                ? vaccineHealthData[i]
                                                : tempVaccineHealthData[i],
                                          ),
                                        );
                                      },
                                      itemCount: _filterByCowController.text.isEmpty
                                          ? vaccineHealthData.length
                                          : tempVaccineHealthData.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
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
                                            final healthData =
                                            _filterByCowController.text.isEmpty
                                                ? dewormerHealthData[i]
                                                : tempDewormerHealthData[i];
                                            moveToHealthDetail(healthData);
                                          },
                                          child: PaidHealthRecordItemWidget(
                                            healthData:
                                            _filterByCowController.text.isEmpty
                                                ? dewormerHealthData[i]
                                                : tempDewormerHealthData[i],
                                          ),
                                        );
                                      },
                                      itemCount: _filterByCowController.text.isEmpty
                                          ? dewormerHealthData.length
                                          : tempDewormerHealthData.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Divider();
                                      },
                                    ),
                                  )
                                ],
                              ],
                            ));
                      }),
                ],
              ),
            );
          } else if (state is HandleHealthRecordErrorState) {
            return const Center(
              child: Text(
                "Data not Found \n please Add some records",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void moveToHealthDetail(PaidHealthRecord healthData) async {
    await Navigator.of(context).pushNamed(healthRecordDetail, arguments: {
      'healthID': '${healthData.id}',
      'healthCat': '${healthData.healthCategory}'
    });

    if (!mounted) return;
    final vetID = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
    context
        .read<HealthBloc>()
        .add(FetchHealthRecordEvent(mobileNoOrVetId: vetID, isMobileNo: false));
  }
}
