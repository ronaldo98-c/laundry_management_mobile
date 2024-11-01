import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_management_mobile/root.dart';
import 'package:laundry_management_mobile/blocs/app.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:laundry_management_mobile/constants/image_constants.dart';
import 'package:laundry_management_mobile/screens/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: AppImages.splashScreen,
      nextScreen: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state is AuthenticatedState) {
            return const Root();
          } else {
            return const OnboardingScreen();
          }
        },
      ),
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color.fromRGBO(2, 39, 74, 1),
    );
  }
}
