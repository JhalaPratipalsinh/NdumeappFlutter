import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ndumeappflutter/data/models/pregnency_service_duelist_model.dart';
import 'package:ndumeappflutter/screens/blocs/serviceDueBloc/servicedue_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/serviceDueBloc/servicedue_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/farmersInNeedOfServiceActivity/widgets/farmers_in_need_of_service_list_row_widget.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';

import '../../../data/sessionManager/session_manager.dart';
import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../commonWidgets/my_text_field.dart';

class FarmerInNeedOfServiceActivity extends StatefulWidget {
  final String title, fromDate, toDate,apiName,recordType;

  const FarmerInNeedOfServiceActivity(
      {Key? key,
      required this.title,
      required this.fromDate,
      required this.toDate,
      required this.apiName,
      required this.recordType})
      : super(key: key);

  @override
  State<FarmerInNeedOfServiceActivity> createState() =>
      _FarmerInNeedOfServiceActivityState();
}

class _FarmerInNeedOfServiceActivityState
    extends State<FarmerInNeedOfServiceActivity> {
  DateTime? selectedMainDate;
  final dateYYYYMMDDFormat = DateFormat('yyyy-MM-dd');
  late String vetID;

  final TextEditingController _startDate = TextEditingController();
  final TextEditingController _endDate = TextEditingController();
  final TextEditingController _farmerName = TextEditingController();
  List<PregnencyDue> farmerData = [];
  List<PregnencyDue> tempFarmerData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDate.text = widget.fromDate;
    _endDate.text = widget.toDate;
    vetID = '${sl<SessionManager>().getUserDetails()!.data!.vetId!}';
    context.read<ServicedueBloc>().add(GetPregnencyDueList(apiName: widget.apiName,vetId: vetID, fromDate: _startDate.text, toDate:_endDate.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      appBar: AppBar(
        backgroundColor: ColorConstants.appColor,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
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
                Container(
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
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              autofocus: false,
              controller: _farmerName,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              cursorColor: Colors.white,
              onChanged: (String query) {
                tempFarmerData = farmerData.where((element) {
                  String title = element.farmerName!.toLowerCase();
                  return title.contains(query);
                }).toList();

                setState(() {});
              },
              decoration: InputDecoration(
                fillColor: ColorConstants.transparent,
                focusColor: Colors.grey,
                counterText: "",
                hintStyle: const TextStyle(color: Colors.white),
                hintText: 'Filter by Name',
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
              height: 15,
            ),
            /*Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: ColorConstants.appColor,
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'SMS ALL',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),*/
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<ServicedueBloc, ServicedueState>(
              buildWhen: (previous, current) =>  previous != current &&
                  (current is LoadingServiceDueState || current is PregnencyDueListState),
              builder: (context, state) {
                if (state is LoadingServiceDueState) {
                  return const LoadingWidget();
                } else if (state is PregnencyDueListState) {
                  if(state.response!.success!) {
                    farmerData.clear();
                    farmerData.addAll(state.response.data!);
                    return Expanded(
                      child: ListView.separated(
                        //controller: _scrollController,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount:  _farmerName.text.isEmpty
                            ? farmerData.length
                            : tempFarmerData.length,
                        itemBuilder: (_, i) {
                          return FarmersInNeedOfServiceListRowWidget(data: _farmerName.text.isEmpty
                              ? farmerData[i]
                              : tempFarmerData[i],recordType: widget.recordType);
                        },
                        separatorBuilder: (_, i) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    );
                  }else{
                    return const Center(
                      child: Text("No Data Available",
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
