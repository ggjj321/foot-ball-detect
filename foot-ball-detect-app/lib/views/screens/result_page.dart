import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../widgets/barchart.dart';
import '../widgets/wave_clip.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: screenHeight * 0.2,
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
                              ..shader = ui.Gradient.linear(
                                const Offset(0, 20),
                                const Offset(150, 20),
                                <Color>[
                                  Colors.purple,
                                  Colors.blue,
                                ],
                              )),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        '5 M',
                        style: TextStyle(
                            fontSize: 40,
                            foreground: Paint()
                              ..shader = ui.Gradient.linear(
                                const Offset(0, 20),
                                const Offset(150, 20),
                                <Color>[
                                  Colors.purple,
                                  Colors.blue,
                                ],
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
                              ..shader = ui.Gradient.linear(
                                const Offset(200, 20),
                                const Offset(450, 20),
                                <Color>[
                                  Colors.purple,
                                  Colors.blue,
                                ],
                              )),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        '20',
                        style: TextStyle(
                            fontSize: 40,
                            foreground: Paint()
                              ..shader = ui.Gradient.linear(
                                const Offset(200, 20),
                                const Offset(400, 20),
                                <Color>[
                                  Colors.purple,
                                  Colors.blue,
                                ],
                              )),
                      ),
                    ],
                  ))
            ],
          ),
          const BarChartSample3(),
        ],
      ),
    );
  }
}
