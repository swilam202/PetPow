import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectdetection/utils/types.dart';

import '../pages/image result page.dart';

final ImagePicker imagePicker = ImagePicker();

takeCameraImage(BuildContext context) async {
  XFile? capturedImage =
      await imagePicker.pickImage(source: ImageSource.camera);
  if (capturedImage != null) {
    File image = File(capturedImage.path);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageResultPage(
          file: image,
          type: Types.camera,
        ),
      ),
    );
  }

}
