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
  late AnimationController iconAnimationController;

  late Animation<double> nameAnimation;
  late Animation<double> titleAnimation;
  late Animation<double> iconAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  void initAnimation() {
    iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    nameAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    titleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    nameAnimation = CurvedAnimation(
      parent: nameAnimationController,
      curve: Curves.bounceInOut,
    );
    iconAnimation = CurvedAnimation(
      parent: iconAnimationController,
      curve: Curves.bounceInOut,
    );
    titleAnimation = CurvedAnimation(
      parent: titleAnimationController,
      curve: Curves.easeIn,
    );
    iconAnimationController.forward().then(
          (_) {
            nameAnimationController.forward();
            titleAnimationController.forward().then(
                (_) {
                  Future.delayed(
                  const Duration(milliseconds: 800),
                ).then(
                  (_) => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  ),
                );
                }
              );
          } 
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
            ScaleTransition(
              scale: iconAnimation,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.26,
                child: AspectRatio(
                  aspectRatio: 1.8/2,
                  child: Image.asset(
                    'assets/icon.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ScaleTransition(
              scale: nameAnimation,
              child: const Text(
                'PetPow',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
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
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
