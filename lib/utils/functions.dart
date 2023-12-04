import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectdetection/utils/types.dart';
import 'package:tflite_v2/tflite_v2.dart';

import '../pages/image result page.dart';

final ImagePicker imagePicker = ImagePicker();

  Future<void> loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model/model_unquant.tflite',
        labels: 'assets/model/labels.txt',
        isAsset: true,
        );

        print('Loaded ++++++++++++++++++++++++++++++++++++');
  }
//[{confidence: 1.0, index: 1, label: 1 Cat}]

Future<void> takeCameraImage(BuildContext context) async {
  XFile? capturedImage =
      await imagePicker.pickImage(source: ImageSource.camera);
  if (capturedImage != null) {
    File image = File(capturedImage.path);
    List? predictionList = await Tflite.runModelOnImage(path: image.path,imageMean: 127.5,imageStd: 127.5,threshold: 0.6,numResults: 2,);
    late String prediction;
     double? percent;
    
    if(predictionList == null){
      prediction = 'No Pets found in the image!';
    }
    else{
     prediction = predictionList[0]['label'].toString().substring(2);
     percent = predictionList[0]['confidence'];
    }
   
    
    print(predictionList);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageResultPage(
          image: image,
          type: Types.camera,
          percent: percent,
          prediction: prediction,
        ),
      ),
    );
  }

}

Future<void> takeGalleryImage(BuildContext context) async {
  XFile? capturedImage =
      await imagePicker.pickImage(source: ImageSource.gallery);
  if (capturedImage != null) {
    File image = File(capturedImage.path);
   /* Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageResultPage(
          image: image,
          type: Types.gallery,
        ),
      ),
    );*/
  }

}
