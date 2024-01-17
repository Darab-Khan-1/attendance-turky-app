import 'dart:developer';
import 'dart:io';

import 'package:attendence_app/Services/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Widgets/image_to_base_64/image_to_64bytes.dart';
import '../../constants/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../../res/utils/utils.dart';
import '../../view/auth/login_screen.dart';
import '../../view/splash_screen/splash_screen.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getProfile();
  }
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  RxString avatar = ''.obs;
  final RxBool isValid = false.obs;
  final _apiService = NetworkApiServices();
  UserPreference userPreference = UserPreference();
  checkValidity() {
    if (emailController.value.text.isNotEmpty &&
        nameController.value.text.isNotEmpty &&
        phoneController.value.text.isNotEmpty &&
        avatar.value.isNotEmpty) {
      isValid.value = true;
      update();
    } else {
      isValid.value = false;
      update();
    }
  }
RxBool isloading = false.obs;
  Future<void> getProfile() async {
    try {
      isloading.value = true;
      dynamic response = await _apiService.getApi(AppUrl.getProfileApi);
      if(response['status_code'] == 200){
        isloading.value = false;
        nameController.value.text = response['data']['name'];
        emailController.value.text = response['data']['email'];
        phoneController.value.text = response['data']['phone'];
        avatar.value = response['data']['avatar'];
      }
      else if(response['status_code'] == 401){
        isloading.value = false;
        userPreference.removeUser().then((value) => Get.offAll(LoginScreen()));
        Utils.snackBar('Error', response['error']);
      }
      else{
        isloading.value = false;
        Utils.snackBar('Error', response['error']);
      }
    } on SocketException catch (e) {
      Get.back();
      Utils.snackBar('error', e.message);
    }
    catch (e) {
      Get.back();
      Utils.snackBar('error', e.toString());
      log(e.toString());
    }
  }
  Future<void> updateProfile(BuildContext context) async {
    loadingStatusDialog(context, title: 'updating');
    Map<String, dynamic> data  = {
      "name": nameController.value.text,
      "email": emailController.value.text,
      "phone": phoneController.value.text,
      if(avatar.value != "" && !avatar.value.startsWith('http'))
        "avatar": await imageConverterTo64(avatar.value)
    };

    try {
      dynamic response = await _apiService.postApi(data, AppUrl.updateProfileApi);
      if(response['status_code'] == 200){
        Get.back();
        Utils.snackBar('Success', response['message']);
        getProfile();
      }
      else if(response['status_code'] == 401){
        Get.back();
        userPreference.removeUser().then((value) => Get.offAll(LoginScreen()));
        Utils.snackBar('Error', response['error']);
      }
      else{
        Get.back();
        Utils.snackBar('Error', "Network Error");
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
          title: 'Error!', message: "Something went Wrong", okLabel: 'ok');
      log(e.toString());
    }
  }
  logoutApi(BuildContext context) async {

    try {
      loadingStatusDialog(context, title: 'Logging Out');
      dynamic response = await _apiService.getApi(AppUrl.logoutApi);
      if(response['status_code'] == 200){
        userPreference.removeUser().then((value) => Get.offAll( SplashScreen()));
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
          title: 'Error!',
          message: e.message,
          okLabel: 'ok');
    }
    catch (e) {
      Get.back();
      errorOverlay(context,
          title: 'Error!', message: "Something went Wrong", okLabel: 'ok');
      log(e.toString());
    }
  }
}