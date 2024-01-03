import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/core/logger.dart';
import 'package:ndumeappflutter/data/models/cow_breeds_group_model.dart';
import 'package:ndumeappflutter/data/models/register_cow_req_model.dart';
import 'package:ndumeappflutter/injection_container.dart';
import 'package:ndumeappflutter/screens/blocs/cowRecordBloc/cow_record_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:ndumeappflutter/util/common_functions.dart';

import '../resources/color_constants.dart';
import '../util/constants.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_drop_down.dart';
import 'widgets/inputfields.dart';

class RegisterCowActivity extends StatefulWidget {
  const RegisterCowActivity({Key? key}) : super(key: key);

  @override
  State<RegisterCowActivity> createState() => _RegisterCowActivityState();
}

class _RegisterCowActivityState extends State<RegisterCowActivity> {
  CowBreeds? selectedCowBreed;
  CowGroups? selectedCowGroup;

  int crossBreedID1 = 1;
  int crossBreedID2 = 1;
  ValueNotifier<bool> showCrossBreedViewNotifier = ValueNotifier(false);
  DateTime? selectedDate;

  final cowNameController = TextEditingController();
  final dateOfBirth = TextEditingController();
  final noLactationsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CowRecordBloc>().add(const FetchCowBreedsAndGroupEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CowRecordBloc, CowRecordState>(
      listener: (_, state) {
        if (state is HandleRegisterNewCowState) {
          sl<CommonFunctions>()
              .showSnackBar(context: context, message: state.response.message!);
          Navigator.of(context).pop();
        } else if (state is CowRecordsErrorState) {
          sl<CommonFunctions>()
              .showSnackBar(context: context, message: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstants.colorPrimaryDark,
        appBar: AppBar(
          backgroundColor: ColorConstants.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Register New Cow',
            style: TextStyle(color: Colors.white, fontSize: 18),
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
                  const SizedBox(
                    height: 15,
                  ),
                  InputTextField(
                    controller: cowNameController,
                    hint: "Cow Name",
                    inputType: TextInputType.text,
                    inputIcon: '',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<CowRecordBloc, CowRecordState>(
                      buildWhen: (_, state) =>
                          state is LoadCowBreedsAndGroupState,
                      builder: (_, state) {
                        if (state is LoadCowBreedsAndGroupState) {
                          //final cowBreedList = state.cowBreedsAndGroup.cowBreeds!;
                          final cowBreedList =
                              state.cowBreedsAndGroup.cowBreeds!.map((e) {
                            if (e.id == 0) {
                              e.setParams('Select Breed', 0);
                            }
                            return e;
                          }).toList();

                          final cowGroupList =
                              state.cowBreedsAndGroup.cowGroups!;

                          selectedCowBreed = cowBreedList.first;
                          selectedCowGroup = cowGroupList.first;

                          return Column(
                            children: [
                              CustomDropDown<CowBreeds>(
                                  value: selectedCowBreed!,
                                  itemsList: cowBreedList,
                                  dropdownColor: Colors.white,
                                  dropDownMenuItems: cowBreedList
                                      .map(
                                          (item) => DropdownMenuItem<CowBreeds>(
                                                value: item,
                                                child: Text(item.name!),
                                              ))
                                      .toList(),
                                  onChanged: (CowBreeds value) {
                                    selectedCowBreed = value;
                                    showCrossBreedViewNotifier.value =
                                        selectedCowBreed!.id! == 13;
                                  }),
                              ValueListenableBuilder<bool>(
                                  valueListenable: showCrossBreedViewNotifier,
                                  builder: (_, showCrossBreedView, __) {
                                    final cowCrossBreedList = cowBreedList
                                        .where((element) => element.id! != 13)
                                        .map((e) {
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
                                                    child: CustomDropDown<
                                                            CowBreeds>(
                                                        margin: 5,
                                                        value: cowCrossBreedList.first,
                                                        itemsList:
                                                            cowCrossBreedList,
                                                        dropdownColor:
                                                            Colors.white,
                                                        dropDownMenuItems:
                                                            cowCrossBreedList
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        CowBreeds>(
                                                                      value:
                                                                          item,
                                                                      child: Text(
                                                                          item.name!),
                                                                    ))
                                                                .toList(),
                                                        onChanged:
                                                            (CowBreeds value) {
                                                          crossBreedID1 =
                                                              value.id!;
                                                        }),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: CustomDropDown<
                                                            CowBreeds>(
                                                        margin: 5,
                                                        value: cowCrossBreedList.first,
                                                        itemsList:
                                                            cowCrossBreedList,
                                                        dropdownColor:
                                                            Colors.white,
                                                        dropDownMenuItems:
                                                            cowCrossBreedList
                                                                .map((item) =>
                                                                    DropdownMenuItem<
                                                                        CowBreeds>(
                                                                      value:
                                                                          item,
                                                                      child: Text(
                                                                          item.name!),
                                                                    ))
                                                                .toList(),
                                                        onChanged:
                                                            (CowBreeds value) {
                                                          crossBreedID2 =
                                                              value.id!;
                                                          print("breed id ${crossBreedID2}");
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
                              const SizedBox(
                                height: 15,
                              ),
                              CustomDropDown<CowGroups>(
                                  value: selectedCowGroup!,
                                  itemsList: cowGroupList,
                                  dropdownColor: Colors.white,
                                  dropDownMenuItems: cowGroupList
                                      .map(
                                          (item) => DropdownMenuItem<CowGroups>(
                                                value: item,
                                                child: Text(item.name!),
                                              ))
                                      .toList(),
                                  onChanged: (CowGroups value) {
                                    selectedCowGroup = value;
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                  InkWell(
                    onTap: () {
                      selectDate();
                    },
                    child: InputTextField(
                      controller: dateOfBirth,
                      isEnabled: false,
                      hint: "Select date of birth",
                      inputType: TextInputType.text,
                      inputIcon: '',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InputTextField(
                    controller: noLactationsController,
                    hint: "No of Calving's/ Lactations's",
                    inputType: TextInputType.number,
                    inputIcon: '',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  BlocBuilder<CowRecordBloc, CowRecordState>(
                    builder: (_, state) {
                      if (state is LoadingRegistrationNewCowState) {
                        return const LoadingWidget();
                      }
                      return ButtonWidget(
                        buttonText: "Register".toUpperCase(),
                        onPressButton: () => validateAndRegisterCow(),
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

  void validateAndRegisterCow() {
    Set<int> data = {};
    bool result = data.add(0);

    if (cowNameController.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter cow name');
      return;
    } else if (isCowNameExist()) {
      sl<CommonFunctions>().showSnackBar(
          context: context,
          message: 'Cow name already exist please enter other name.');
    } else if (selectedCowBreed == null) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please select cow breed');
      return;
    } else if (selectedCowBreed!.id == 0) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please select cow breed');
      return;
    } else if (selectedCowBreed!.id == 13 &&
        (crossBreedID1 == 0 || crossBreedID2 == 0)) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please select cow cross breed');
      return;
    } else if (selectedCowGroup == null) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please select cow group');
      return;
    } else if (selectedCowGroup!.id == 0) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please select cow group');
      return;
    } else if (dateOfBirth.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please select date of birth');
      return;
    } else if (noLactationsController.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please enter no of calvings/lactations');
      return;
    } else {
      String mainDate = dateAndTimeFormat.format(selectedDate!);
      final registerCowReq = RegisterCowReqModel(
        breedID: '${selectedCowBreed!.id!}',
        title: cowNameController.text,
        groupID: '${selectedCowGroup!.id!}',
        mobileNo: context.read<CowRecordBloc>().mobileNumber,
        birthDate: mainDate,
        calvingLactations: noLactationsController.text,
        cowBreedID1: selectedCowBreed!.id! == 13 ? '$crossBreedID1' : '',
        cowBreedID2: selectedCowBreed!.id! == 13 ? '$crossBreedID2' : '',
      );
      context
          .read<CowRecordBloc>()
          .add(RegisterNewCowEvent(registerCowReq: registerCowReq));
    }
  }

  bool isCowNameExist() {
    final cowList = context.read<CowRecordBloc>().fetchCowList();
    bool nameExist = false;
    for (var element in cowList) {
      logger.i(
          'the cow title is ${element.title?.toLowerCase()}\nthe cow entered is ${cowNameController.text.toString().toLowerCase()} ');
      if (element.title?.toLowerCase() ==
          cowNameController.text.toString().toLowerCase()) {
        nameExist = true;
        break;
      }
    }
    return nameExist;
  }

  void selectDate() async {
    final previousYearDate = DateTime(
        DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
    await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedDate == null ? previousYearDate : selectedDate!,
      lastDate: previousYearDate,
      firstDate: DateTime(1990),
    ).then((newDate) {
      if (newDate != null) {
        selectedDate = newDate;
        String formattedDate = dateAndTimeFormat.format(newDate);
        dateOfBirth.text = formattedDate.replaceAll("00:00:00", '');
      }
    });
  }
}
