import 'package:flutter/material.dart';
import 'package:foot_ball_detect_app/services/goal_field_service.dart';
import 'package:foot_ball_detect_app/services/video_service.dart';
import 'package:provider/provider.dart';

import 'views/screens/result_page.dart';
import 'views/screens/upload_video_page.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => VideoService(),
          ),
          ChangeNotifierProvider(
            create: (context) => GoalFieldService(),
          )
        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Movies",
        home: UploadVideoPage()
    );
  }
}


