import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class WebService extends ChangeNotifier{
  final url = 'https://foot-ball-fetect-v1-p33vutcxaa-nw.a.run.app';
  bool loading = true;

  int score = 0;
  double coordinateX = 0;
  double coordinateY = 0;

  void reload(){
    loading = true;

    score = 0;
    coordinateX = 0;
    coordinateY = 0;
  }

  Future<File?> selectDetectVideo() async {
    XFile? video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    String? path = video?.path;
    if (path != null) return File(path);
    return null;
  }

  void sendDetectVideo(File? detectVideo, String targetSquares) async{
    if (detectVideo != null){
      String method = '/find_coordinate?target_squares=$targetSquares';
      final uri = Uri.parse(url + method);
      var request = http.MultipartRequest('POST', uri);
      request.files.add(
          http.MultipartFile(
              'detect_video',
              detectVideo.readAsBytes().asStream(),
              detectVideo.lengthSync(),
              filename: detectVideo.path.split("/").last
          )
      );
      final response = await request.send();
      final responsed = await http.Response.fromStream(response);
      final responseData = json.decode(responsed.body);

      score = responseData["score"];
      coordinateX = responseData["coordinate_x"];
      coordinateY = responseData["coordinate_y"];
      loading = false;
      notifyListeners();
    }
  }
}