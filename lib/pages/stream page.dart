import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:objectdetection/main.dart';
import 'package:tflite_v2/tflite_v2.dart';

class StreamPage extends StatefulWidget {
  const StreamPage({super.key});

  @override
  State<StreamPage> createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  late CameraController cameraController;
  CameraImage? cameraImage;
  String output = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
  }

  initCamera()async{
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted){
        return ;
      }
      else{
        setState(() {
          cameraController.startImageStream((image) {
            cameraImage = image;
            runModel();
          });
        });
      }
    });
  }


  runModel()async{
    var data = await Tflite.runModelOnFrame(bytesList: cameraImage!.planes.map((plane) {
      return plane.bytes;
    }).toList()
    ,imageHeight: cameraImage!.height,
    imageWidth: cameraImage!.width,
    imageMean: 127.5,
    imageStd: 127.5,
    rotation: 90,
    threshold: 0.1,
    numResults: 2,
    asynch: true,
    );
    data!.forEach((element) {
      setState(() {
        output = element['label'];
        print('***************************output: $output');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: 250,
                child: cameraController.value.isInitialized? CameraPreview(cameraController,):Container(),),
              Text(output),
            ],
          ),
        ),
    );
  }
}