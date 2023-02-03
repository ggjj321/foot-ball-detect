import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../services/goal_field_service.dart';
import '../../services/video_service.dart';
import '../../services/web_service.dart';
import 'result_page.dart';
import 'package:provider/provider.dart';

import '../widgets/goal_painter.dart';
import '../widgets/gradient_render.dart';
import '../widgets/wave_appbar.dart';

class UploadVideoPage extends StatelessWidget {
  const UploadVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    context.read<WebService>().reload();
    return Scaffold(
        appBar: waveAppbar("Upload Video Page"),
        body: SingleChildScrollView(
          child: AnimationLimiter(
              child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 750),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: [
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Choose field',
                  style: TextStyle(
                      fontSize: 20,
                      foreground: Paint()
                        ..shader = getLinearGradient(
                            Colors.purple, Colors.blue, 0, 350)),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Container(
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CustomPaint(
                      foregroundPainter: GoalPainter.uploadMode(),
                      child: Column(
                        children: [
                          for (int y = 0; y < 3; y++)
                            Row(
                              children: [
                                for (int x = 0; x < 4; x++)
                                  SizedBox(
                                      height: screenHeight * 0.0666,
                                      width: screenWidth * 0.225,
                                      child: Center(
                                          child: TextButton(
                                        onPressed: () => context
                                            .read<GoalFieldService>()
                                            .pressField(y, x),
                                        child: Consumer<GoalFieldService>(
                                            builder: (context, galFieldService,
                                                    child) =>
                                                Text(
                                                  galFieldService.getFieldStatusToString(y, x),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      foreground: Paint()
                                                        ..shader =
                                                            getLinearGradient(
                                                                Colors.purple,
                                                                Colors.blue,
                                                                0 + 250.0 * x,
                                                                300 +
                                                                    120.0 * x)),
                                                )),
                                      )))
                              ],
                            )
                        ],
                      )),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Choose Video',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              foreground: Paint()
                                ..shader = getLinearGradient(
                                    Colors.purple, Colors.blue, 0, 150)),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        IconButton(
                          iconSize: 50,
                          icon: const Icon(
                            Icons.file_open,
                          ),
                          tooltip: 'Choose Video',
                          onPressed: () => context
                              .read<VideoService>()
                              .selectDetectVideoFromGallery(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Use Camera',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              foreground: Paint()
                                ..shader = getLinearGradient(
                                    Colors.blue, Colors.purple, 150, 300)),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        IconButton(
                            iconSize: 50,
                            icon: const Icon(Icons.camera),
                            tooltip: 'Use Camera',
                            onPressed: () => context
                                .read<VideoService>()
                                .takeVideoFromCamera())
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                TextButton(
                  onPressed: () {
                    File? detectVideo = context.read<VideoService>().detectVideo;
                    String targetSquares = context.read<GoalFieldService>().selectStatusConvertToTargetSquares();
                    context.read<WebService>().sendDetectVideo(detectVideo, targetSquares);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResultPageView()));
                    context.read<VideoService>().reload();
                  },
                  child: Text(
                    'Submit to See Result',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        foreground: Paint()
                          ..shader = getLinearGradient(
                              Colors.blue, Colors.purple, 0, 300)),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Consumer<VideoService>(
                    builder: (context, videoService, child) => Text(
                          videoService.videoStatus,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              foreground: Paint()
                                ..shader = getLinearGradient(
                                    Colors.blue, Colors.purple, 0, 300)),
                        )),
              ]))),
        ));
  }
}
