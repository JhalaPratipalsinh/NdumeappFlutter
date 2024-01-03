import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/models/add_health_record_req_model.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/screens/blocs/healthRecordBloc/health_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/bottom_sheet_select_multiple_cow_widget.dart';
import 'package:ndumeappflutter/screens/widgets/cow_option_radio_widget.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';

import '../data/models/cow_list_model.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../util/common_functions.dart';
import '../util/constants.dart';
import 'blocs/cowRecordBloc/cow_record_bloc.dart';
import 'widgets/bottom_sheet_cow_records_widget.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_drop_down.dart';
import 'widgets/inputfields.dart';

enum HealthType {
  treatment,
  vaccine,
  dewormer,
}

class AddHealthRecordTreatmentActivity extends StatefulWidget {
  final HealthType healthType;

  const AddHealthRecordTreatmentActivity({required this.healthType, Key? key}) : super(key: key);

  @override
  State<AddHealthRecordTreatmentActivity> createState() => _AddHealthRecordTreatmentActivityState();
}

class _AddHealthRecordTreatmentActivityState extends State<AddHealthRecordTreatmentActivity> {
  String selectedVaccine = "Select Vaccine";
  String _buttonText = '';
  String _headerText = '';
  String _selectedDiagnosisType = 'Select Diagnosis';
  String _selectedPrognosis = 'Prognosis';
  String _selectedCowSelection = 'Single Cow';
  final List<CowRecordsModel> _selectedCowList = [];

  List<String> cowList = ['Select Cow'];
  List<String> vaccineList = ['Select Vaccine', 'LSD', 'BQ/Anthrax', 'FMD', 'ECF'];

  List<String> diagnosisTypeList = [
    'Select Diagnosis',
    'General Diagnosis',
    'Clinical Diagnosis',
    'Confirmatory Diagnosis'
  ];

  List<String> prognosisList = ['Prognosis', 'Good', 'Fair', 'Hopeless'];

  final cowController = TextEditingController();
  final selectDateController = TextEditingController();
  final treatmentController = TextEditingController();
  final reportController = TextEditingController();
  final diagnosisController = TextEditingController();
  final dewormerController = TextEditingController();
  final totalCostController = TextEditingController();

  //
  DateTime? selectedMainDate;

