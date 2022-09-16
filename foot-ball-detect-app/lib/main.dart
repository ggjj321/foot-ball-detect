import 'package:flutter/material.dart';
import 'package:foot_ball_detect_app/services/goal_field_service.dart';
import 'package:foot_ball_detect_app/services/video_service.dart';
import 'package:foot_ball_detect_app/services/web_service.dart';
import 'package:provider/provider.dart';

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
          ),
          ChangeNotifierProvider(
            create: (context) => WebService(),
          )
        ],
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "football",
        home: UploadVideoPage()
    );
  }
}


