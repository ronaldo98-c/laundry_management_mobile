import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/screens/signin_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat-Light'
      ),
      home: AnimatedSplashScreen(
            duration: 3100,
            splash: 'assets/images/pressing.png',
            nextScreen: const SignInScreen(),
            centered: true,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color.fromRGBO(2, 39, 74 , 1)
          ),
    );
  }
}