  @override
  void initState() {
    super.initState();
    if (widget.healthType == HealthType.treatment) {
      _buttonText = "Record Treatment";
      _headerText = 'Health Record Management';
    } else if (widget.healthType == HealthType.vaccine) {
      _buttonText = "Record Vaccine Treatment";
      _headerText = 'Vaccine Administration';
    } else {
      _buttonText = "Record Dewormer Treatment";
      _headerText = 'Dewormer Administration';
    }
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
          backgroundColor: ColorConstants.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            _headerText,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  if (widget.healthType != HealthType.treatment) ...[
                    CowOptionRadioWidget(
                        selectedValue: _selectedCowSelection,
                        onValueSelect: (String value) {
                          _selectedCowList.clear();
                          _selectedCowSelection = value;
                          cowController.clear();
                          setState(() {});
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                  InkWell(
                    onTap: () {
                      showCowRecordsBottomSheet();
                    },
                    child: InputTextField(
                      controller: cowController,
                      isEnabled: false,
                      isTextCenter: true,
                      hint: "Select Cow",
                      inputType: TextInputType.text,
                      inputIcon: '',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (_selectedCowSelection != 'Single Cow' && _selectedCowList.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: GridView.builder(
                        itemCount: _selectedCowList.length,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemBuilder: (ctx, index) => Container(
                          decoration: BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              _selectedCowList[index].title!,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3.5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                  InkWell(
                    onTap: () {
                      selectDate();
                    },
                    child: InputTextField(
                      controller: selectDateController,
                      isEnabled: false,
                      isTextCenter: true,
                      hint: "Select Date",
                      inputType: TextInputType.text,
                      inputIcon: '',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  setHealthTypeView(),
                  const SizedBox(
                    height: 15,
                  ),
                  InputTextField(
                    controller: totalCostController,
                    isTextCenter: true,
                    hint: "Total Cost",
                    inputType: TextInputType.number,
                    inputIcon: '',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BlocBuilder<HealthBloc, HealthState>(
                    builder: (_, state) {
                      if (state is LoadingHealthRecordState) {
                        return const LoadingWidget();
                      }
                      return ButtonWidget(
                        buttonText: _buttonText.toUpperCase(),
                        onPressButton: validateAndSubmitForm,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCowRecordsBottomSheet() async {
    final result = await showModalBottomSheet(
        constraints: BoxConstraints.loose(
            Size(MediaQuery.of(context).size.width, (MediaQuery.of(context).size.height) - 60)),
        // <= this is set to 3/4 of screen size.
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        context: context,
        builder: (_) => _selectedCowSelection == 'Single Cow'
            ? BottomSheetCowRecordsWidget(
                onCowSelected: (CowRecordsModel value) {
                  cowController.text = value.title!;
                  _selectedCowList.clear();
                  _selectedCowList.add(value);
                  Navigator.of(context).pop();
                },
              )
            : BottomSheetSelectMultipleCowWidget(selectedCowList: _selectedCowList));
    if (_selectedCowSelection != 'Single Cow' && result != null) {
      _selectedCowList.clear();
      final selectionList = result['selectedCowList'];
      _selectedCowList.addAll(selectionList);
      setState(() {});
    }
  }

  void validateAndSubmitForm() {
    if (_selectedCowList.isEmpty) {
      showMessage('Please select cow');
    } else if (selectDateController.text.isEmpty) {
      showMessage('Please select date');
    } else if (widget.healthType == HealthType.treatment && treatmentController.text.isEmpty) {
      showMessage('Please enter treatment');
    } else if (widget.healthType == HealthType.treatment && reportController.text.isEmpty) {
      showMessage('Please enter report');
    } else if (widget.healthType == HealthType.treatment && diagnosisController.text.isEmpty) {
      showMessage('Please enter diagnosis');
    } else if (widget.healthType == HealthType.treatment && _selectedPrognosis == 'Prognosis') {
      showMessage('Please select prognosis');
    } else if (widget.healthType == HealthType.vaccine && selectedVaccine == 'Select Vaccine') {
      showMessage('Please select vaccine');
    } else if (widget.healthType == HealthType.dewormer && dewormerController.text.isEmpty) {
      showMessage('Please enter dewormer');
    } else if (totalCostController.text.isEmpty) {
      showMessage('Please enter cost');
    } else {
      final cowBloc = context.read<CowRecordBloc>();

      String healthCategory = '';
      String treatment = '';
      if (widget.healthType == HealthType.treatment) {
        healthCategory = 'Treatment';
        treatment = treatmentController.text;
      } else if (widget.healthType == HealthType.vaccine) {
        healthCategory = 'Vaccine';
        treatment = selectedVaccine;
      } else {
        healthCategory = 'Dewormer';
        treatment = dewormerController.text;
      }

      final mainDate = dateAndTimeFormat.format(selectedMainDate!);
      final cowJsonArray = [];

      for (int i = 0; i < _selectedCowList.length; i++) {
        final data = {'cow_name': _selectedCowList[i].title!, 'cow_id': _selectedCowList[i].id!};
        cowJsonArray.add(data);
      }

      final addHealthRecordReqModel = AddHealthRecordReqModel(
        cowData: cowJsonArray,
        healthCategory: healthCategory,
        mobileNo: cowBloc.mobileNumber,
        farmerName: cowBloc.farmerVetName,
        cost: totalCostController.text,
        report: reportController.text,
        diagnosis: diagnosisController.text,
        vetId: '${sl<SessionManager>().getUserDetails()!.data!.vetId!}',
        vetName:
            '${sl<SessionManager>().getUserDetails()!.data!.vetFname!}',
        recordType: 'ndume',
        treatment: treatment,
        treatmentDate: mainDate,
        diagnosisType: widget.healthType == HealthType.treatment ? _selectedDiagnosisType : '',
        prognosis: widget.healthType == HealthType.treatment ? _selectedPrognosis : '',
      );

      context
          .read<HealthBloc>()
          .add(AddHealthRecordEvent(addHealthRecordReq: addHealthRecordReqModel));
    }
  }

  void showMessage(String message) {
    sl<CommonFunctions>().showSnackBar(context: context, message: message);
  }

  Widget setHealthTypeView() {
    String diagnosisDesc = "";
    if(_selectedDiagnosisType == 'Select Diagnosis'){
      diagnosisDesc = 'Enter Diagnosis Report';
    } else if (_selectedDiagnosisType == 'General Diagnosis') {
      diagnosisDesc = 'Enter General Report';
    } else if (_selectedDiagnosisType == 'Clinical Diagnosis') {
      diagnosisDesc = 'Enter Clinical Report';
    } else{
      diagnosisDesc = 'Enter Confirmatory Report';
    }

    if (widget.healthType == HealthType.treatment) {
      return Column(
        children: [
          CustomDropDown<String>(
              value: _selectedDiagnosisType,
              itemsList: diagnosisTypeList,
              dropdownColor: Colors.white,
              showDropdown: false,
              dropDownMenuItems: diagnosisTypeList
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              item,
                              textAlign: TextAlign.center,
                            )),
                      ))
                  .toList(),
              onChanged: (String value) {
                _selectedDiagnosisType = value;
                setState(() {});
              }),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 35),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: reportController,
              obscureText: false,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.center,
              minLines: 1,
              maxLines: 5,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: diagnosisDesc,
                hintStyle: const TextStyle(color: Colors.black),
                alignLabelWithHint: true,
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InputTextField(
            controller: diagnosisController,
            isTextCenter: true,
            hint: 'Enter Diagnosis',
            inputType: TextInputType.text,
            inputIcon: '',
          ),
          const SizedBox(
            height: 15,
          ),
          InputTextField(
            controller: treatmentController,
            isTextCenter: true,
            hint: "Enter Treatment",
            inputType: TextInputType.text,
            inputIcon: '',
          ),
          const SizedBox(
            height: 15,
          ),
          CustomDropDown<String>(
              value: _selectedPrognosis,
              itemsList: prognosisList,
              dropdownColor: Colors.white,
              showDropdown: false,
              dropDownMenuItems: prognosisList
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              item,
                              textAlign: TextAlign.center,
                            )),
                      ))
                  .toList(),
              onChanged: (String value) {
                _selectedPrognosis = value;
              }),
        ],
      );
    } else if (widget.healthType == HealthType.vaccine) {
      return CustomDropDown<String>(
          value: selectedVaccine,
          itemsList: vaccineList,
          dropdownColor: Colors.white,
          showDropdown: false,
          dropDownMenuItems: vaccineList
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          item,
                          textAlign: TextAlign.center,
                        )),
                  ))
              .toList(),
          onChanged: (String value) {
            selectedVaccine = value;
          });
    }

    return InputTextField(
      controller: dewormerController,
      isTextCenter: true,
      hint: "Enter De-wormer",
      inputType: TextInputType.text,
      inputIcon: '',
    );
  }

  void selectDate() async {
    await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedMainDate == null ? DateTime.now() : selectedMainDate!,
      lastDate: DateTime.now(),
      firstDate: DateTime(1990),
    ).then((newDate) {
      if (newDate != null) {
        selectedMainDate = newDate;
        String formattedDate = dateAndTimeFormat.format(newDate);
        selectDateController.text = formattedDate.replaceAll("00:00:00", '');
      }
    });
  }
}
