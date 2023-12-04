import 'dart:io';

import 'package:flutter/material.dart';
import 'package:objectdetection/utils/types.dart';
import 'package:objectdetection/widgets/custom%20button.dart';

import '../widgets/image result button row.dart';

class ImageResultPage extends StatelessWidget {
  const ImageResultPage({
    super.key,
    required this.image,
    required this.type,
    required this.prediction,
    this.percent,
  });
  final File image;
  final Types type;
  final String prediction;
  final double? percent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.teal,
                    width: 8,
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.file(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                prediction,
                style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Colors.teal),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Text(
                percent == null
                    ? ''
                    : 'Confidence: ${percent!.toStringAsFixed(1)}%',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              ImageResultButtonRow(type: type),
            ],
          ),
        ),
      ),
    );
  }
}
