import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/core/logger.dart';
import 'package:ndumeappflutter/data/models/add_breeding_record_req_model.dart';
import 'package:ndumeappflutter/data/models/cow_list_model.dart';
import 'package:ndumeappflutter/data/models/repeat_cow_model.dart';
import 'package:ndumeappflutter/data/sessionManager/session_manager.dart';
import 'package:ndumeappflutter/screens/blocs/breedingBloc/breeding_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/cowRecordBloc/cow_record_bloc.dart';
import 'package:ndumeappflutter/screens/cubits/sourceOfSemenChangeCubit/source_of_semen_change_cubit.dart';
import 'package:ndumeappflutter/screens/widgets/bottom_sheet_cow_records_widget.dart';
import 'package:ndumeappflutter/screens/widgets/custom_button.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:ndumeappflutter/screens/widgets/semen_radio_widget.dart';
import 'package:ndumeappflutter/util/common_functions.dart';

import '../data/models/cow_breeds_group_model.dart';
import '../data/models/source_of_semen_list_model.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../util/constants.dart';
import 'widgets/bottom_sheet_repeat_cow_records_widget.dart';
import 'widgets/custom_drop_down.dart';
import 'widgets/inputfields.dart';

enum BreedingType { newBreeding, repeatBreeding }

class AddBreedingRecordActivity extends StatefulWidget {
  final BreedingType breedingType;

  const AddBreedingRecordActivity({required this.breedingType, Key? key})
      : super(key: key);

  @override
  State<AddBreedingRecordActivity> createState() =>
      _AddBreedingRecordActivityState();
}

class _AddBreedingRecordActivityState extends State<AddBreedingRecordActivity> {
  String selectedSexed = "select semen type";
  String selectedSemenType = "";
  List<String> sexedList = ['select semen type', 'Sexed', 'Non-sexed'];
  List<RepeatCowModel> repeatCowList = [];
  ValueNotifier<bool> showCrossBreedViewNotifier = ValueNotifier(false);
  DateTime? selectedMainDate;

  final cowController = TextEditingController();
  final selectDateController = TextEditingController();
  final bullNameController = TextEditingController();
  final bullCodeController = TextEditingController();
  final sourceOfSemenController = TextEditingController();
  final costController = TextEditingController();
  final strawNoController = TextEditingController();

  String expectedRepeatDate = "";
  String expectedDateOfBirth = "";
  String dryingDate1 = "";
  String dryingDate2 = "";
  String pregnancyDate = "";
  String strimingUpDate = "";
  String heatingDate = "";
  String secondHeatingDate = "";

  int crossBreedID1 = 0;
  int crossBreedID2 = 0;

