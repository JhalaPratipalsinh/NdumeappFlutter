import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/logger.dart';
import '../data/models/add_breeding_record_req_model.dart';
import '../data/models/breeding_model.dart';
import '../data/models/cow_breeds_group_model.dart';
import '../data/models/cow_list_model.dart';
import '../data/models/repeat_cow_model.dart';
import '../data/sessionManager/session_manager.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../util/common_functions.dart';
import '../util/constants.dart';
import 'addBreedingRecordActivity.dart';
import 'blocs/breedingBloc/breeding_bloc.dart';
import 'blocs/cowRecordBloc/cow_record_bloc.dart';
import 'widgets/bottom_sheet_cow_records_widget.dart';
import 'widgets/bottom_sheet_pregnancy_cow_record_widget.dart';
import 'widgets/bottom_sheet_repeat_cow_records_widget.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_drop_down.dart';
import 'widgets/inputfields.dart';
import 'widgets/loading_widget.dart';
import 'widgets/semen_radio_widget.dart';

class AddPregnancyStatusActivity extends StatefulWidget {
  const AddPregnancyStatusActivity({Key? key}) : super(key: key);

  @override
  State<AddPregnancyStatusActivity> createState() =>
      _AddPregnancyStatusActivityState();
}

class _AddPregnancyStatusActivityState
    extends State<AddPregnancyStatusActivity> {
  String selectedStatus = "Pregnancy status";
  List<String> pregnancyStatus = ['Pregnancy status', 'Positive', 'Negative'];
  List<RepeatCowModel> repeatCowList = [];

  DateTime? pregnancyDate;

  final cowController = TextEditingController();
  final selectDateController = TextEditingController();
  final commentController = TextEditingController();

  CowRecordsModel? selectedCow;
  CowBreeds? selectedCowBreed;
  BreedingData? selectedRepeatedCow;

  @override
  void initState() {
    super.initState();
    context.read<CowRecordBloc>().add(const FetchCowBreedsAndGroupEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<BreedingBloc, BreedingState>(listener: (_, state) {
          if (state is HandleErrorBreedingState) {
            showMessage(state.error);
          } else if (state is HandleAddBreedingState) {
            showMessage(state.response.message!);
            Navigator.pop(context);
          }
        }),
      ],
      child: Scaffold(
        backgroundColor: ColorConstants.colorPrimaryDark,
        appBar: AppBar(
          backgroundColor: ColorConstants.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Confirm Pregnancy",
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
                  CustomDropDown<String>(
                      value: selectedStatus,
                      itemsList: pregnancyStatus,
                      dropdownColor: Colors.white,
                      showDropdown: false,
                      dropDownMenuItems: pregnancyStatus
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
                        selectedStatus = value;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  InputTextField(
                    controller: commentController,
                    isTextCenter: true,
                    hint: "Comment",
                    inputType: TextInputType.text,
                    inputIcon: '',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BlocBuilder<BreedingBloc, BreedingState>(
                    builder: (_, state) {
                      if (state is LoadingBreedingState) {
                        return const LoadingWidget();
                      }
                      return ButtonWidget(
                        buttonText: "Submit",
                        onPressButton: validateAndSubmitBreedingRecord,
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

  void showCowRecordsBottomSheet() {
    showModalBottomSheet(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            (MediaQuery.of(context).size.height) - 60)),
        // <= this is set to 3/4 of screen size.
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        context: context,
        builder: (_) => BottomSheetPregnancyCowRecordWidget(
              onCowSelected: (BreedingData value) {
                cowController.text = value.cowName!;
                selectedRepeatedCow = value;
                Navigator.of(context).pop();
              },
            ));
  }

  Widget cowRecordWidget() {
    return BlocBuilder<CowRecordBloc, CowRecordState>(
        buildWhen: (_, state) => state is LoadCowBreedsAndGroupState,
        builder: (_, state) {
          if (state is LoadCowBreedsAndGroupState) {
            logger.i('the bull breed is selected');
            final cowBreedList = state.cowBreedsAndGroup.cowBreeds!.map((e) {
              if (e.id == 0) {
                e.setParams('Enter Breed of straw', 0);
              }
              return e;
            }).toList();
            selectedCowBreed ??= cowBreedList.first;
            return cowBreedWidget(cowBreedList);
          }
          return const SizedBox.shrink();
        });
  }

  Widget cowBreedWidget(List<CowBreeds> cowBreedList) {
    return Column(
      children: [
        CustomDropDown<CowBreeds>(
            value: selectedCowBreed!,
            itemsList: cowBreedList,
            dropdownColor: Colors.white,
            showDropdown: false,
            dropDownMenuItems: cowBreedList
                .map((item) => DropdownMenuItem<CowBreeds>(
                      value: item,
                      child: Center(child: Text(item.name!)),
                    ))
                .toList(),
            onChanged: (CowBreeds value) {
              selectedCowBreed = value;
            }),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  void validateAndSubmitBreedingRecord() {
    if (selectedRepeatedCow == null) {
      showMessage('Please select cow');
    } else if (selectDateController.text.isEmpty) {
      showMessage('Please select date');
    } else if (selectedStatus == "Pregnancy status") {
      showMessage('Please select Pregnancy status');
    } else {
      final pgDate = dateAndTimeFormat.format(pregnancyDate!);

      final addBreedingRecordReq = AddBreedingRecordReqModel(
        breedingID: '${selectedRepeatedCow!.id!}',
        cowName: selectedRepeatedCow!.cowName!,
        cowId: selectedRepeatedCow!.cowId!,
        mainDate: selectedRepeatedCow!.dateDt!,
        bullName: selectedRepeatedCow!.bullName!,
        bullCode: selectedRepeatedCow!.bullCode!,
        farmerName: selectedRepeatedCow!.farmerName!,
        semenType: selectedRepeatedCow!.semenType!,
        sexType: selectedRepeatedCow!.sexType!,
        cost: selectedRepeatedCow!.cost!,
        noStraw: selectedRepeatedCow!.noStraw!,
        dryingDate: selectedRepeatedCow!.dryingDate!,
        expectedDOB: selectedRepeatedCow!.expectedDateOfBirth!,
        expectedRepeatDate: selectedRepeatedCow!.expectedRepeatDate!,
        mobileNo: selectedRepeatedCow!.mobile!,
        pregnancyDate: pgDate,
        recordType: 'ndume',
        pgStatus: selectedStatus == "Confirm" ? "1" : "0",
        strawBreed: selectedRepeatedCow!.strawBreed!,
        breed1: selectedRepeatedCow!.breed1,
        breed2: selectedRepeatedCow!.breed2,
        strimingDate: selectedRepeatedCow!.strimingupDate!,
        syncDate: selectedRepeatedCow!.syncAt!.toString(),
        vetID: '${sl<SessionManager>().getUserDetails()!.data!.vetId!}',
        vetName: '${sl<SessionManager>().getUserDetails()!.data!.vetFname!}',
        isVerified: selectedRepeatedCow!.isVerified!.toString(),
        firstHeat: selectedRepeatedCow!.firstHeat!,
        secondHeat: selectedRepeatedCow!.secondHeat!,
        repeats: selectedRepeatedCow!.repeats!,
        isRepeat: selectedRepeatedCow!.repeats == "0" ? "0" : "1",
        sourceOfSemen: "",
      );

      context.read<BreedingBloc>().add(AddBreedingEvent(
          addBreedingRecordReq: addBreedingRecordReq, isUpdate: true));
    }
  }

  void showMessage(String message) {
    sl<CommonFunctions>().showSnackBar(context: context, message: message);
  }

  void selectDate() async {
    await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
      firstDate: DateTime(1980),
    ).then((newDate) {
      if (newDate != null) {
        pregnancyDate = newDate;
        String formattedDate = dateAndTimeFormat.format(newDate);
        selectDateController.text = formattedDate.replaceAll("00:00:00", '');
      }
    });
  }
}
