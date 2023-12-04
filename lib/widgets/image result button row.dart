import 'package:flutter/material.dart';
import 'package:objectdetection/utils/functions.dart';
import 'package:objectdetection/utils/types.dart';

import '../pages/home page.dart';

class ImageResultButtonRow extends StatelessWidget {
  const ImageResultButtonRow({
    super.key,
    required this.type,
  });
  final Types type;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HoemPage2(),
                ),
              );
            },
            label: const Text('Go to Home Page'),
            icon: const Icon(Icons.arrow_back_ios_new),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 16),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => takeCameraImage(context),
            label: const Text('Take new Image'),
            icon: const Icon(Icons.add),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 16),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
