import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:attendence_app/Services/user_preferences/user_preferences.dart';
import 'package:attendence_app/view/bottom_navigation_bar_screen/bottom_navigation_bar_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
//
import '../../constants/app_url/app_url.dart';
import '../../constants/global.dart';
import '../../data/network/network_api_services.dart';
import '../../model/login_model/login_model.dart';
import '../../res/utils/utils.dart';
import '../../view/auth/login_screen.dart';
import '../../view/splash_screen/splash_screen.dart';


class AuthController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final oldPasswordController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;
  final RxBool isValid = false.obs;
  final _apiService = NetworkApiServices();
  checkPasswordValidity() {
    if (newPasswordController.value.text.isNotEmpty &&
        oldPasswordController.value.text.isNotEmpty) {
      isValid.value = true;
      update();
    } else {
      isValid.value = false;
      update();
    }
  }
UserPreference userPreference = UserPreference();

  Future<dynamic> login(BuildContext context,) async {
    try {
      loadingStatusDialog(context, title: 'Signing in');
      Map<String, dynamic> data = {
        "email": emailController.value.text,
        "password": passwordController.value.text,
      };
      dynamic response = await _apiService.postApi(data, AppUrl.loginApi);

      if(response['status_code'] == 200){
        emailController.value.clear();
        passwordController.value.clear();
        LoginModel userModel = LoginModel.fromJson(response);
        Get.back();
        Global().onlineStatus = userModel.data!.onlinestatus!;
        userPreference.saveUser(userModel);
        Get.offAll(const BottomNavigationBarScreen());
      }
      else if(response['status_code'] == 401){
        Get.back();
        userPreference.removeUser().then((value) => Get.offAll(LoginScreen()));
        Utils.snackBar('Error', response['error']);
      }
      else{
        Get.back();
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Signin Failed',
          message: e.message,
          okLabel: 'ok');
    }
    catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Signin Failed', message: "Something went Wrong", okLabel: 'ok');
      log(e.toString());
    }
  }
  Future<dynamic> changePassword(BuildContext context, {required String oldPassword, required String newPassword}) async {
    try {
      loadingStatusDialog(context, title: 'updating password');
      Map<String, dynamic> data = {
        "old_password": oldPassword,
        "new_password": newPassword,
      };
      dynamic response = await _apiService.updateApi(data, AppUrl.changePasswordApi);
      if(response['status_code'] == 200){
        Get.back();
        Utils.snackBar('Password', response['message']);
        oldPasswordController.value.clear();
        newPasswordController.value.clear();
        // newPasswordController.value.clear();
        // oldPasswordController.value.clear();
        // logout(context);
      }
      else if (response['status_code'] == 401){
        Get.back();
        Utils.snackBar('Error', response['error']);
        userPreference.removeUser().then((value) => Get.offAll( SplashScreen()));
      }
      else{
        Get.back();
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Error!',
          message: e.message,
          okLabel: 'ok');
    }
    catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Error!', message: "Something Went Wrong", okLabel: 'ok');
      log(e.toString());
    }
  }



}