import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/screens/blocs/healthRecordBloc/health_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/farmer_health_record_item_widget.dart';

import '../data/models/health_model.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../util/constants.dart';
import 'blocs/cowRecordBloc/cow_record_bloc.dart';
import 'widgets/loading_widget.dart';

class ViewHealthRecordActivity extends StatefulWidget {
  final bool isEditable;

  const ViewHealthRecordActivity({this.isEditable = true, Key? key}) : super(key: key);

  @override
  State<ViewHealthRecordActivity> createState() => _ViewHealthRecordActivityState();
}

class _ViewHealthRecordActivityState extends State<ViewHealthRecordActivity> {
  final TextEditingController _searchController = TextEditingController();

  List<HealthData> healthList = [];
  List<HealthData> tempHealthList = [];

  @override
  void initState() {
    super.initState();

    String mobileNoOrVetId = widget.isEditable
        ? '${sl<SessionManager>().getUserDetails()!.data!.vetId!}'
        : context.read<CowRecordBloc>().mobileNumber;

    context.read<HealthBloc>().add(FetchHealthRecordEvent(
        mobileNoOrVetId: mobileNoOrVetId, isMobileNo: widget.isEditable ? false : true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimaryDark,
      appBar: AppBar(
        backgroundColor: ColorConstants.colorPrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Health Record Management',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                focusColor: Colors.grey,
                counterText: "",
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Search...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                alignLabelWithHint: true,
              ),
              controller: _searchController,
              keyboardType: TextInputType.text,
              onChanged: (String query) {
                tempHealthList = healthList.where((element) {
                  String title = element.cowName!.toLowerCase();
                  return title.contains(query);
                }).toList();
                setState(() {
                  tempHealthList;
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<HealthBloc, HealthState>(builder: (_, state) {
            if (state is LoadingHealthRecordState) {
              return const LoadingWidget();
            } else if (state is HandleHealthRecordListState) {
              healthList = state.response;
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, i) {
                      final healthData =
                          _searchController.text.isEmpty ? healthList[i] : tempHealthList[i];
                      return FarmerHealthRecordItemWidget(
                        healthData: healthData,
                        onViewClicked: () async {
                          await Navigator.of(context).pushNamed(healthRecordDetail, arguments: {
                            'healthID': '${healthData.id}',
                            'isEditable': widget.isEditable,
                            'healthCat':'${healthData.healthCategory}'
                          });
                          if (mounted) {
                            String mobileNo = context.read<CowRecordBloc>().mobileNumber;
                            context.read<HealthBloc>().add(FetchHealthRecordEvent(
                                mobileNoOrVetId: mobileNo, isMobileNo: true));
                          }
                        },
                      ) /*Card(
                        color: Colors.white,
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${i + 1}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'Cow : ${healthList[i].cowName!}'
                                        : 'Cow : ${tempHealthList[i].cowName!}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'Category : ${healthList[i].healthCategory!}'
                                        : 'Category : ${tempHealthList[i].healthCategory!}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'Treatment Date : ${sl<CommonFunctions>().convertDateToDDMMMYYYY(healthList[i].treatmentDate!)}'
                                        : 'Treatment Date : ${sl<CommonFunctions>().convertDateToDDMMMYYYY(tempHealthList[i].treatmentDate!)}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'Vet Name : ${healthList[i].vetName ?? ''}'
                                        : 'Vet Name : ${tempHealthList[i].vetName ?? ''}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )*/
                          ;
                    },
                    itemCount:
                        _searchController.text.isEmpty ? healthList.length : tempHealthList.length),
              );
            }
            return const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}
