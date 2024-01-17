import 'dart:async';
import 'package:attendence_app/Services/user_preferences/user_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../view/auth/login_screen.dart';
import '../view/bottom_navigation_bar_screen/bottom_navigation_bar_screen.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  void isLogin() {
    userPreference.getUser().then((value) {
      // SharedPreferences.getInstance().then((prefs) {
        // if (prefs.containsKey('understood')) {
          if (value.isLogin == false || value.isLogin == null) {
                  Get.offAll(LoginScreen());
                } else {
                  Get.offAll(const BottomNavigationBarScreen());
                }
        // } else {
        //   Timer(const Duration(seconds: 3),
        //           () => Get.to(AskForPermission()));
        // }
    });
  }
}