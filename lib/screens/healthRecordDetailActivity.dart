import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/models/health_model.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/screens/blocs/healthRecordBloc/health_bloc.dart';
import 'package:ndumeappflutter/util/constants.dart';

import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../resources/image_resources.dart';
import '../util/common_functions.dart';
import 'breedingRecordDetailActivity.dart';
import 'widgets/health_title_and_input_widget.dart';

const textStyle = TextStyle(color: Colors.white, fontSize: 16);

class HealthRecordDetailActivity extends StatefulWidget {
  final String healthId;
  final String healthCat;
  final bool isEditable;

  const HealthRecordDetailActivity(
      {required this.healthId,
      required this.healthCat,
      this.isEditable = true,
      Key? key})
      : super(key: key);

  @override
  State<HealthRecordDetailActivity> createState() =>
      _HealthRecordDetailActivityState();
}

class _HealthRecordDetailActivityState
    extends State<HealthRecordDetailActivity> {
  final treatmentController = TextEditingController();
  final treatmentDateController = TextEditingController();
  final diagnosisController = TextEditingController();
  final treatmentCostController = TextEditingController();
  final diagnosisTypeController = TextEditingController();
  final prognosisController = TextEditingController();
  final vaccineController = TextEditingController();
  final dewormerController = TextEditingController();
  final clinicalReportController = TextEditingController();

  String selectedVaccine = "Select Vaccine";
  String _selectedDiagnosisType = 'General Diagnosis';
  String _selectedPrognosis = 'Good';

  String healthCategoryType = '';
  HealthData? healthData;

  List<String> vaccineList = [
    'Select Vaccine',
    'LSD',
    'BQ/Anthrax',
    'FMD',
    'ECF'
  ];

  List<String> diagnosisTypeList = [
    'General Diagnosis',
    'Clinical Diagnosis',
    'Confirmatory Diagnosis'
  ];
  List<String> prognosisList = ['Good', 'Fair', 'Hopeless'];

  @override
  void initState() {
    super.initState();
    context
        .read<HealthBloc>()
        .add(FetchHealthRecordDetailEvent(healthId: widget.healthId));
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
        } else if (state is HandleRemoveHealthRecordState) {
          showMessage(state.response.message!);
          Navigator.pop(context, 'deleted');
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.colorPrimaryDark,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorConstants.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            '${widget.healthCat} Record',
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
                      showEditBottomSheet();
                    },
                    child: Icon(Icons.mode_edit_outlined));
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

              healthCategoryType = data.healthCategory!;

              if (healthCategoryType == 'Treatment') {
                diagnosisTypeController.text = data.diagnosisType;
                prognosisController.text = data.prognosis;
              }

              treatmentController.text = data.treatment!;

              if (data.treatmentDate != null) {
                treatmentDateController.text = sl<CommonFunctions>()
                    .convertDateToDDMMMYYYY(data.treatmentDate!);
              }

              if (data.diagnosis != null) {
                diagnosisController.text = data.diagnosis!;
              } else {
                diagnosisController.text = '';
              }

              if (data.report != null) {
                clinicalReportController.text = data.report;
              } else {
                clinicalReportController.text = '';
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
                      healthCategoryType != 'Dewormer'
                          ? HealthTitleAndInputWidget(
                              controller: treatmentController,
                              inputText: '',
                              title: 'TREATMENT')
                          : SizedBox(),
                      HealthTitleAndInputWidget(
                          controller: treatmentDateController,
                          inputText: '',
                          title: 'TREATED ON'),
                      if (healthCategoryType == 'Treatment') ...[
                        setTreatmentView()
                      ],
                      if (healthCategoryType == 'Dewormer') ...[
                        HealthTitleAndInputWidget(
                            controller: treatmentController,
                            inputText: '',
                            title: 'Dewormer'),
                      ],
                      HealthTitleAndInputWidget(
                          controller: treatmentCostController,
                          inputText: '',
                          title: 'TREATMENT COST'),
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

  Widget setTreatmentView() {
    return Column(
      children: [
        HealthTitleAndInputWidget(
            controller: diagnosisTypeController,
            inputText: '',
            title: 'Diagnosis'),
        HealthTitleAndInputWidget(
            controller: clinicalReportController,
            inputText: '',
            title: 'Report'),
        HealthTitleAndInputWidget(
            controller: prognosisController, inputText: '', title: 'Prognosis'),
      ],
    );
  }

  void showEditBottomSheet() async {
    EditOrDeleteType? respondType = await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (_) {
          return const EditOrDeleteWidget();
        });

    if (!mounted) return;
    if (respondType != null && healthData != null) {
      bool canEdit = false;
      if (healthData!.createdAt != null) {
        canEdit =
            sl<CommonFunctions>().dateIsLessThan24Hours(healthData!.createdAt!);
      }

      if (healthData!.vetId ==
          sl<SessionManager>().getUserDetails()!.data!.vetId!.toString()) {
        if (canEdit) {
          if (respondType == EditOrDeleteType.edit) {
            editRecord();
          } else {
            deleteRecord();
          }
        } else {
          showMessage(respondType == EditOrDeleteType.edit
              ? 'You cannot edit the record after 24 hours'
              : "You cannot delete record after 24 hours");
        }
      } else {
        showMessage(respondType == EditOrDeleteType.edit
            ? 'You cannot edit the record because recorded by other vet.'
            : "You cannot delete record because recorded by other Vet.");
      }

      /*if (respondType == EditOrDeleteType.edit) {
        if (healthData != null) {
          bool canEdit = true;
          if (healthData!.createdAt != null) {
            canEdit = sl<CommonFunctions>().dateIsLessThan24Hours(healthData!.createdAt!);
          }
          if (canEdit) {
            await Navigator.of(context)
                .pushNamed(editHealthRecordDetail, arguments: {'healthID': widget.healthId});
            if (!mounted) return;
            context.read<HealthBloc>().add(FetchHealthRecordDetailEvent(healthId: widget.healthId));
          } else {
            showMessage('You cannot edit the record after 24 hours');
          }
        }
      } else {
        final result = await sl<CommonFunctions>().showConfirmationDialog(
          context: context,
          title: 'Remove!',
          message: 'Are you sure you want to Remove this Health Record ?',
          buttonPositiveText: 'Yes',
          buttonNegativeText: 'No',
        );

        if (!result || !mounted) {
          return;
        }
        context.read<HealthBloc>().add(RemoveHealthRecordEvent(healthId: widget.healthId));
      }*/
    }
  }

  void editRecord() async {
    await Navigator.of(context).pushNamed(editHealthRecordDetail,
        arguments: {'healthID': widget.healthId});
    if (!mounted) return;
    Navigator.of(context).pop();
    //context.read<HealthBloc>().add(FetchHealthRecordDetailEvent(healthId: widget.healthId));
  }

  void deleteRecord() async {
    final result = await sl<CommonFunctions>().showConfirmationDialog(
      context: context,
      title: 'Remove!',
      message: 'Are you sure you want to Remove this Health Record?',
      buttonPositiveText: 'Yes',
      buttonNegativeText: 'No',
    );

    if (!result || !mounted) {
      return;
    }
    context
        .read<HealthBloc>()
        .add(RemoveHealthRecordEvent(healthId: widget.healthId));
  }
}
