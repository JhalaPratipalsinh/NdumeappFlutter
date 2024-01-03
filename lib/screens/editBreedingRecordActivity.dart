import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/models/breeding_model.dart';

import '../core/logger.dart';
import '../data/models/add_breeding_record_req_model.dart';
import '../data/models/source_of_semen_list_model.dart';
import '../data/sessionManager/session_manager.dart';
import '../injection_container.dart';
import '../resources/color_constants.dart';
import '../resources/image_resources.dart';
import '../util/common_functions.dart';
import '../util/constants.dart';
import 'blocs/breedingBloc/breeding_bloc.dart';
import 'cubits/sourceOfSemenChangeCubit/source_of_semen_change_cubit.dart';
import 'widgets/breeding_title_and_input_widget.dart';
import 'widgets/custom_drop_down.dart';
import 'widgets/inputfields.dart';
import 'widgets/loading_widget.dart';
import 'widgets/pregnancy_status_radio_widget.dart';
import 'widgets/semen_radio_widget.dart';
import 'widgets/semen_source_radio_widget.dart';

class EditBreedingRecordActivity extends StatefulWidget {
  final String breedingID;

  const EditBreedingRecordActivity({required this.breedingID, Key? key}) : super(key: key);

  @override
  State<EditBreedingRecordActivity> createState() => _EditBreedingRecordActivityState();
}

class _EditBreedingRecordActivityState extends State<EditBreedingRecordActivity> {
  final textStyle = const TextStyle(color: Colors.white, fontSize: 16);

  final cowNameController = TextEditingController();
  final inseminatedDateController = TextEditingController();
  final repeatDateController = TextEditingController();
  final aiCostController = TextEditingController();
  final confirmationDateController = TextEditingController();
  final dryingDateController = TextEditingController();
  final steamingDateController = TextEditingController();
  final calvingDateController = TextEditingController();
  final bullNameController = TextEditingController();
  // final sourceOfSemenController = TextEditingController();
  final bullCodeController = TextEditingController();
  final noStrawController = TextEditingController();
  BreedingData? breedingData;

  String selectedPregnancyStatus = 'No';
  String selectedSemenSource = 'SEXED';
  String selectedSemenType = 'Local Semen';

  String inseminatedDate = '';
  String repeatNo = '';
  String expectedRepeatDate = "";
  String expectedDateOfBirth = "";
  String dryingDate = "";
  String pregnancyDate = "";
  String strimingUpDate = "";
  String heatingDate = "";
  String secondHeatingDate = "";

  DateTime? selectedMainDate;
  // SourceOfSemenList? selectedSourceOfSemen;
  // SourceOfSemenList defaultSourceOfSemen = SourceOfSemenList(
  //     id: 0,
  //     semenType: "Type",
  //     semenSource: 'Select Source of Semen',
  //     createdAt: "",
  //     updatedAt: "");
  // SourceOfSemenList otherSourceOfSemen = SourceOfSemenList(
  //     id: 1,
  //     semenType: "Type",
  //     semenSource: 'Other',
  //     createdAt: "",
  //     updatedAt: "");

