import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSendVideo = false;
  late Widget resultImage;

  Future<File?> selectDetectVideo() async {
    XFile? video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    String? path = video?.path;
    if (path != null) return File(path);
    return null;
  }

  void sendDetectVideo() async{
    final uri = Uri.parse('http://10.0.2.2:5000/find_coordinte');
    var request = http.MultipartRequest('POST', uri);
    File? detectVideo = await selectDetectVideo();
    if (detectVideo != null){
      request.files.add(
          http.MultipartFile(
              'detect_video',
              detectVideo.readAsBytes().asStream(),
              detectVideo.lengthSync(),
              filename: detectVideo.path.split("/").last
          )
      );
      var res = await request.send();
      this.isSendVideo = true;
      resultImage = setResultImage();
      setState(() {});
    }
  }

  Widget setResultImage(){
    if (this.isSendVideo){
      return Image.network('http://10.0.2.2:5000/result_img');
    }else {
      return const Text("please choose video");
    }
  }

  @override
  Widget build(BuildContext context) {
    resultImage = setResultImage();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network('http://10.0.2.2:5000/result_img')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendDetectVideo,
        tooltip: 'upload video',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
