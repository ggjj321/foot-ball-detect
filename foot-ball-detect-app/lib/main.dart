import 'package:flutter/material.dart';

import 'views/screens/result_page.dart';
import 'views/screens/upload_video_page.dart';

void main() {
  runApp(const MyApp());
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
