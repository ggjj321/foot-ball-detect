import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../services/goal_field_service.dart';
import '../widgets/barchart.dart';
import '../widgets/wave_appbar.dart';
import '../widgets/goal_painter.dart';
import '../widgets/gradient_render.dart';

class ResultPageView extends StatelessWidget {
  const ResultPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: waveAppbar("Result Page"),
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
                Text(
                  textAlign: TextAlign.center,
                  'Where your ball shoot at',
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..shader =
                          getLinearGradient(Colors.purple, Colors.blue, 0, 350),
                  ),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: CustomPaint(
                    foregroundPainter: GoalPainter.resultMode(0.28, 1),
                    child: Column(
                      children: [
                        for (int y = 0; y < 3; y++)
                          Row(
                            children: [
                              for (int x = 0; x < 4; x++)
                                SizedBox(
                                  height: screenHeight * 0.0666,
                                  width: screenWidth * 0.225,
                                  child: Consumer<GoalFieldService>(
                                    builder:
                                        (context, goalFieldService, child) =>
                                            Container(
                                      color: goalFieldService
                                          .getFieldStatusToColor(y, x),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
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
                                    Colors.purple, Colors.blue, 0, 150),
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            '5 M',
                            style: TextStyle(
                              fontSize: 40,
                              foreground: Paint()
                                ..shader = getLinearGradient(
                                    Colors.purple, Colors.blue, 0, 150),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
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
                                    Colors.purple, Colors.blue, 200, 450),
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            '20',
                            style: TextStyle(
                                fontSize: 40,
                                foreground: Paint()
                                  ..shader = getLinearGradient(
                                      Colors.purple, Colors.blue, 200, 400)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                const BarChartSample3(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
