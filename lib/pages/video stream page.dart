import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';

import '../main.dart';
import 'home page.dart';

class VideoStreamPage extends StatefulWidget {
  const VideoStreamPage({super.key});

  @override
  State<VideoStreamPage> createState() => _VideoStreamPageState();
}

class _VideoStreamPageState extends State<VideoStreamPage> {
  late CameraController cameraController;
  CameraImage? cameraImage;
  Map output = {};

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  initCamera() async {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController.initialize().then(
      (value) {
        if (!mounted) {
          return;
        } else {
          setState(
            () {
              cameraController.startImageStream((image) {
                cameraImage = image;
                runModel();
              });
            },
          );
        }
      },
    );
  }

  runModel() async {
    List? data = await Tflite.runModelOnFrame(
      bytesList: cameraImage!.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      imageHeight: cameraImage!.height,
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
        output = element;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cameraController.value.isInitialized
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.brown,
                        width: 8,
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CameraPreview(cameraController),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Center(child: CircularProgressIndicator(color: Colors.brown,),),
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              output['label'] == null ? '' : output['label'].substring(2),
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w900,
                color: Colors.brown,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              output['confidence'] == null
                  ? ''
                  : 'Confidence: ${(output['confidence'] * 100).toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      label: const Text('Go to Home Page',style: TextStyle(color: Colors.white),),
                      icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.brown),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 12),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
