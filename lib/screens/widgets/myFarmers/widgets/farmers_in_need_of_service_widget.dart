import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ndumeappflutter/screens/commonWidgets/my_text_field.dart';
import 'package:ndumeappflutter/screens/widgets/farmersInNeedOfServiceWithFarmerListActivity/farmers_in_need_of_service_with_farmer_list_activity.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:ndumeappflutter/util/constants.dart';

import '../../../../data/sessionManager/session_manager.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../blocs/farmerBloc/farmer_bloc.dart';
import '../../custom_button.dart';

class FarmersInNeedOfServiceWidget extends StatefulWidget {
  const FarmersInNeedOfServiceWidget({Key? key}) : super(key: key);

  @override
  State<FarmersInNeedOfServiceWidget> createState() =>
      _FarmersInNeedOfServiceWidgetState();
}

class _FarmersInNeedOfServiceWidgetState
    extends State<FarmersInNeedOfServiceWidget> {
  DateTime? selectedMainDate;
  final dateYYYYMMDDFormat = DateFormat('yyyy-MM-dd');

  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  late String vetID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vetID = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
    context
        .read<FarmerBloc>()
        .add(GetFarmerNeedService(vetId: vetID, fromDate: "", toDate: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MyTextfield(
                  hint: 'From Date',
                  textEditingController: _startDate,
                  readonly: true,
                  ontap: () {
                    selectDate(true);
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: MyTextfield(
                  hint: 'To Date',
                  textEditingController: _endDate,
                  readonly: true,
                  ontap: () {
                    selectDate(false);
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  context.read<FarmerBloc>().add(GetFarmerNeedService(
                      vetId: vetID,
                      fromDate: _startDate.text,
                      toDate: _endDate.text));
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FarmersInNeedOfServiceWithFarmerListActivity()));*/
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: ColorConstants.appColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<FarmerBloc, FarmerState>(
            builder: (context, state) {
              if (state is LoadingFarmersState) {
                return const LoadingWidget();
              } else if (state is FarmerNeedServiceState) {
                if (state.response!.success!) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      _buildDetailListTile(
                          title: "Pregnancy Diagnosis",
                          dueCount:
                              state.response.data!.pregnanacyCount!.toString(),apiName: getPregnencyDueAPI,recordType: "breeding"),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildDetailListTile(
                          title: "Deworming",
                          dueCount:
                              state.response.data!.dewormingCount!.toString(),apiName: getDwormerDueAPI,recordType:"health"),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildDetailListTile(
                          title: "Vaccination",
                          dueCount: state.response.data!.vaccinationCount!
                              .toString(),apiName: getDwormerDueAPI,recordType:"health"),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text("No data found",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  );
                }
              } else {
                return const Center(
                  child: Text("Server error",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailListTile({
    required String title,
    required String dueCount,
    required String apiName,required String recordType
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, farmerInNeedOfService, arguments: {
          'title': "$title due ($dueCount)",
          'fromDate':_startDate.text,
          'toDate':_endDate.text,
          'apiName':apiName,
          'recordType':recordType,
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.white, width: 0.5)),
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Text('$dueCount Due Today',
                style: const TextStyle(color: Colors.white, fontSize: 14)),
            SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  void selectDate(bool isStartDate) async {
    await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate:
          selectedMainDate == null ? DateTime.now() : selectedMainDate!,
      firstDate: DateTime.now().add(const Duration(days: -100000)),
      lastDate: DateTime(2028),
    ).then((newDate) {
      if (newDate != null) {
        selectedMainDate = newDate;
        String formattedDate = dateYYYYMMDDFormat.format(newDate);
        if (isStartDate) {
          _startDate.text = formattedDate;
        } else {
          _endDate.text = formattedDate;
        }
      }
    });
  }
}
