import 'package:attendence_app/constants/colors.dart';
import 'package:attendence_app/constants/theme.dart';
import 'package:attendence_app/view/auth/login_screen.dart';
import 'package:attendence_app/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: AppTheme.lightTheme(context),
      home:  SplashScreen(),
    );
  }
}

