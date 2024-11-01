import 'package:flutter/material.dart';
import 'package:laundry_management_mobile/screens/home.dart';
import 'package:laundry_management_mobile/screens/authentication/signin_screen.dart';
import 'package:laundry_management_mobile/screens/authentication/signup_screen.dart';


class RouteUtil {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case SignInScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SignInScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }
}