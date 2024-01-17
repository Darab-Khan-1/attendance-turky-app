import 'package:attendence_app/constants/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../Services/location_services/location_services.dart';
import '../../Services/user_preferences/user_preferences.dart';
import '../../data/response/status.dart';

class MapController extends GetxController {
  String? uid;
  @override
  Future<void> onInit() async {
    super.onInit();
    getCurrentLocation();
  }
  // RxBool isloading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxString error = ''.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setError(String _value) => error.value = _value;
  ScrollController scrollController = ScrollController();
  UserPreference userPreference = UserPreference();
  var currentPosition = Rx<LocationData?>(null);
  Rx<CameraPosition> initialLocation = CameraPosition(
      target: LatLng(31.4535128, 74.2518413), zoom: 12).obs;
  RxDouble zoomValue = 14.0.obs;
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  List<LatLng> routeCoordinates = [];


  Future<void> getCurrentLocation() async {
    uid = await userPreference.getUserID();
    try {
      LocationService.PermissionRequest().then((value) {
          Location.instance.onLocationChanged.listen((locationData) async {
            currentPosition.value = locationData;
            // print('The Current Location is ${currentPosition.value}');
            initialLocation.value = CameraPosition(
                target: LatLng(currentPosition.value!.latitude!,
                    currentPosition.value!.longitude!),
                zoom: 14);
            update();
          });
      });
    } catch (e) {
      print("The Error in Getting Current user function ${e.toString()}");
    }
  }

}