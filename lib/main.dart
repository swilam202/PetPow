import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectdetection/pages/splash%20page.dart';
import 'package:objectdetection/utils/functions.dart';
import 'package:tflite_v2/tflite_v2.dart';

import 'pages/home page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
        scaffoldBackgroundColor: Color(0xFFE3E3E3),
      ),
      home: const HoemPage2(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List predictions = [];
  File? image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model/model_unquant.tflite',
        labels: 'assets/model/labels.txt',
        isAsset: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Animal classification app'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          ElevatedButton(
            onPressed: () async {
              var d = await Tflite.runModelOnImage(
                path: image!.path,
                imageMean: 127.5,
                imageStd: 127.5,
                numResults: 2,
                threshold: 0.6,
              );
              print(d);
            },
            child: Text('detect'),
          ),
          ElevatedButton(
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();
              XFile? file =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              setState(() {
                image = File(file!.path);
              });
            },
            child: Text('load'),
          ),
        ],
      ),
    );
  }
}


