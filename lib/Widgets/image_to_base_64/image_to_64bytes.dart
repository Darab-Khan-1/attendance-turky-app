import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

dynamic imageConverterTo64(String imagePath) async{
  if(imagePath.isEmpty){
    return "";
  }
   else if (imagePath != null && File(imagePath).existsSync()) {
     print('Processing Avatar Image at Path: $imagePath');

     final imageFile = File(imagePath);
     final imageExtension = imagePath.split(".").last;
     final imageBytes = await imageFile.readAsBytes();
     final imageBase64 = 'data:image/$imageExtension;base64,${base64Encode(imageBytes)}';
     log("imageBase64 converted $imageBase64 ");
     return imageBase64;
  }

}

dynamic multipleimagesTo64( var selectedImages) async {

  String multiplePicBase64String = ''; // Initialize the base64 string
  int maxImagesToConvert = 10; // Maximum number of images to convert

  for (int i = 0; i < selectedImages.length && i < maxImagesToConvert; i++) {
    final File imageFile = selectedImages[i];
    final extension = imageFile.path.split(".").last;
    final imageBytes = await imageFile.readAsBytes();
    final imageBase64 = 'data:image/$extension;base64,${base64Encode(imageBytes)}';

    if (multiplePicBase64String.isNotEmpty) {
      // If the string is not empty, add a ';' before adding the new image
      multiplePicBase64String += ';';
    }
    multiplePicBase64String += imageBase64;
  }
  return multiplePicBase64String ;
// Now, multiplePicBase64String contains base64 strings of the first 10 images

}
