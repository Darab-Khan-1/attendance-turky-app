import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:attendence_app/Services/location_services/location_services.dart';
import 'package:attendence_app/constants/app_url/app_url.dart';
import 'package:attendence_app/constants/global.dart';
import 'package:attendence_app/data/network/network_api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/user_preferences/user_preferences.dart';
import '../../data/response/status.dart';
import '../../model/attendance_model/attendance_model.dart';
import '../../model/driver_status/driver_status_model.dart';
import '../../res/utils/utils.dart';
import '../../view/auth/login_screen.dart';

class DriverStatusController extends GetxController{
  UserPreference userPreference = UserPreference();
  final _apiService = NetworkApiServices();
  Timer? _timer;
final driverStatusModel = DriverStatus().obs;
  setDriverStatus(bool value) async{
   var sp = await SharedPreferences.getInstance();
    sp.setBool('driverStatus', value);
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStatus();
    // driverStatus();
  }
  void driverStatus() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      UserPreference().getUser().then((value) async {
        if(value.data!.uniqueId != null && value.data!.bearerToken != null){
          try {
            var response = await _apiService.getApi(AppUrl.driverStatusApi);
            if(response['status_code'] == 200){
              if(response['data']['online'] == 1){
                _timer!.cancel();
                Global().onlineStatus = true;
                setDriverStatus(true);
                await Location.instance.enableBackgroundMode(enable: true);
                var locationData = await LocationService.getLocation();
                LocationService.updateLocation(locationData, value.data!.uniqueId!);
              }
              else{
                Global().onlineStatus = false;
                print('Driver Status  ${response['data']['online']}');
                 await Location.instance.enableBackgroundMode(enable: false);
              }
            }
            else if(response['status_code'] == 401 || response['message'] == "Unauthenticated."){
              _timer!.cancel();
              // DriverStatusController().dispose();
              userPreference.removeUser().then((value) => Get.offAll(LoginScreen()));
            }
            else{
              print('error on driver verification status api: ${response['error']}');
            }
          } catch (e) {
            // Handle error when the HTTP request fails
            print('error on driver verification status api: $e');
          }
        }else{
          _timer!.cancel();
        }
      });
    });
  }
final RxBool isloading = false.obs;
  Future<void> getStatus() async {
    try {
      isloading.value = true;
      update();
      dynamic response = await _apiService.getApi(AppUrl.driverStatusApi);
      if(response['message'] == "Unauthenticated"){
        userPreference.removeUser().then((value) => Get.offAll(LoginScreen()));
      }
      if(response['status_code'] == 200){
        driverStatusModel.value = DriverStatus.fromJson(response);
        isloading.value = false;
        update();
      }
      else if(response['status_code'] == 401){
        isloading.value = false;
        await userPreference.removeUser().then((value) => Get.offAll(LoginScreen()));
      }
      else{
        isloading.value = false;
      }
    } on SocketException catch (e) {
      isloading.value = false;
      Get.back();
    }
    catch (e) {
      Get.back();
      isloading.value = false;
      Utils.snackBar('error', e.toString());
      log(e.toString());
    }
  }
  Future<void> checkIn() async {
    try {
      isloading.value = true;
      dynamic response = await _apiService.getApi(AppUrl.checkInApi);
      if(response['status_code'] == 200){
        isloading.value = false;
        getStatus();
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
  Future<void> checkOut() async {
    try {
      isloading.value = true;
      dynamic response = await _apiService.getApi(AppUrl.checkOutApi);
      if(response['status_code'] == 200){
        isloading.value = false;
        getStatus();
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
  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    // DriverStatusController().dispose();
    super.dispose();
  }


}