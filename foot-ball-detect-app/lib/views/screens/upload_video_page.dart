import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'result_page.dart';

import '../widgets/goal_painter.dart';
import '../widgets/gradient_render.dart';
import '../widgets/wave_appbar.dart';

class UploadVideoPage extends StatelessWidget {
  const UploadVideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
                  height: screenHeight * 0.1,
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
                  height: screenHeight * 0.03,
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
                        offset: Offset(0, 3), // changes position of shadow
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
                                        onPressed: () {},
                                        child: Text(
                                          'choose',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              foreground: Paint()
                                                ..shader = getLinearGradient(
                                                    Colors.purple,
                                                    Colors.blue,
                                                    0 + 250.0 * x,
                                                    300 + 120.0 * x)),
                                        ),
                                      )))
                              ],
                            )
                        ],
                      )),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Choose Video',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            foreground: Paint()
                              ..shader = getLinearGradient(
                                  Colors.purple, Colors.blue, 0, 150)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Use Camera',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            foreground: Paint()
                              ..shader = getLinearGradient(
                                  Colors.blue, Colors.purple, 150, 300)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.08,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResultPage()));
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
                )
              ]))),
        ));
  }
}
