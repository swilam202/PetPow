import 'package:flutter/material.dart';


class HoemPage2 extends StatefulWidget {
  const HoemPage2({super.key});

  @override
  State<HoemPage2> createState() => _HoemPage2State();
}

class _HoemPage2State extends State<HoemPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: AspectRatio(
              aspectRatio: 2,
              child: Image.asset('assets/image.png',fit: BoxFit.fill,),),),
        ],
      ),
    );
  }
}