import 'dart:io';

import 'package:flutter/material.dart';
import 'package:objectdetection/utils/types.dart';
import 'package:objectdetection/widgets/custom%20button.dart';

import '../widgets/image result button row.dart';

class ImageResultPage extends StatelessWidget {
  const ImageResultPage({
    super.key,
    required this.file,
    required this.type,
  });
  final File file;
  final Types type;
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
                    color: Colors.green,
                    width: 8,
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.file(
                  file,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text('Cat',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.teal),),
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
