import 'package:attendence_app/Services/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
final SplashServices splashScreen = SplashServices();
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      splashScreen.isLogin();
    });
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/attendenceApp_logo.png"),
      ),
    );
  }
}
