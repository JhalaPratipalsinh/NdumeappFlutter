import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/data/models/WardListModel.dart';
import 'package:ndumeappflutter/data/models/registration_req_model.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';
import 'package:ndumeappflutter/screens/blocs/loginBloc/login_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/custom_button.dart';
import 'package:ndumeappflutter/screens/widgets/custom_drop_down.dart';
import 'package:ndumeappflutter/screens/widgets/inputfields.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:ndumeappflutter/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/logger.dart';
import '../data/models/CountyListModel.dart';
import '../data/models/SubcountyListModel.dart';
import '../injection_container.dart';
import '../util/common_functions.dart';

class RegistrationActivity extends StatefulWidget {
  const RegistrationActivity({Key? key}) : super(key: key);

  @override
  State<RegistrationActivity> createState() => _RegistrationActivityState();
}

class _RegistrationActivityState extends State<RegistrationActivity> {
  String selectedCounty = "";
  String selectedSubCounty = "";
  String selectedWard = "";
  ValueNotifier<String> selectedUser =ValueNotifier("Select User");

  List<String> userType = ["Select User", "Intern", "Paravet", "Vet Surgeon"];

  ValueNotifier<bool> isTermsCondition = ValueNotifier(false);

  TextEditingController firstCntrl = TextEditingController();
  TextEditingController lastCntrl = TextEditingController();
  TextEditingController sNameCntrl = TextEditingController();
  TextEditingController phonenoCntrl = TextEditingController();
  TextEditingController rephonenoCntrl = TextEditingController();
  TextEditingController kvbnoCntrl = TextEditingController();
  TextEditingController pinCntrl = TextEditingController();
  TextEditingController repinCntrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(const GetCountyEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (_, state) {
        if (state is ErrorState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.message,
            bgColor: Colors.red,
          );
        } else if (state is RegistrationResponseState) {
          if (state.response.success!) {
            sl<CommonFunctions>().showSnackBar(
              context: context,
              message: state.response.message!,
            );
            Navigator.pushReplacementNamed(
              context,
              loginPage,
            );
          } else {
            sl<CommonFunctions>().showSnackBar(
              context: context,
              message: state.response.message!,
            );
          }
        }
      },
      child: WillPopScope(
        onWillPop: () {
          Navigator.pushReplacementNamed(
            context,
            startScreen,
          );

          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: ColorConstants.colorPrimaryDark,
          appBar: AppBar(
            backgroundColor: ColorConstants.colorPrimary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  startScreen,
                );
              },
            ),
            centerTitle: true,
            title: const Text(
              "Provider Registration",
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
                      height: 50,
                    ),
                    InputTextField(
                        controller: firstCntrl,
                        hint: "Enter first name",
                        inputType: TextInputType.text,
                        inputIcon: '${icon}ic_action_name.png'),
                    const SizedBox(
                      height: 25,
                    ),
                    InputTextField(
                      controller: lastCntrl,
                      hint: "Enter last name",
                      inputType: TextInputType.text,
                      inputIcon: '${icon}ic_action_name.png',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InputTextField(
                      controller: phonenoCntrl,
                      hint: "Enter Phone no.",
                      inputType: TextInputType.number,
                      inputIcon: '${icon}phone_icon.png',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InputTextField(
                      controller: rephonenoCntrl,
                      hint: "Re-enter Phone no.",
                      inputType: TextInputType.number,
                      inputIcon: '${icon}phone_icon.png',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    getCounty(),
                    const SizedBox(
                      height: 25,
                    ),
                    getSubCounty(),
                    const SizedBox(
                      height: 25,
                    ),
                    getWard(),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomDropDown<String>(
                        value: selectedUser.value,
                        itemsList: userType,
                        dropdownColor: Colors.white,
                        dropDownMenuItems: userType
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item!),
                                ))
                            .toList(),
                        onChanged: (String value) {
                          selectedUser.value = value;
                          selectedUser.notifyListeners();
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    ValueListenableBuilder(valueListenable: selectedUser,
                        builder:(context, value, child) {
                          if(value=="Intern"){
                            return InputTextField(
                              controller: kvbnoCntrl,
                              hint: "KVB no. of supervisor",
                              inputType: TextInputType.text,
                              inputIcon: '${icon}ic_number.png',
                            );
                          }else{
                            return InputTextField(
                              controller: kvbnoCntrl,
                              hint: "KVB no.",
                              inputType: TextInputType.text,
                              inputIcon: '${icon}ic_number.png',
                            );
                          }
                        },
                    ),

                    const SizedBox(
                      height: 25,
                    ),
                    InputTextField(
                      controller: pinCntrl,
                      hint: "Create new PIN.",
                      inputType: TextInputType.number,
                      obscureText: true,
                      inputIcon: '${icon}lock_icon.png',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InputTextField(
                      controller: repinCntrl,
                      hint: "Re-enter the PIN.",
                      inputType: TextInputType.number,
                      obscureText: true,
                      inputIcon: '${icon}lock_icon.png',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 27, left: 20),
                      child: Row(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: isTermsCondition,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
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
                            "Terms & Condition",
                            style: TextStyle(fontSize: 14, color: Colors.white),
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
                                style:
                                    TextStyle(fontSize: 14, color: Colors.blue),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (_, state) {
                        if (state is MasterLoadingState) {
                          return const SizedBox.shrink();
                        }
                        return Center(
                          child: ButtonWidget(
                            buttonText: "Register",
                            onPressButton: () {
                              validateAndRegistration();
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (_, state) {
                  if (state is MasterLoadingState) {
                    return const LoadingWidget();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  MaterialStateProperty<Color?> getColor() {
    return MaterialStateProperty.resolveWith((states) {
      if (isTermsCondition.value) {
        return Colors.yellow; // Color when checkbox is checked
      } else {
        return Colors.white; // Color when checkbox is unchecked
      }
    });
  }

  Widget getCounty() {
    return BlocBuilder<LoginBloc, LoginState>(buildWhen: (context, state) {
      if (state is SetCountyState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      if (state is SetCountyState) {
        selectedCounty = state.countyList.data!.first.county!;
        context.read<LoginBloc>().add(GetSubCountyEvent(selectedCounty));
        return CustomDropDown<CountyList>(
            value: state.countyList.data!.first,
            itemsList: state.countyList.data!,
            dropdownColor: Colors.white,
            dropDownMenuItems: state.countyList.data!
                .map((item) => DropdownMenuItem<CountyList>(
                      value: item,
                      child: Text(item.county!),
                    ))
                .toList(),
            onChanged: (CountyList value) {
              selectedCounty = value.county!;
              context.read<LoginBloc>().add(GetSubCountyEvent(selectedCounty));
            });
      }

      return const SizedBox();
    });
  }

  Widget getSubCounty() {
    return BlocBuilder<LoginBloc, LoginState>(buildWhen: (context, state) {
      if (state is SetSubCountyState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      if (state is SetSubCountyState) {
        selectedSubCounty = state.subCountyList.data!.first.subcounty!;
        context
            .read<LoginBloc>()
            .add(GetWardEvent(selectedCounty, selectedSubCounty));
        return CustomDropDown<SubcountyList>(
            value: state.subCountyList.data!.first,
            itemsList: state.subCountyList.data!,
            dropdownColor: Colors.white,
            dropDownMenuItems: state.subCountyList.data!
                .map((item) => DropdownMenuItem<SubcountyList>(
                      value: item,
                      child: Text(item.subcounty!),
                    ))
                .toList(),
            onChanged: (SubcountyList value) {
              selectedSubCounty = value.subcounty!;
              context
                  .read<LoginBloc>()
                  .add(GetWardEvent(selectedCounty, value.subcounty!));
            });
      }

      return const SizedBox();
    });
  }

  Widget getWard() {
    return BlocBuilder<LoginBloc, LoginState>(buildWhen: (context, state) {
      if (state is SetWardState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      if (state is SetWardState) {
        return CustomDropDown<WardList>(
            value: state.wardList.data!.first,
            itemsList: state.wardList.data!,
            dropdownColor: Colors.white,
            dropDownMenuItems: state.wardList.data!
                .map((item) => DropdownMenuItem<WardList>(
                      value: item,
                      child: Text(item.ward!),
                    ))
                .toList(),
            onChanged: (WardList value) {
              selectedWard = value.ward!;
            });
      }

      return const SizedBox();
    });
  }

  void validateAndRegistration() {
    if (firstCntrl.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter first name');
      return;
    } else if (lastCntrl.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter last name');
      return;
    } else if (phonenoCntrl.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter phone number');
      return;
    } else if (rephonenoCntrl.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please re enter phone number');
      return;
    } else if (rephonenoCntrl.text != phonenoCntrl.text) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Re entered phone number did not matched');
      return;
    } else if (kvbnoCntrl.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter kvb number');
      return;
    } else if (pinCntrl.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter pin');
      return;
    } else if (repinCntrl.text.isEmpty) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 're enter pin');
      return;
    } else if (repinCntrl.text != pinCntrl.text) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'pin did not matched');
      return;
    } else if (pinCntrl.text.length != 4) {
      sl<CommonFunctions>()
          .showSnackBar(context: context, message: 'Please enter valid pin');
      return;
    } else if (!isTermsCondition.value) {
      sl<CommonFunctions>().showSnackBar(
          context: context, message: 'Please Accept Terms & condition');
      return;
    } else {
      final mobileNumber =
          sl<CommonFunctions>().checkNumberIsValid(phonenoCntrl.text);
      logger.i('the number entered is :$mobileNumber');
      if (mobileNumber.length == 12) {
        context
            .read<LoginBloc>()
            .add(InitiateRegistrationEvent(RegistrationReqModel(
              vetFName: firstCntrl.text,
              vetLName: lastCntrl.text,
              vetSName: "",
              vetPhone: mobileNumber,
              vetPassword: pinCntrl.text,
              county: selectedCounty,
              subCounty: selectedSubCounty,
              ward: selectedWard,
              vetKvb: kvbnoCntrl.text,
              vetLat: 0.0,
              vetLong: 0.0,
            )));
      } else {
        sl<CommonFunctions>().showSnackBar(
          context: context,
          message: 'Please enter valid mobile number',
        );
      }
    }
  }
}
