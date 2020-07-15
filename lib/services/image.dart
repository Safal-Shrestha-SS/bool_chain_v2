import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class ImageCapture extends ChangeNotifier {
  File imageFile;
  bool inProgress = false;
  ImageCapture({this.imageFile});
  Future<void> pickImage(ImageSource source) async {
    imageFile = await ImagePicker.pickImage(source: source);
    inProgress = true;
    notifyListeners();
    await cropImage();
  }

  Future<void> cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
    );

    imageFile = cropped ?? imageFile;
    inProgress = false;
    notifyListeners();
  }

  void clear() {
    imageFile = null;
  }
}
