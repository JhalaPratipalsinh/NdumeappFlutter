import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/core/logger.dart';
import 'package:ndumeappflutter/resources/color_constants.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';

import '../../util/constants.dart';
import '../blocs/cowRecordBloc/cow_record_bloc.dart';

class BottomSheetCowRecordsWidget extends StatefulWidget {
  final Function onCowSelected;

  const BottomSheetCowRecordsWidget({required this.onCowSelected, Key? key}) : super(key: key);

  @override
  State<BottomSheetCowRecordsWidget> createState() => _BottomSheetCowRecordsWidgetState();
}

class _BottomSheetCowRecordsWidgetState extends State<BottomSheetCowRecordsWidget> {
  @override
  void initState() {
    super.initState();
    final mobileNumber = context.read<CowRecordBloc>().mobileNumber;
    final currentState = context.read<CowRecordBloc>().state;
    if (currentState is CowRecordsErrorState || currentState is LoadCowBreedsAndGroupState) {
      context
          .read<CowRecordBloc>()
          .add(FetchCowRecordsEvent(mobileNumber: mobileNumber, isFetchNew: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Select Cow',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: ColorConstants.colorPrimaryDark, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<CowRecordBloc, CowRecordState>(
          buildWhen: (_, state) {
            if (state is LoadingCowRecordsState ||
                state is LoadCowRecordsState ||
                state is CowRecordsErrorState) {
              return true;
            }
            return false;
          },
          builder: (_, state) {
            logger.d('the state for loading cow is  : $state ');
            if (state is LoadingCowRecordsState) {
              return const LoadingWidget();
            } else if (state is LoadCowRecordsState) {
              final list = state.cowRecords;
              return Expanded(
                child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    return InkWell(
                      onTap: () {
                        widget.onCowSelected(list[i]);
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            list[i].title == null ? '' : list[i].title!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              );
            } else if (state is CowRecordsErrorState) {
              return Expanded(
                  child: Center(
                      child: Text(
                "Cow data not Added",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              )));
            }
            return const SizedBox.shrink();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, registerCow);
                      },
                      child: const Text('Register New Cow'))),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
              ),
            ],
          ),
        )
      ],
    );
  }
}
