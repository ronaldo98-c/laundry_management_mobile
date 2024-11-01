import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_management_mobile/blocs/app.dart';
import 'package:laundry_management_mobile/screens/splash_screen.dart';
import 'package:laundry_management_mobile/controllers/login_controller.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final LoginController loginController = LoginController();

  MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(loginController: loginController)..add(AppStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Montserrat-Light'),
        home: const SplashScreen(),
      ),
    );
  }
}