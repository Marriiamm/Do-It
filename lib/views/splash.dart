import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'home.dart';


class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
          backgroundColor: const Color(0xffFFEBBE),
          onInit: () {
            debugPrint("On Init");
          },
          onEnd: () {
            debugPrint("On End");
          },
          childWidget:  Image.asset("assets/images/splash.png"),
          onAnimationEnd: () => debugPrint("On Fade In End"),
          nextScreen: const MyHomePage(),
        );
  }
}