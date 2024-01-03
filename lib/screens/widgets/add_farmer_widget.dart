import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/models/CountyListModel.dart';
import 'package:ndumeappflutter/data/models/SubcountyListModel.dart';
import 'package:ndumeappflutter/data/models/WardListModel.dart';
import 'package:ndumeappflutter/data/models/add_farmer_req_model.dart';
import 'package:ndumeappflutter/injection_container.dart';
import 'package:ndumeappflutter/repository/master_repository.dart';
import 'package:ndumeappflutter/screens/blocs/homeBloc/home_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/farmer_type_widget.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/logger.dart';
import '../../resources/color_constants.dart';
import '../../util/common_functions.dart';
import '../blocs/loginBloc/login_bloc.dart';
import 'custom_button.dart';
import 'custom_drop_down.dart';
import 'text_field_widget.dart';

class AddFarmerWidget extends StatefulWidget {
  const AddFarmerWidget({Key? key}) : super(key: key);

  @override
  State<AddFarmerWidget> createState() => _AddFarmerWidgetState();
}

class _AddFarmerWidgetState extends State<AddFarmerWidget> {
  CountyList? selectedCounty;
  SubcountyList? selectedSubCounty;
  WardList? selectedWard;
  List<CountyList> countyList = [];
  String selectedFarmerType = 'Male';
  ValueNotifier<bool> isTermsCondition = ValueNotifier(false);

