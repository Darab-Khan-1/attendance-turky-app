import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> imageFromGellery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxHeight: 1200,
        maxWidth: 1200,
      );
      print("selectedImage: $image");
      return image;
    }
    catch (e) {
      return null;
    }
  }

  Future<XFile?> imageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
        maxHeight: 1200,
        maxWidth: 1200,
      );
      return image;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<XFile>?> multiImageFromGellery() async {
    try {
      final List<XFile> image = await _picker.pickMultiImage(
        imageQuality: 60,
        maxHeight: 1200,
        maxWidth: 1200,
      );

      return image;
    } catch (e) {
      return null;
    }
  }
}
