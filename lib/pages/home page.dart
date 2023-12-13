import 'package:flutter/material.dart';

import '../utils/types.dart';
import '../widgets/custom button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PetAI',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Image.asset(
              'assets/icon.png',
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          const CustomButton(type: Types.camera),
          const CustomButton(type: Types.gallery),
          const CustomButton(type: Types.video),
        ],
      ),
    );
  }
}