  final _farmerController = TextEditingController();
  final _mobileController = TextEditingController();
  final _copmobileController = TextEditingController();
  final _confirmMobileController = TextEditingController();
  final _cooperativeNameController = TextEditingController();
  final _farmerGroupController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final county = sl<MasterRepository>().getCachedCountyList();
    if (county != null) {
      countyList = county.data!;
      selectedCounty = countyList.first;
      context.read<LoginBloc>().add(GetSubCountyEvent(selectedCounty!.county!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (_, state) {
        if (state is HandleAddFarmerState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.response.message!,
          );
          _farmerGroupController.clear();
          _farmerController.clear();
          _cooperativeNameController.clear();
          _mobileController.clear();
          _confirmMobileController.clear();
          _copmobileController.clear();
        }else if(state is HandleSearchState){
          sl<CommonFunctions>().showSnackBar(
              context: context, message: state.response.message.toString());
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Farmer not registered. Please Register New Farmer',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            controller: _farmerController,
            hint: 'Enter Farmer Name',
            textInputType: TextInputType.name,
          ),
          TextFieldWidget(
            controller: _mobileController,
            hint: 'Enter Mobile No.',
            textInputType: TextInputType.number,
          ),
          TextFieldWidget(
            controller: _confirmMobileController,
            hint: 'Confirm Mobile No.',
            textInputType: TextInputType.number,
          ),
          TextFieldWidget(
            controller: _cooperativeNameController,
            hint: 'Enter cooperative Name',
            textInputType: TextInputType.name,
          ),
          TextFieldWidget(
            controller: _copmobileController,
            hint: 'Enter cooperative number',
            textInputType: TextInputType.name,
          ),
          TextFieldWidget(
            controller: _farmerGroupController,
            hint: 'Enter farmer Group',
            textInputType: TextInputType.name,
          ),
          const SizedBox(
            height: 10,
          ),
          FarmerTypeWidget(
              selectedValue: selectedFarmerType,
              onValueSelect: (String value) {
                selectedFarmerType = value;
              }),
          const SizedBox(
            height: 10,
          ),
          CustomDropDown<CountyList>(
              value: selectedCounty!,
              itemsList: countyList,
              margin: 0,
              dropdownColor: Colors.white,
              dropDownMenuItems: countyList
                  .map((item) => DropdownMenuItem<CountyList>(
                        value: item,
                        child: Text(item.county!),
                      ))
                  .toList(),
              onChanged: (CountyList value) async {
                selectedCounty = value;
                if (selectedCounty!.county! != 'Select County') {
                  setState(() {});
                  await Future.delayed(const Duration(milliseconds: 800));
                  if (mounted) {
                    context
                        .read<LoginBloc>()
                        .add(GetSubCountyEvent(selectedCounty!.county!));
                  }
                }
              }),
          const SizedBox(
            height: 10,
          ),
          getSubCounty(),
          const SizedBox(
            height: 10,
          ),
          getWard(),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ValueListenableBuilder(
                valueListenable: isTermsCondition,
                builder: (BuildContext context, bool value, Widget? child) {
                  return Checkbox(
                    fillColor: getColor(),
                    value: isTermsCondition.value,
                    onChanged: (bool? newValue) {
                      isTermsCondition.value = newValue ?? false;
                      isTermsCondition.notifyListeners();
                    },
                  );
                },
              ),
              const Text(
                "Terms & Conditions",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                width: 7,
              ),
              InkWell(
                  onTap: () async {
                    final uri = Uri.parse(
                        'https://customer.digicow.co.ke/TERMS_AND_CONDITIONS_FOR_DIGICOW_DAIRY_APP.htm');
                    await launchUrl(uri);
                  },
                  child: const Text(
                    "view",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (_, state) {
              if (state is AddFarmerLoadingState) {
                return const LoadingWidget();
              }
              return ButtonWidget(
                buttonText: 'Register'.toUpperCase(),
                onPressButton: () => _validateAndAddFarmer(),
                isWrap: true,
                buttonInnerPadding: 15,
                buttonColor: ColorConstants.green,
                textColor: Colors.white,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getSubCounty() {
    if (selectedCounty!.county! == "Select County") {
      return CustomDropDown<String>(
          value: 'Select Subcounty',
          itemsList: const ['Select Subcounty'],
          dropdownColor: Colors.white,
          margin: 0,
          dropDownMenuItems: ['Select Subcounty']
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (SubcountyList value) {});
    }
    return BlocBuilder<LoginBloc, LoginState>(buildWhen: (context, state) {
      if (state is SetSubCountyState || state is SubCountyLoadingState) {
        return true;
      }
      return false;
    }, builder: (_, state) {
      if (state is SubCountyLoadingState) {
        return const LoadingWidget();
      }
      if (state is SetSubCountyState) {
        if (selectedSubCounty == null ||
            !state.subCountyList.data!.contains(selectedSubCounty!)) {
          selectedSubCounty = state.subCountyList.data!.first;
        }
        final list = state.subCountyList.data!;
        context.read<LoginBloc>().add(GetWardEvent(
            selectedCounty!.county!, selectedSubCounty!.subcounty!));

        return CustomDropDown<SubcountyList>(
            value: selectedSubCounty!,
            itemsList: list,
            dropdownColor: Colors.white,
            margin: 0,
            dropDownMenuItems: list
                .map((item) => DropdownMenuItem<SubcountyList>(
                      value: item,
                      child: Text(item.subcounty!),
                    ))
                .toList(),
            onChanged: (SubcountyList value) async {
              selectedSubCounty = value;
              if (selectedSubCounty!.county!.isNotEmpty) {
                setState(() {});
                await Future.delayed(const Duration(milliseconds: 800));
                if (mounted) {
                  context.read<LoginBloc>().add(
                      GetWardEvent(selectedCounty!.county!, value.subcounty!));
                }
              }
            });
      }

      return const SizedBox();
    });
  }

  Widget getWard() {
    if (selectedSubCounty == null) {
      return CustomDropDown<String>(
          value: 'Select ward',
          itemsList: const ['Select ward'],
          dropdownColor: Colors.white,
          margin: 0,
          dropDownMenuItems: ['Select ward']
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (SubcountyList value) {});
    } else if (selectedSubCounty!.county!.isEmpty) {
      return CustomDropDown<String>(
          value: 'Select ward',
          itemsList: const ['Select ward'],
          dropdownColor: Colors.white,
          margin: 0,
          dropDownMenuItems: ['Select ward']
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (SubcountyList value) {});
    }
    return BlocBuilder<LoginBloc, LoginState>(buildWhen: (context, state) {
      if (state is SetWardState || state is WardLoadingState) {
        return true;
      }
      return false;
    }, builder: (_, state) {
      if (state is WardLoadingState) {
        return const LoadingWidget();
      }
      if (state is SetWardState) {
        if (selectedWard == null ||
            !state.wardList.data!.contains(selectedWard!)) {
          selectedWard = state.wardList.data!.first;
        }
        //selectedWard = state.wardList.data!.first;

        final list = state.wardList.data!;

        return CustomDropDown<WardList>(
            value: selectedWard!,
            itemsList: list,
            dropdownColor: Colors.white,
            margin: 0,
            dropDownMenuItems: list
                .map((item) => DropdownMenuItem<WardList>(
                      value: item,
                      child: Text(item.ward!),
                    ))
                .toList(),
            onChanged: (WardList value) {
              selectedWard = value;
            });
      }

      return const SizedBox();
    });
  }

  MaterialStateProperty<Color?> getColor() {
    return MaterialStateProperty.resolveWith((states) {
      if (isTermsCondition.value) {
        return ColorConstants
            .colorPrimaryDark; // Color when checkbox is checked
      } else {
        return Colors.black; // Color when checkbox is unchecked
      }
    });
  }

  void _validateAndAddFarmer() {
    if (_farmerController.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter farmer name');
      return;
    } else if (_mobileController.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please enter mobile number');
      return;
    } else if (_confirmMobileController.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please confirm mobile number');
      return;
    } else if (_confirmMobileController.text != _mobileController.text) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'mobile number did not matched');
      return;
    } else if (_cooperativeNameController.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please enter cooperative name');
      return;
    } else if (_copmobileController.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please Enter Cooperative mobile No.');
      return;
    } else if (_farmerGroupController.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter farmer group');
      return;
    } else if (selectedCounty!.county! == 'Select County') {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please select county');
      return;
    } else if (selectedSubCounty!.county!.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please select sub county');
      return;
    } else if (selectedWard!.county!.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please select war');
      return;
    } else if (!isTermsCondition.value) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please check Terms & condition');
      return;
    } else {
      final mobileNumber =
          sl<CommonFunctions>().checkNumberIsValid(_mobileController.text);
      final coopMobileNumber=sl<CommonFunctions>().checkNumberIsValid(_cooperativeNameController.text);
      logger.i('the number entered is :$mobileNumber');

      if (mobileNumber.length == 12) {
        final addFarmerReq = AddFarmerReqModel(
            farmerName: _farmerController.text,
            mobileNumber: mobileNumber,
            county: selectedCounty!.county!,
            subCounty: selectedSubCounty!.subcounty!,
            ward: selectedWard!.ward!,
            cooperativeName: coopMobileNumber,
            groupName: _farmerGroupController.text,
            farmerType: selectedFarmerType,
            copmobileNumber: _copmobileController.text);
        context
            .read<HomeBloc>()
            .add(AddFarmerEvent(addFarmerReq: addFarmerReq));
      } else {
        sl<CommonFunctions>().showSnackBar(
          context: context,
          message: 'Please enter valid mobile number',
        );
      }
    }
  }
}
