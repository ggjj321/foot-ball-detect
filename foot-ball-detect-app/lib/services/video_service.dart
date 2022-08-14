import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoService extends ChangeNotifier {
  XFile? video;
  String? detectVideoStatus;
  String successMessage = "U had chosen video";

  String get videoStatus  => detectVideoStatus ?? "No any Detect video";

  void reload() {
    video = null;
    detectVideoStatus = null;
    notifyListeners();
  }

  void selectDetectVideoFromGallery() async {
    video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      detectVideoStatus = successMessage;
      notifyListeners();
    }
  }

  void takeVideoFromCamera() async {
    final ImagePicker picker = ImagePicker();
    video = await picker.pickVideo(source: ImageSource.camera);

    if (video != null) {
      detectVideoStatus = successMessage;
      notifyListeners();
    }
  }

  void postVideoToDetect(){}
}