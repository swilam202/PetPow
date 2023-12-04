import 'package:flutter/material.dart';
import 'package:objectdetection/main.dart';

import 'home page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController nameAnimationController;
  late AnimationController titleAnimationController;

  late Animation<double> nameAnimation;
  late Animation<double> titleAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  void initAnimation() {
    nameAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    titleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    nameAnimation = CurvedAnimation(
      parent: nameAnimationController,
      curve: Curves.bounceInOut,
    );
    titleAnimation = CurvedAnimation(
      parent: titleAnimationController,
      curve: Curves.easeIn,
    );
    nameAnimationController.forward().then(
          (_) => titleAnimationController.forward().then(
                (_) => Future.delayed(
                  const Duration(seconds: 1),
                ).then(
                  (_) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HoemPage2(),
                    ),
                  ),
                ),
              ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash.gif',
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 8),
            ScaleTransition(
              scale: nameAnimation,
              child: const Text(
                'PowPuf',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: titleAnimation,
              child: const Text(
                'Pets classification app',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
