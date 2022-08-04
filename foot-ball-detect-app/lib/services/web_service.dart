import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class WebService {
  final url = 'http://10.0.2.2:5000/';

  Future<File?> selectDetectVideo() async {
    XFile? video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    String? path = video?.path;
    if (path != null) return File(path);
    return null;
  }

  void sendDetectVideo() async{
    String method = 'find_coordinate';
    final uri = Uri.parse(url + method);
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
    }
  }
}