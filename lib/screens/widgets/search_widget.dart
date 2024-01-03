import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/custom_button.dart';
import 'package:ndumeappflutter/screens/widgets/text_field_widget.dart';

import '../../core/logger.dart';
import '../../injection_container.dart';
import '../../resources/color_constants.dart';
import '../../util/common_functions.dart';
import '../blocs/homeBloc/home_bloc.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldWidget(
          controller: numberController,
          hint: 'Search Farmer Mobile No.',
          textInputType: TextInputType.number,
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          buttonText: 'Search'.toUpperCase(),
          onPressButton: () => (context.read<HomeBloc>().state is HomeLoadingState ||
                  context.read<HomeBloc>().state is AddFarmerLoadingState)
              ? () {}
              : validateNoAndSearchFarmer(),
          padding: 0,
          /*buttonHeight: 45,*/

          buttonColor: ColorConstants.green,
          textColor: Colors.white,
        )
      ],
    );
  }

  void validateNoAndSearchFarmer() {
    if (numberController.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(context: context, message: 'Please enter mobile number');
      return;
    } else {
      final mobileNumber = sl<CommonFunctions>().checkNumberIsValid(numberController.text);
      logger.i('the number entered is :$mobileNumber');
      if (mobileNumber.length == 12) {
        context.read<HomeBloc>().add(SearchFarmerEvent(mobileNo: mobileNumber));
      } else {
        sl<CommonFunctions>().showSnackBar(
          context: context,
          message: 'Please enter valid mobile number',
        );
      }
    }
  }
}
