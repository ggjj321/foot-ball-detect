import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/barchart.dart';
import '../widgets/wave_clip.dart';
import '../widgets/goal_painter.dart';
import '../widgets/gradient_render.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 45),
          child: ClipPath(
            clipper: WaveClip(),
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Colors.blue,
                    Colors.purple,
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:const [
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    'Result Page',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(

        child: AnimationLimiter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Where your ball shoot at',
                  style: TextStyle(
                      fontSize: 20,
                      foreground: Paint()
                        ..shader = getLinearGradient(
                            Colors.purple, Colors.blue, 0, 350
                        )),
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
                    foregroundPainter: GoalPainter(0.4, 0.2),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.40,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'target difference',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  foreground: Paint()
                                    ..shader = getLinearGradient(
                                        Colors.purple, Colors.blue, 0, 150
                                    )),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              '5 M',
                              style: TextStyle(
                                  fontSize: 40,
                                  foreground: Paint()
                                    ..shader = getLinearGradient(
                                        Colors.purple, Colors.blue, 0, 150
                                    )),
                            ),
                          ],
                        )),
                    Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.40,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your score',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  foreground: Paint()
                                    ..shader = getLinearGradient(
                                        Colors.purple, Colors.blue, 200, 450
                                    )),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              '20',
                              style: TextStyle(
                                  fontSize: 40,
                                  foreground: Paint()
                                    ..shader = getLinearGradient(
                                        Colors.purple, Colors.blue, 200, 400
                                    )),
                            ),
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                const BarChartSample3(),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
