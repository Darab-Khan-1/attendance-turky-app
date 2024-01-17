import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Services/image_picker_services.dart';
import '../../constants/colors.dart';
import '../form_fields/k_text.dart';

class CustomImagePicker extends StatelessWidget {
  final ValueChanged<File?> onImagePicked;
  const CustomImagePicker({super.key, required this.onImagePicked});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        KText(
          text: 'Select Image From',
          color: kBlackColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () async {
                var pickedImage = await ImagePickerService().imageFromGellery();
                if (pickedImage != null) {
                  print("path ${pickedImage.name}");
                  onImagePicked(File(pickedImage.path));
                }
              },
              child: SvgPicture.asset(
                "assets/svg_images/gallery.svg",
                width: 80,
              ),
            ),
            InkWell(
              onTap: () async {
                final pickedImage =
                    await ImagePickerService().imageFromCamera();
                if (pickedImage != null) {
                  onImagePicked(File(pickedImage.path));
                }
              },
              child: SvgPicture.asset(
                "assets/svg_images/camera.svg",
                width: 80,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