  CowRecordsModel? selectedCow;
  CowBreeds? selectedCowBreed;
  RepeatCowModel? selectedRepeatedCow;
  SourceOfSemenList? selectedSourceOfSemen;
  SourceOfSemenList defaultSourceOfSemen = SourceOfSemenList(
      id: 0,
      semenType: "Type",
      semenSource: 'Select Source of Semen',
      createdAt: "",
      updatedAt: "");
  SourceOfSemenList otherSourceOfSemen = SourceOfSemenList(
      id: 1,
      semenType: "Type",
      semenSource: 'Other',
      createdAt: "",
      updatedAt: "");

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
            widget.breedingType == BreedingType.newBreeding
                ? 'New Breeding AI Record'
                : 'Repeat Breeding AI Record',
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
                  InputTextField(
                    controller: bullNameController,
                    isTextCenter: true,
                    hint: "Bull Name",
                    inputType: TextInputType.text,
                    inputIcon: '',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  cowRecordWidget(),
                  /*if (widget.breedingType == BreedingType.newBreeding) ...[

                  ] else ...[
                    breedingRecordWidget()
                  ],*/
                  const SizedBox(
                    height: 10,
                  ),
                  SemenRadioWidget(
                      selectedValue: selectedSemenType,
                      onValueSelect: (String value) {
                        selectedSemenType = value;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomDropDown<String>(
                      value: selectedSexed,
                      itemsList: sexedList,
                      dropdownColor: Colors.white,
                      showDropdown: false,
                      dropDownMenuItems: sexedList
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
                        selectedSexed = value;
                        selectedSourceOfSemen = null;
                        context
                            .read<SourceOFSemenChangeCubit>()
                            .selectSourceOfSemen("");
                        if (selectedSexed != "select semen type") {
                          context.read<BreedingBloc>().add(
                              FetchSourceOfSemenListEvent(
                                  semenType: selectedSexed));
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  _buildSourceOfSemenDropDown(),
                  InputTextField(
                    controller: bullCodeController,
                    isTextCenter: true,
                    hint: "Bull Code",
                    inputType: TextInputType.text,
                    inputIcon: '',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputTextField(
                    controller: costController,
                    isTextCenter: true,
                    hint: "Enter Cost",
                    inputType: TextInputType.number,
                    inputIcon: '',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputTextField(
                    controller: strawNoController,
                    isTextCenter: true,
                    hint: "Enter Number of straws used",
                    inputType: TextInputType.number,
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

  Widget _buildSourceOfSemenDropDown() {
    return BlocBuilder<BreedingBloc, BreedingState>(
      buildWhen: (previous, current) {
        if (current is LoadingFetchSourceOfSemenListState ||
            current is HandleFetchSourceOfSemenListState ||
            current is HandleErrorSourceOfSemenListState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is LoadingFetchSourceOfSemenListState) {
          return const LoadingWidget();
        } else if (state is HandleFetchSourceOfSemenListState) {
          final sourceOfSemenList = [
                defaultSourceOfSemen,
              ] +
              (state.response.sourceOfSemenList ?? []) +
              [otherSourceOfSemen];
          return Column(
            children: [
              CustomDropDown<SourceOfSemenList>(
                  value: selectedSourceOfSemen ?? defaultSourceOfSemen,
                  itemsList: sourceOfSemenList,
                  dropdownColor: Colors.white,
                  showDropdown: false,
                  dropDownMenuItems: sourceOfSemenList
                      .map((item) => DropdownMenuItem<SourceOfSemenList>(
                            value: item,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  item.semenSource,
                                  textAlign: TextAlign.center,
                                )),
                          ))
                      .toList(),
                  onChanged: (SourceOfSemenList value) {
                    selectedSourceOfSemen = value;
                    context
                        .read<SourceOFSemenChangeCubit>()
                        .selectSourceOfSemen(
                            selectedSourceOfSemen?.semenSource ?? "");
                  }),
              const SizedBox(
                height: 15,
              ),
              _buildSourceOfSemenTextField()
            ],
          );
        } else if (state is HandleErrorSourceOfSemenListState) {
          return ErrorWidget.withDetails(
            message: "${state.statusCode}\n${state.error}",
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildSourceOfSemenTextField() {
    return BlocBuilder<SourceOFSemenChangeCubit, String>(
      builder: (context, state) {
        if (state == "Other") {
          return Column(
            children: [
              InputTextField(
                controller: sourceOfSemenController,
                isTextCenter: true,
                hint: "Enter source of semen",
                inputType: TextInputType.text,
                inputIcon: '',
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
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
        builder: (_) => widget.breedingType == BreedingType.newBreeding
            ? BottomSheetCowRecordsWidget(
                onCowSelected: (CowRecordsModel value) {
                  cowController.text = value.title!;
                  selectedCow = value;
                  Navigator.of(context).pop();
                },
              )
            : BottomSheetRepeatCowRecordsWidget(
                onCowSelected: (RepeatCowModel value) {
                  cowController.text = value.cowName;
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
              showCrossBreedViewNotifier.value = selectedCowBreed!.id! == 13;
            }),
        const SizedBox(
          height: 0,
        ),
        ValueListenableBuilder<bool>(
            valueListenable: showCrossBreedViewNotifier,
            builder: (_, showCrossBreedView, __) {
              final cowCrossBreedList =
                  cowBreedList.where((element) => element.id! != 13).map((e) {
                if (e.id == 0) {
                  e.setParams('Select Breed', 0);
                }
                return e;
              }).toList();
              return showCrossBreedView
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: CustomDropDown<CowBreeds>(
                                  margin: 5,
                                  value: cowCrossBreedList.first,
                                  itemsList: cowCrossBreedList,
                                  dropdownColor: Colors.white,
                                  dropDownMenuItems: cowCrossBreedList
                                      .map(
                                          (item) => DropdownMenuItem<CowBreeds>(
                                                value: item,
                                                child: Text(item.name!),
                                              ))
                                      .toList(),
                                  onChanged: (CowBreeds value) {
                                    crossBreedID1 = value.id!;
                                  }),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: CustomDropDown<CowBreeds>(
                                  margin: 5,
                                  value: cowCrossBreedList.first,
                                  itemsList: cowCrossBreedList,
                                  dropdownColor: Colors.white,
                                  dropDownMenuItems: cowCrossBreedList
                                      .map(
                                          (item) => DropdownMenuItem<CowBreeds>(
                                                value: item,
                                                child: Text(item.name!),
                                              ))
                                      .toList(),
                                  onChanged: (CowBreeds value) {
                                    crossBreedID2 = value.id!;
                                  }),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox.shrink();
            }),
      ],
    );
  }

  void validateAndSubmitBreedingRecord() {
    if (selectedCow == null &&
        widget.breedingType == BreedingType.newBreeding) {
      showMessage('Please select cow');
    } else if (selectedRepeatedCow == null &&
        widget.breedingType == BreedingType.repeatBreeding) {
      showMessage('Please select cow');
    } else if (selectDateController.text.isEmpty) {
      showMessage('Please select date');
    } else if (bullNameController.text.isEmpty) {
      showMessage('Please enter bull name');
    } else if (selectedSexed == 'select semen type') {
      showMessage('Please select semen type');
    } else if (selectedSourceOfSemen == defaultSourceOfSemen) {
      showMessage('Please select source of semen');
    } else if (selectedSourceOfSemen == otherSourceOfSemen &&
        sourceOfSemenController.text.trim() == "") {
      showMessage('Please enter source of semen');
    } else if (bullCodeController.text.isEmpty) {
      showMessage('Please enter bull code');
    } else if (selectedCowBreed!.id == 0) {
      showMessage('Please enter bull breed');
      return;
    } else if (selectedCowBreed!.id == 13 &&
        (crossBreedID1 == 0 || crossBreedID2 == 0)) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please select cow cross breed');
      return;
    } else if (costController.text.isEmpty) {
      showMessage('Please enter cost');
    } else if (strawNoController.text.isEmpty) {
      showMessage('Please enter Number of straws used');
    } else {
      final cowBloc = context.read<CowRecordBloc>();
      final mainDate = dateAndTimeFormat.format(selectedMainDate!);

      final addBreedingRecordReq = AddBreedingRecordReqModel(
        breedingID: widget.breedingType == BreedingType.repeatBreeding
            ? '${selectedRepeatedCow!.breedingID}'
            : '',
        cowName: widget.breedingType == BreedingType.newBreeding
            ? selectedCow!.title!
            : selectedRepeatedCow!.cowName,
        cowId: widget.breedingType == BreedingType.newBreeding
            ? '${selectedCow!.id!}'
            : selectedRepeatedCow!.cowID,
        mainDate: mainDate,
        bullName: bullNameController.text,
        bullCode: bullCodeController.text,
        farmerName: cowBloc.farmerVetName,
        semenType: selectedSemenType,
        sexType: selectedSexed,
        cost: costController.text,
        noStraw: strawNoController.text,
        dryingDate: dryingDate1,
        expectedDOB: expectedDateOfBirth,
        expectedRepeatDate: expectedRepeatDate,
        mobileNo: cowBloc.mobileNumber,
        pregnancyDate: pregnancyDate,
        recordType: 'ndume',
        pgStatus: "0",
        repeats: widget.breedingType == BreedingType.repeatBreeding
            ? '${(int.parse(selectedRepeatedCow!.repeats) + 1)}'
            : '0',
        strawBreed: '${selectedCowBreed!.id!}',
        breed1: crossBreedID1,
        breed2: crossBreedID2,
        strimingDate: strimingUpDate,
        syncDate: mainDate,
        vetID: '${sl<SessionManager>().getUserDetails()!.data!.vetId!}',
        vetName: sl<SessionManager>().getUserDetails()!.data!.vetFname!,
        isVerified: '0',
        firstHeat: heatingDate,
        secondHeat: secondHeatingDate,
        isRepeat:
            widget.breedingType == BreedingType.repeatBreeding ? '1' : '0',
        sourceOfSemen: selectedSourceOfSemen?.semenSource == "Other"
            ? sourceOfSemenController.text.trim()
            : (selectedSourceOfSemen?.semenSource ?? ""),
      );

      context.read<BreedingBloc>().add(AddBreedingEvent(
          addBreedingRecordReq: addBreedingRecordReq,
          isUpdate: widget.breedingType == BreedingType.repeatBreeding));
    }
  }

  void showMessage(String message) {
    sl<CommonFunctions>().showSnackBar(context: context, message: message);
  }

  void selectDate() async {
    await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate:
          selectedMainDate == null ? DateTime.now() : selectedMainDate!,
      lastDate: DateTime.now(),
      firstDate: DateTime(1980),
    ).then((newDate) {
      if (newDate != null) {
        selectedMainDate = newDate;
        String formattedDate = dateAndTimeFormat.format(newDate);
        selectDateController.text = formattedDate.replaceAll("00:00:00", '');
        syncAllDates();
      }
    });
  }

  void syncAllDates() {
    //Expected Date
    expectedRepeatDate = sl<CommonFunctions>()
        .generateDateAfterSpecificDate(selectedMainDate!, 18);
    //Expected DOB
    expectedDateOfBirth = sl<CommonFunctions>()
        .generateDateAfterSpecificDate(selectedMainDate!, 281);
    //Drying Date
    //dryingDate1 = sl<CommonFunctions>().generateDateAfterSpecificDate(selectedMainDate!, 197);
    dryingDate2 = sl<CommonFunctions>()
        .generateDateAfterSpecificDate(selectedMainDate!, 197);

    dryingDate1 = sl<CommonFunctions>()
        .generateDateAfterSpecificDate(selectedMainDate!, 212);
    //Pregnancy Date
    pregnancyDate = sl<CommonFunctions>()
        .generateDateAfterSpecificDate(selectedMainDate!, 91);
    //Striming Date
    strimingUpDate = sl<CommonFunctions>()
        .generateDateAfterSpecificDate(selectedMainDate!, 243);
    //Heating Date
    heatingDate = sl<CommonFunctions>()
        .generateDateAfterSpecificDate(selectedMainDate!, 295);
    //Second Heating Date
    secondHeatingDate = sl<CommonFunctions>()
        .generateDateAfterSpecificDate(selectedMainDate!, 316);

    logger.i('the Sync Dates are :'
        '\nExpected Repeat Date : $expectedRepeatDate'
        '\nExpected Date of Birth : $expectedDateOfBirth'
        '\nDrying Date  : $dryingDate1'
        '\nPregnancy Date  : $pregnancyDate'
        '\nStrimingUp Date  : $strimingUpDate'
        '\nHeating Date  : $heatingDate'
        '\nSecond Heating Date  : $secondHeatingDate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    selectedSourceOfSemen = null;
    selectedSexed = "select semen type";
    super.dispose();
  }
}
