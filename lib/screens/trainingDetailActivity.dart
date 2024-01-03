import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ndumeappflutter/screens/widgets/loading_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../data/models/trainingdetail_model.dart';
import '../resources/color_constants.dart';
import '../util/constants.dart';
import 'blocs/trainingBloc/trainingk_bloc.dart';

class TrainingDetailActivity extends StatefulWidget {
  final String trainingId;

  const TrainingDetailActivity({required this.trainingId, Key? key})
      : super(key: key);

  @override
  State<TrainingDetailActivity> createState() => _TrainingDetailActivityState();
}

class _TrainingDetailActivityState extends State<TrainingDetailActivity> {
  late String catId = "0";
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late final WebViewController _webcController;

 /* final List<String> imageUrls = [
    'https://partner.digicow.co.ke/upload/images/trainings/training_51771.jpeg',
    'https://partner.digicow.co.ke/upload/images/trainings/training_51771.jpeg',
    'https://partner.digicow.co.ke/upload/images/trainings/training_51771.jpeg',
  ];*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<TrainingkBloc>().add(GetTrainingDetail(widget.trainingId));

    _webcController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print(progress);
          },
          onPageStarted: (String url) {
            print("Page Started");
          },
          onPageFinished: (String url) {
            print("Page Finished");
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() {
          double playTimeInSeconds=_videoPlayerController.value.position.inSeconds.toDouble();
          print('Video play time: $playTimeInSeconds seconds');
          context.read<TrainingkBloc>().add(UpdateTrainingTime(playTimeInSeconds.toString(),widget.trainingId));
          context.read<TrainingkBloc>().add(GetTrainingTopicList(catId: catId));
          return true;
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorConstants.colorPrimary,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Training",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: BlocBuilder<TrainingkBloc, TrainingkState>(
          builder: (context, state) {
            if (state is TrainingLoadingState) {
              return const LoadingWidget();
            } else if (state is TrainingDetailState) {
              if (state.response.success!) {
                catId = state.response.data!.detail!.categoryId!.toString();

                _webcController.loadHtmlString(
                    " <html><head> <meta name='viewport' content='width=device-width, initial-scale=1.0'></head><body>${state.response.data!.detail!.detail!}</body></html>");

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    state.response.data!.gallery!.isNotEmpty
                        ? imageSlider(state.response.data!.gallery!)
                        : SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                      child: Text(
                        state.response.data!.detail!.title!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: WebViewWidget(
                          controller: _webcController,
                        ),
                        /*child: Html(
                          data: state.response.data!.detail!.detail,
                        ),*/
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "No Training Detail",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                );
              }
            } else {
              return const Center(
                child: Text(
                  "No Training topic found",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  Widget imageSlider(List<Gallery> gallery) {
    if (gallery.first.type == "image") {
      return Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider(
              options: CarouselOptions(
                height: 230,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 1.0, // Occupy the full width
              ),
              items: gallery.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(vertical: 2.0),
                      child: Image.network(
                        trainingImageUrl + url.photo!,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }).toList()),
        ],
      );
    } else {
      print(trainingImageUrl + gallery.first.photo!);
      _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(trainingImageUrl + gallery.first.photo!));
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        allowedScreenSleep: false,
        aspectRatio: 16 / 9,
        showControls: true,
        placeholder: Container(
          color: Colors.black, // Placeholder background color
        ),
        materialProgressColors: ChewieProgressColors(
          playedColor: ColorConstants.colorPrimary,
          handleColor: ColorConstants.colorPrimary,
          backgroundColor: Colors.white,
          bufferedColor: Colors.white,
        ),
        // Additional chewie options can be configured here
      );

      return SizedBox(
          height: 250,
          width: double.infinity,
          child: Chewie(controller: _chewieController));
    }
  }
}
