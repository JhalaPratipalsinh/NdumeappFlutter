import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/models/health_model.dart';

import '../data/models/add_health_record_req_model.dart';
import '../data/sessionManager/session_manager.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../resources/image_resources.dart';
import '../util/common_functions.dart';
import '../util/constants.dart';
import 'blocs/healthRecordBloc/health_bloc.dart';
import 'widgets/health_title_and_input_widget.dart';

class EditHealthRecordActivity extends StatefulWidget {
  final String healthID;

  const EditHealthRecordActivity({required this.healthID, Key? key})
      : super(key: key);

  @override
  State<EditHealthRecordActivity> createState() =>
      _EditHealthRecordActivityState();
}

class _EditHealthRecordActivityState extends State<EditHealthRecordActivity> {
  final textStyle = const TextStyle(color: Colors.white, fontSize: 16);

  final treatmentController = TextEditingController();
  final treatmentDateController = TextEditingController();
  final diagnosisController = TextEditingController();
  final dewormerController = TextEditingController();
  final reportController = TextEditingController();
  final treatmentCostController = TextEditingController();

  String _selectedDiagnosisType = 'General Diagnosis';
  String _selectedPrognosis = 'Good';

  List<String> diagnosisTypeList = [
    'General Diagnosis',
    'Clinical Diagnosis',
    'Confirmatory Diagnosis'
  ];
  List<String> prognosisList = ['Good', 'Fair', 'Hopeless'];

  DateTime? selectedMainDate;
  String selectedTreatmentDate = '';

  HealthData? healthData;

  @override
  void initState() {
    super.initState();
    context
        .read<HealthBloc>()
        .add(FetchHealthRecordDetailEvent(healthId: widget.healthID));
  }

  void showMessage(String message) {
    sl<CommonFunctions>().showSnackBar(context: context, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HealthBloc, HealthState>(
      listener: (_, state) {
        if (state is HandleHealthRecordErrorState) {
          showMessage(state.message);
        } else if (state is HandleAddHealthRecordState) {
          showMessage(state.response.message!);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.colorPrimaryDark,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorConstants.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Edit Record',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          actions: [
            BlocBuilder<HealthBloc, HealthState>(
              builder: (_, state) {
                if (state is LoadingHealthRecordState) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
                return InkWell(
                    onTap: () {
                      //showEditBottomSheet();
                      validateAndSubmitForm(healthData!);
                    },
                    child: const Icon(Icons.check));
              },
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: BlocBuilder<HealthBloc, HealthState>(
          buildWhen: (_, state) => state is HandleHealthRecordDetailState,
          builder: (_, state) {
            if (state is HandleHealthRecordDetailState) {
              healthData = state.response;
              final data = state.response;

              treatmentController.text = data.treatment!;

              if (data.treatmentDate != null) {
                treatmentDateController.text = sl<CommonFunctions>()
                    .convertDateToDDMMMYYYY(data.treatmentDate!);
                selectedMainDate = DateTime.parse(data.treatmentDate!);
                selectedTreatmentDate =
                    dateAndTimeFormat.format(selectedMainDate!);
              }

              if (data.diagnosis != null) {
                diagnosisController.text = data.diagnosis!;
              }

              if (data.report != null) {
                reportController.text = data.report!;
              }

              treatmentCostController.text = '${data.cost!}';

              return Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            ImageResources.cowAvatar,
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            state.response.cowName!,
                            style: textStyle,
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      data.healthCategory != "Dewormer"
                          ? HealthTitleAndInputWidget(
                              controller: treatmentController,
                              inputText: '',
                              title: 'TREATMENT',
                              isEditable: true,
                              inputType: TextInputType.text,
                              enableEditableInputField: true,
                            )
                          : SizedBox(),
                      InkWell(
                        onTap: () {
                          selectDate();
                        },
                        child: IgnorePointer(
                          ignoring: true,
                          ignoringSemantics: true,
                          child: HealthTitleAndInputWidget(
                            controller: treatmentDateController,
                            inputText: '',
                            title: 'TREATED ON',
                            isEditable: true,
                            showSuffixIcon: true,
                          ),
                        ),
                      ),
                      data.healthCategory == "Treatment"
                          ? HealthTitleAndInputWidget(
                              controller: reportController,
                              inputText: '',
                              title: 'Report',
                              isEditable: true,
                              inputType: TextInputType.text,
                              enableEditableInputField: true,
                            )
                          : SizedBox(),
                      data.healthCategory == "Dewormer"
                          ? HealthTitleAndInputWidget(
                              controller: treatmentController,
                              inputText: '',
                              title: 'Dewormer',
                              isEditable: true,
                              inputType: TextInputType.text,
                              enableEditableInputField: true,
                            )
                          : data.healthCategory == "Treatment"
                              ? HealthTitleAndInputWidget(
                                  controller: diagnosisController,
                                  inputText: '',
                                  title: 'DIAGNOSIS',
                                  isEditable: true,
                                  inputType: TextInputType.text,
                                  enableEditableInputField: true,
                                )
                              : SizedBox(),
                      HealthTitleAndInputWidget(
                        controller: treatmentCostController,
                        inputText: '',
                        title: 'TREATMENT COST',
                        isEditable: true,
                        inputType: TextInputType.number,
                        enableEditableInputField: true,
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void selectDate() async {
    await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate:
          selectedMainDate == null ? DateTime.now() : selectedMainDate!,
      lastDate: DateTime.now(),
      firstDate: DateTime(2020),
    ).then((newDate) {
      if (newDate != null) {
        selectedMainDate = newDate;
        selectedTreatmentDate = dateAndTimeFormat.format(selectedMainDate!);
        String formattedDate = dateAndTimeFormat.format(newDate);
        treatmentDateController.text =
            sl<CommonFunctions>().convertDateToDDMMMYYYY(formattedDate);
      }
    });
  }

  void validateAndSubmitForm(HealthData data) async {
    final result = await sl<CommonFunctions>().showConfirmationDialog(
      context: context,
      title: 'Confirm Update !!',
      message: 'Are you sure you want to update this health record',
      buttonPositiveText: 'Yes',
      buttonNegativeText: 'No',
    );

    if (!result) {
      return;
    }

    if (treatmentController.text.isEmpty) {
      showMessage('Please enter treatment');
    } else if (diagnosisController.text.isEmpty &&
        healthData!.healthCategory! == 'Treatment') {
      showMessage('Please enter diagnosis');
    } else if (treatmentCostController.text.isEmpty) {
      showMessage('Please enter treatment cost');
    } else {
      final addHealthRecordReqModel = AddHealthRecordReqModel(
        healthID: '${data.id!}',
        cowName: data.cowName!,
        cowId: data.cowId!,
        healthCategory: data.healthCategory!,
        mobileNo: data.mobile!,
        farmerName: data.farmerName + "",
        report: reportController.text,
        cost: treatmentCostController.text,
        diagnosis: diagnosisController.text,
        vetId: '${sl<SessionManager>().getUserDetails()!.data!.vetId!}',
        vetName:
            '${sl<SessionManager>().getUserDetails()!.data!.vetFname!}',
        recordType: 'ndume',
        treatment: treatmentController.text,
        treatmentDate: selectedTreatmentDate,
        diagnosisType: data.diagnosisType,
        prognosis: data.prognosis,
      );

      if (!mounted) return;
      context.read<HealthBloc>().add(AddHealthRecordEvent(
          addHealthRecordReq: addHealthRecordReqModel, isUpdate: true));
    }
  }
}
