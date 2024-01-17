import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/login_model/login_model.dart';


class UserPreference {
  Future<bool> saveUser(LoginModel responseModel) async {
    print('Saving user...');

    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString('token', responseModel.data!.bearerToken ?? '');
    sp.setBool('isLogin', responseModel.isLogin! );
    sp.setString('unique_id', responseModel.data!.uniqueId ?? '');
    sp.setBool('onlineStatus', responseModel.data!.onlinestatus!);
    if (kDebugMode) {
      print('User saved.');
    }
    return true;
  }

  getUserID() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? uniqueId = sp.getString('unique_id');
    return uniqueId;
  }
  getOnlineStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? onlineStatus = sp.getBool('onlineStatus');
    return onlineStatus;
  }

  Future<LoginModel> getUser() async {
    if (kDebugMode) {
      print('Getting user...');
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    String? uniqueId = sp.getString('unique_id');
    bool? onlineStatus = sp.getBool('onlineStatus');
    bool? isLogin = sp.getBool('isLogin');
    print('User got.');
    return LoginModel(
      data: Data(bearerToken: token, uniqueId: uniqueId, onlinestatus: onlineStatus),
      isLogin: isLogin,
    );
  }

  Future<bool> removeUser() async {
    print('Removing user...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    print('User removed.');
    return true;
  }
}
