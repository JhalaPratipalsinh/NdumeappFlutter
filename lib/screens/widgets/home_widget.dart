import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/injection_container.dart';
import 'package:upgrader/upgrader.dart';

import '../../data/models/CountyListModel.dart';
import '../../data/models/SubcountyListModel.dart';
import '../../data/models/WardListModel.dart';
import '../../repository/master_repository.dart';
import '../../resources/color_constants.dart';
import '../../resources/image_resources.dart';
import '../../util/common_functions.dart';
import '../../util/constants.dart';
import '../blocs/cowRecordBloc/cow_record_bloc.dart';
import '../blocs/homeBloc/home_bloc.dart';
import '../blocs/loginBloc/login_bloc.dart';
import 'add_farmer_widget.dart';
import 'custom_button.dart';
import 'custom_drop_down.dart';
import 'farmer_type_widget.dart';
import 'loading_widget.dart';
import 'search_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  CountyList? selectedCounty;
  SubcountyList? selectedSubCounty;
  String selectedFarmerType = 'Male';
  WardList? selectedWard;
  List<CountyList> countyList = [];
  bool isTermsCondition = false;
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (_, state) {
        if (state is HomeErrorState) {
          if (state.statusCode != 404) {
            sl<CommonFunctions>().showSnackBar(
              context: context,
              message: state.error,
              bgColor: ColorConstants.errorBgColor,
            );
          }
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              UpgradeAlert(
                child: const SizedBox(),
              ),
              const SearchWidget(),
              const Divider(),
              BlocBuilder<HomeBloc, HomeState>(buildWhen: (_, state) {
                if (state is HandleAddFarmerState ||
                    state is AddFarmerLoadingState) {
                  return false;
                }
                return true;
              }, builder: (_, state) {
                if (state is HomeErrorState) {
                  isUpdate = false;
                  if (state.statusCode == 404) {
                    return const AddFarmerWidget();
                  }
                  return const SizedBox.shrink();
                } else if (state is HandleSearchState) {
                  return InkWell(
                    onTap: () {
                      if (state.response.data!.county == "-" ||
                          state.response.data!.gender == "-" ||
                          state.response.data!.gender == null && !isUpdate) {
                        showEditDilog(
                            context: context,
                            farmerId:
                                state.response.data!.farmerVetId!.toString(),
                            farmermobileno: state.response.data!.mobileNumber!);
                      } else {
                        final mobileNo = state.response.data!.mobileNumber!;
                        final farmerName =
                            state.response.data!.farmerName != null
                                ? state.response.data!.farmerName!
                                : "Noname";
                        final farmerVetID =
                            '${state.response.data!.farmerVetId!}';

                        context.read<CowRecordBloc>().getCowBreedsAndGroup();
                        context.read<CowRecordBloc>().add(FetchCowRecordsEvent(
                            mobileNumber: state.response.data!.mobileNumber!));
                        context.read<CowRecordBloc>().setFarmerVetDetails(
                            mobileNo, farmerName, farmerVetID);
                        Navigator.of(context)
                            .pushNamed(breedingRecordManagement);
                      }
                    },
                    child: Card(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(ImageResources.circularAvatar),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Name : ${state.response.data!.farmerName}'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'Mobile : ${state.response.data!.mobileNumber}'),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Image.asset(
                            ImageResources.rightArrowIcon,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is HomeLoadingState) {
                  return const LoadingWidget();
                }
                return const SizedBox.shrink();
              }),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> showEditDilog(
      {required BuildContext context,
      required String farmerId,
      required String farmermobileno}) async {
    final county = sl<MasterRepository>().getCachedCountyList();
    if (county != null) {
      countyList = county.data!;
      selectedCounty = countyList.first;
      context.read<LoginBloc>().add(GetSubCountyEvent(selectedCounty!.county!));
    }
    final result = await showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: SizedBox(
            height: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 45,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    color: ColorConstants.colorPrimary,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      const Expanded(
                        child: Text(
                          "Update Farmer Detail",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 35,
                        ),
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0, right: 20, left: 20),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 25,
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
                                /*setState(() {});*/
                                await Future.delayed(
                                    const Duration(milliseconds: 800));
                                if (mounted) {
                                  context.read<LoginBloc>().add(
                                      GetSubCountyEvent(
                                          selectedCounty!.county!));
                                }
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (context, state) {
                          if (state is SetSubCountyState ||
                              state is SubCountyLoadingState) {
                            return true;
                          }
                          return false;
                        }, builder: (_, state) {
                          if (state is SubCountyLoadingState) {
                            return const LoadingWidget();
                          }
                          if (state is SetSubCountyState) {
                            if (selectedSubCounty == null ||
                                !state.subCountyList.data!
                                    .contains(selectedSubCounty!)) {
                              selectedSubCounty =
                                  state.subCountyList.data!.first;
                            }
                            final list = state.subCountyList.data!;
                            context.read<LoginBloc>().add(GetWardEvent(
                                selectedCounty!.county!,
                                selectedSubCounty!.subcounty!));
                            return CustomDropDown<SubcountyList>(
                                value: selectedSubCounty!,
                                itemsList: list,
                                dropdownColor: Colors.white,
                                margin: 0,
                                dropDownMenuItems: list
                                    .map((item) =>
                                        DropdownMenuItem<SubcountyList>(
                                          value: item,
                                          child: Text(item.subcounty!),
                                        ))
                                    .toList(),
                                onChanged: (SubcountyList value) async {
                                  selectedSubCounty = value;
                                  if (selectedSubCounty!.county!.isNotEmpty) {
                                    setState(() {});
                                    await Future.delayed(
                                        const Duration(milliseconds: 800));
                                    if (mounted) {
                                      context.read<LoginBloc>().add(
                                          GetWardEvent(selectedCounty!.county!,
                                              value.subcounty!));
                                    }
                                  }
                                });
                          }
                          return const SizedBox();
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (context, state) {
                          if (state is SetWardState ||
                              state is WardLoadingState) {
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
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is AddFarmerLoadingState) {
                              return const LoadingWidget();
                            } else if (state is UpdateFarmerState) {
                              if (state.response.success!) {
                                Navigator.pop(context);
                                isUpdate = true;
                              }
                              sl<CommonFunctions>().showSnackBar(
                                context: context,
                                message: state.response.message!,
                                bgColor: Colors.green,
                              );
                              //context.read<HomeBloc>().add(SearchFarmerEvent(mobileNo: farmermobileno));

                              return ButtonWidget(
                                buttonText: 'Update Detail'.toUpperCase(),
                                onPressButton: () => {
                                  if (selectedCounty!.county == "Select County")
                                    {
                                      sl<CommonFunctions>().showSnackBar(
                                        context: context,
                                        message: "Select County",
                                        bgColor: Colors.red,
                                      )
                                    }
                                  else if (selectedSubCounty!.subcounty ==
                                      "Select Subcounty")
                                    {
                                      sl<CommonFunctions>().showSnackBar(
                                        context: context,
                                        message: "Select Subounty",
                                        bgColor: Colors.red,
                                      )
                                    }
                                  else if (selectedSubCounty!.subcounty ==
                                      "Select Ward")
                                    {
                                      sl<CommonFunctions>().showSnackBar(
                                        context: context,
                                        message: "Select ward",
                                        bgColor: Colors.red,
                                      )
                                    }
                                  else
                                    {
                                      context.read<HomeBloc>().add(
                                          UpdateFarmerEvent(
                                              farmerVetId: farmerId,
                                              gender: selectedFarmerType,
                                              county: selectedCounty!.county!,
                                              subCounty:
                                                  selectedSubCounty!.subcounty!,
                                              ward: selectedWard!.ward!))
                                    }
                                },
                                padding: 0,
                                buttonHeight: 45,
                                buttonColor: ColorConstants.green,
                                textColor: Colors.white,
                              );
                            } else {
                              return ButtonWidget(
                                buttonText: 'Update Detail'.toUpperCase(),
                                onPressButton: () => {
                                  if (selectedCounty!.county == "Select county")
                                    {
                                      sl<CommonFunctions>().showSnackBar(
                                        context: context,
                                        message: "Select County",
                                        bgColor: Colors.red,
                                      )
                                    }
                                  else if (selectedSubCounty!.subcounty ==
                                      "Select subcounty")
                                    {
                                      sl<CommonFunctions>().showSnackBar(
                                        context: context,
                                        message: "Select Subounty",
                                        bgColor: Colors.red,
                                      )
                                    }
                                  else if (selectedSubCounty!.subcounty ==
                                      "Select ward")
                                    {
                                      sl<CommonFunctions>().showSnackBar(
                                        context: context,
                                        message: "Select ward",
                                        bgColor: Colors.red,
                                      )
                                    }
                                  else
                                    {
                                      context.read<HomeBloc>().add(
                                          UpdateFarmerEvent(
                                              farmerVetId: farmerId,
                                              gender: selectedFarmerType,
                                              county: selectedCounty!.county!,
                                              subCounty:
                                                  selectedSubCounty!.subcounty!,
                                              ward: selectedWard!.ward!))
                                    }
                                },
                                padding: 0,
                                buttonHeight: 45,
                                buttonColor: ColorConstants.green,
                                textColor: Colors.white,
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return false;
  }
}
