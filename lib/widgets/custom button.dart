import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:objectdetection/pages/image%20result%20page.dart';

import '../utils/functions.dart';
import '../utils/types.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.type,
  });
  final Types type;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            child: ElevatedButton.icon(
              onPressed: () => takeCameraImage(context),
              label: Text(widget.type == Types.camera
                  ? 'Camera'
                  : widget.type == Types.gallery
                      ? 'Gallery'
                      : 'Video'),
              icon: Icon(
                widget.type == Types.camera
                    ? Icons.camera
                    : widget.type == Types.gallery
                        ? Icons.image
                        : Icons.video_call,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.teal),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
