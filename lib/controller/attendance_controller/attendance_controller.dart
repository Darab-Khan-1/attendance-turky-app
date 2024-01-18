import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../constants/app_url/app_url.dart';
import '../../data/network/network_api_services.dart';
import '../../model/attendance_model/attendance_model.dart';
import '../../res/utils/utils.dart';

class AttendanceController extends GetxController {
  final allAttendance = AllAttendanceModel().obs;
  final _apiService = NetworkApiServices();

  final isloading = false.obs;
  Future<void> getAllAttendance() async{
    isloading.value = true;
    try{
      dynamic response = await _apiService.getApi(AppUrl.allAttendanceApi);
      if(response['status_code'] == 200){
        isloading.value = false;
        allAttendance.value = AllAttendanceModel.fromJson(response);
        update();
      }
      else{
        isloading.value = false;
        Utils.snackBar('Error', response['error']);
      }
    }catch(e){
      isloading.value = false;
      Utils.snackBar('Error', "Network Error");
    }
  }
}