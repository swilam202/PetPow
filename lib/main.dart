import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectdetection/pages/splash%20page.dart';
import 'package:objectdetection/utils/functions.dart';
import 'package:tflite_v2/tflite_v2.dart';

import 'pages/home page.dart';
import 'pages/video stream page.dart';

List<CameraDescription>? cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await loadModel();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,

        appBarTheme: const AppBarTheme(backgroundColor: Colors.teal),
      ),
      home: const SplashPage(),
    );
  }
}



