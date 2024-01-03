import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/blocs/trainingBloc/trainingk_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';

import '../resources/color_constants.dart';
import '../util/constants.dart';
import 'widgets/training_categorylist_widget_.dart';

class TrainingCategoryList extends StatefulWidget {
  const TrainingCategoryList({Key? key}) : super(key: key);

  @override
  State<TrainingCategoryList> createState() => _TrainingCategoryListState();
}

class _TrainingCategoryListState extends State<TrainingCategoryList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          color: ColorConstants.colorAccent,
          child: BlocBuilder<TrainingkBloc, TrainingkState>(
            builder: (context, state) {
              if (state is TrainingLoadingState) {
                return const LoadingWidget();
              } else if (state is TrainingCategoryListState) {
                if (state.response.categories!.isNotEmpty) {
                  return ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (ctx, index) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, trainingTopicList,
                              arguments: {
                                "catId": state.response.categories![index].id
                                    .toString(),
                                "catName": state
                                    .response.categories![index].categoryName
                              });
                        },
                        child: TrainingCategoryWidget(
                          catName:
                              state.response.categories![index].categoryName!,
                        )),
                    itemCount: state.response.categories!.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 0.5,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.white,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "No category found",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                }
              } else {
                return const Center(
                  child: Text(
                    "No category found",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
