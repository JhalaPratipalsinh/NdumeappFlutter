import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:ndumeappflutter/util/constants.dart';

import '../resources/color_constants.dart';
import 'blocs/trainingBloc/trainingk_bloc.dart';
import 'widgets/training_categorylist_widget_.dart';

class TrainingTopicListActivity extends StatefulWidget {
  final String cateId;
  final String cateName;

  const TrainingTopicListActivity(
      {required this.cateId, required this.cateName, Key? key})
      : super(key: key);

  @override
  State<TrainingTopicListActivity> createState() =>
      _TrainingTopicActivityState();
}

class _TrainingTopicActivityState extends State<TrainingTopicListActivity> {

  @override
  void initState() {
    super.initState();
    context
        .read<TrainingkBloc>()
        .add(GetTrainingTopicList(catId: widget.cateId));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() {
          context.read<TrainingkBloc>().add(const GetTrainingCategoryList());
          return true;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            widget.cateName!,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Stack(
          children: [
            BlocBuilder<TrainingkBloc, TrainingkState>(
              buildWhen: (previous, current) => previous is TrainingLoadingState,
              builder: (context, state) {
                if(state is TrainingLoadingState){
                  return const LoadingWidget();
                }else if(state is TrainingTopicListState) {
                  if(state.response.topic!.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.only(top: 10),
                      color: ColorConstants.colorAccent,
                      child: ListView.separated(
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (ctx, index) =>
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, trainingDetail,
                                      arguments: state.response.topic![index].id.toString());
                                },
                                child: TrainingCategoryWidget(
                                  catName: state.response.topic![index].title!,
                                )),
                        itemCount: state.response.topic!.length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 0.5,
                            indent: 20,
                            endIndent: 20,
                            color: Colors.white,
                          );
                        },
                      ),
                    );
                  }else{
                    return const Center(
                      child: Text(
                        "No Training topic found",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    );
                  }
                }else{
                  return const Center(
                    child: Text(
                      "No Training topic found",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