  @override
  void initState() {
    super.initState();
    context.read<BreedingBloc>().add(FetchBreedingDetailEvent(breedingID: widget.breedingID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreedingBloc, BreedingState>(
      listener: (_, state) {
        if (state is HandleErrorBreedingState) {
          showMessage(state.error);
        } else if (state is HandleAddBreedingState) {
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
            BlocBuilder<BreedingBloc, BreedingState>(
              builder: (_, state) {
                if (state is LoadingBreedingDetailState || state is LoadingBreedingState) {
                  return const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
                return InkWell(
                    onTap: () {
                      validateAndSubmitBreedingRecord(breedingData!);
                    },
                    child: const Icon(Icons.check));
              },
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: BlocBuilder<BreedingBloc, BreedingState>(
            buildWhen: (_, state) => state is HandleBreedingDetailState,
            builder: (_, state) {
              if (state is HandleBreedingDetailState) {
                breedingData = state.response;
                if (breedingData!.dateDt != null) {
                  inseminatedDateController.text =
                      sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingData!.dateDt!);
                  selectedMainDate = DateTime.parse(breedingData!.dateDt!);
                  inseminatedDate = dateAndTimeFormat.format(selectedMainDate!);
                } else {
                  inseminatedDateController.text = ' ';
                }
                String repeatNo = '0';
                if (breedingData!.repeats != null) {
                  repeatNo = breedingData!.repeats!;
                }
                repeatDateController.text =
                    sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingData!.expectedRepeatDate!);
                expectedRepeatDate = breedingData!.expectedRepeatDate!;

                aiCostController.text = breedingData!.cost!;

                confirmationDateController.text =
                    sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingData!.pregnancyDate!);
                pregnancyDate = breedingData!.pregnancyDate!;

                selectedPregnancyStatus = breedingData!.pgStatus == '0' ? 'No' : 'Yes';

                dryingDateController.text =
                    sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingData!.dryingDate!);
                dryingDate = breedingData!.dryingDate!;

                steamingDateController.text =
                    sl<CommonFunctions>().convertDateToDDMMMYYYY(breedingData!.strimingupDate!);

                strimingUpDate = breedingData!.strimingupDate!;

                calvingDateController.text = sl<CommonFunctions>()
                    .convertDateToDDMMMYYYY(breedingData!.expectedDateOfBirth!);
                expectedDateOfBirth = breedingData!.expectedDateOfBirth!;

                bullNameController.text = breedingData!.bullName!;
                bullCodeController.text = breedingData!.bullCode!;
                if (breedingData!.sexType != null) {
                  selectedSemenSource = breedingData!.sexType! == 'Sexed' ? 'SEXED' : 'NON SEXED';
                }
                if (breedingData!.semenType != null) {
                  selectedSemenType =
                      breedingData!.semenType! == 'Local Semen' ? 'Local Semen' : 'Imported Semen';
                }
                noStrawController.text = breedingData!.noStraw!;

                heatingDate = breedingData!.firstHeat!;

                secondHeatingDate = breedingData!.secondHeat!;

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
                        InkWell(
                          onTap: () {
                            selectDate();
                          },
                          child: IgnorePointer(
                            ignoring: true,
                            ignoringSemantics: true,
                            child: BreedingTitleAndInputWidget(
                                controller: inseminatedDateController,
                                inputText: '',
                                isEditable: true,
                                showSuffixIcon: true,
                                title: 'Date Inseminated'),
                          ),
                        ),
                        BreedingTitleAndInputWidget(
                          controller: repeatDateController,
                          inputText: '',
                          title: 'Repeat Date',
                          isEditable: true,
                          showSuffixIcon: true,
                        ),
                        BreedingTitleAndInputWidget(
                          controller: aiCostController,
                          inputText: '1500',
                          title: 'AI COST',
                          isEditable: true,
                          inputType: TextInputType.number,
                          enableEditableInputField: true,
                        ),
                        BreedingTitleAndInputWidget(
                          controller: confirmationDateController,
                          inputText: 'Apr 20,2022',
                          title: 'CONFIRMATION DATE',
                          showSuffixIcon: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'PREGNANCY STATUS',
                          style: textStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PregnancyStatusRadioWidget(
                            selectedValue: selectedPregnancyStatus,
                            onValueSelect: (String value) {
                              selectedPregnancyStatus = value;
                            }),
                        BreedingTitleAndInputWidget(
                          controller: dryingDateController,
                          inputText: 'Apr 20,2022',
                          title: 'DRYING DATE',
                          isEditable: true,
                          showSuffixIcon: true,
                        ),
                        BreedingTitleAndInputWidget(
                          controller: steamingDateController,
                          inputText: 'Apr 20,2022',
                          title: 'STEAMING DATE',
                          isEditable: true,
                          showSuffixIcon: true,
                        ),
                        BreedingTitleAndInputWidget(
                          controller: calvingDateController,
                          inputText: 'Apr 20,2022',
                          title: 'CALVING DATE',
                          isEditable: true,
                        ),
                        BreedingTitleAndInputWidget(
                          controller: bullNameController,
                          inputText: 'Bull Name',
                          title: 'BULL NAME',
                          isEditable: true,
                          enableEditableInputField: true,
                        ),
                        BreedingTitleAndInputWidget(
                          controller: bullCodeController,
                          inputText: 'Bull code',
                          title: 'BULL CODE',
                          isEditable: true,
                          inputType: TextInputType.number,
                          enableEditableInputField: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'SEMEN SOURCE',
                          style: textStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SemenSourceRadioWidget(
                            selectedValue: selectedSemenSource,
                            onValueSelect: (String value) {
                              selectedSemenSource = value;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'SEMEN TYPE',
                          style: textStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SemenRadioWidget(
                            selectedValue: selectedSemenType,
                            onValueSelect: (String value) {
                              selectedSemenType = value;
                            }),
                        BreedingTitleAndInputWidget(
                          controller: noStrawController,
                          inputText: 'No of straw',
                          title: 'NUMBER OF STRAW USED',
                          isEditable: true,
                          enableEditableInputField: true,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            }),
      ),
    );
  }

  // Widget _buildSourceOfSemenDropDown() {
  //   return BlocBuilder<BreedingBloc, BreedingState>(
  //     buildWhen: (previous, current) {
  //       if (current is LoadingFetchSourceOfSemenListState ||
  //           current is HandleFetchSourceOfSemenListState ||
  //           current is HandleErrorSourceOfSemenListState) {
  //         return true;
  //       }
  //       return false;
  //     },
  //     builder: (context, state) {
  //       if (state is LoadingFetchSourceOfSemenListState) {
  //         return const LoadingWidget();
  //       } else if (state is HandleFetchSourceOfSemenListState) {
  //         final sourceOfSemenList = [
  //               defaultSourceOfSemen,
  //             ] +
  //             (state.response.sourceOfSemenList ?? []) +
  //             [otherSourceOfSemen];
  //         return Column(
  //           children: [
  //             CustomDropDown<SourceOfSemenList>(
  //                 value: selectedSourceOfSemen ?? defaultSourceOfSemen,
  //                 itemsList: sourceOfSemenList,
  //                 dropdownColor: Colors.white,
  //                 showDropdown: false,
  //                 dropDownMenuItems: sourceOfSemenList
  //                     .map((item) => DropdownMenuItem<SourceOfSemenList>(
  //                           value: item,
  //                           child: Align(
  //                               alignment: Alignment.center,
  //                               child: Text(
  //                                 item.semenSource,
  //                                 textAlign: TextAlign.center,
  //                               )),
  //                         ))
  //                     .toList(),
  //                 onChanged: (SourceOfSemenList value) {
  //                   selectedSourceOfSemen = value;
  //                   context
  //                       .read<SourceOFSemenChangeCubit>()
  //                       .selectSourceOfSemen(
  //                           selectedSourceOfSemen?.semenSource ?? "");
  //                 }),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             _buildSourceOfSemenTextField()
  //           ],
  //         );
  //       } else if (state is HandleErrorSourceOfSemenListState) {
  //         return ErrorWidget.withDetails(
  //           message: "${state.statusCode}\n${state.error}",
  //         );
  //       }
  //       return const SizedBox();
  //     },
  //   );
  // }

  // Widget _buildSourceOfSemenTextField() {
  //   return BlocBuilder<SourceOFSemenChangeCubit, String>(
  //     builder: (context, state) {
  //       if (state == "Other") {
  //         return Column(
  //           children: [
  //             InputTextField(
  //               controller: sourceOfSemenController,
  //               isTextCenter: true,
  //               hint: "Enter source of semen",
  //               inputType: TextInputType.text,
  //               inputIcon: '',
  //             ),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //           ],
  //         );
  //       } else {
  //         return const SizedBox();
  //       }
  //     },
  //   );
  // }

  void selectDate() async {
    await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedMainDate == null ? DateTime.now() : selectedMainDate!,
      lastDate: DateTime.now(),
      firstDate: DateTime(2020),
    ).then((newDate) {
      if (newDate != null) {
        selectedMainDate = newDate;
        inseminatedDate = dateAndTimeFormat.format(selectedMainDate!);
        String formattedDate = dateAndTimeFormat.format(newDate);
        inseminatedDateController.text =
            sl<CommonFunctions>().convertDateToDDMMMYYYY(formattedDate);
        syncAllDates();
      }
    });
  }

  void validateAndSubmitBreedingRecord(BreedingData data) async {
    final result = await sl<CommonFunctions>().showConfirmationDialog(
      context: context,
      title: 'Confirm Update !!',
      message: 'Are you sure you want to update this breeding record',
      buttonPositiveText: 'Yes',
      buttonNegativeText: 'No',
    );

    if (!result) {
      return;
    }

    if (bullNameController.text.isEmpty) {
      showMessage('Please enter bull name');
    } 
    // else if (selectedSourceOfSemen == defaultSourceOfSemen) {
    //   showMessage('Please select source of semen');
    // } else if (selectedSourceOfSemen == otherSourceOfSemen &&
    //     sourceOfSemenController.text.trim() == "") {
    //   showMessage('Please enter source of semen');
    // } 
    else if (bullCodeController.text.isEmpty) {
      showMessage('Please enter bull code');
    } else if (aiCostController.text.isEmpty) {
      showMessage('Please enter cost');
    } else if (noStrawController.text.isEmpty) {
      showMessage('Please enter straw no');
    } else {
      final addBreedingRecordReq = AddBreedingRecordReqModel(
        breedingID: '${data.id}',
        cowName: data.cowName!,
        cowId: data.cowId!,
        mainDate: inseminatedDate,
        bullName: bullNameController.text,
        bullCode: bullCodeController.text,
        farmerName: data.farmerName!,
        semenType: selectedSemenType,
        sexType: selectedSemenSource,
        cost: aiCostController.text,
        noStraw: noStrawController.text,
        dryingDate: dryingDate,
        expectedDOB: expectedDateOfBirth,
        expectedRepeatDate: expectedRepeatDate,
        mobileNo: data.mobile!,
        pregnancyDate: pregnancyDate,
        recordType: 'ndume',
        pgStatus: selectedPregnancyStatus == 'No' ? '0' : '1',
        repeats: data.repeats!,
        strawBreed: data.strawBreed!,
        breed1: data.breed1,
        breed2: data.breed2,
        strimingDate: strimingUpDate,
        syncDate: inseminatedDate,
        vetID: '${sl<SessionManager>().getUserDetails()!.data!.vetId!}',
        vetName:
            '${sl<SessionManager>().getUserDetails()!.data!.vetFname!}',
        isVerified: '0',
        firstHeat: heatingDate,
        secondHeat: secondHeatingDate, isRepeat: '0',
         sourceOfSemen: data.sourceOfSemen!,
      );

      if (!mounted) return;
      context
          .read<BreedingBloc>()
          .add(AddBreedingEvent(addBreedingRecordReq: addBreedingRecordReq, isUpdate: true));
    }
  }

  void showMessage(String message) {
    sl<CommonFunctions>().showSnackBar(context: context, message: message);
  }

  void syncAllDates() {
    //Expected Date
    expectedRepeatDate = sl<CommonFunctions>().generateDateAfterSpecificDate(selectedMainDate!, 18);
    repeatDateController.text = sl<CommonFunctions>().convertDateToDDMMMYYYY(expectedRepeatDate);

    //Expected DOB
    expectedDateOfBirth =
        sl<CommonFunctions>().generateDateAfterSpecificDate(selectedMainDate!, 281);
    calvingDateController.text = sl<CommonFunctions>().convertDateToDDMMMYYYY(expectedDateOfBirth);

    //Drying Date
    dryingDate = sl<CommonFunctions>().generateDateAfterSpecificDate(selectedMainDate!, 212);
    dryingDateController.text = sl<CommonFunctions>().convertDateToDDMMMYYYY(dryingDate);

    //Pregnancy Date
    pregnancyDate = sl<CommonFunctions>().generateDateAfterSpecificDate(selectedMainDate!, 90);
    confirmationDateController.text = sl<CommonFunctions>().convertDateToDDMMMYYYY(pregnancyDate);

    //Striming Date
    strimingUpDate = sl<CommonFunctions>().generateDateAfterSpecificDate(selectedMainDate!, 222);
    steamingDateController.text = sl<CommonFunctions>().convertDateToDDMMMYYYY(strimingUpDate);

    //Heating Date
    heatingDate = sl<CommonFunctions>().generateDateAfterSpecificDate(selectedMainDate!, 299);

    //Second Heating Date
    secondHeatingDate = sl<CommonFunctions>().generateDateAfterSpecificDate(selectedMainDate!, 336);

    logger.i('the Sync Dates are :'
        '\nExpected Repeat Date : $expectedRepeatDate'
        '\nExpected Date of Birth : $expectedDateOfBirth'
        '\nDrying Date  : $dryingDate'
        '\nPregnancy Date  : $pregnancyDate'
        '\nStrimingUp Date  : $strimingUpDate'
        '\nHeating Date  : $heatingDate'
        '\nSecond Heating Date  : $secondHeatingDate');
  }
}
