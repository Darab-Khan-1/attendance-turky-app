import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/map_controller/map_controller.dart';
class MapScreen extends StatelessWidget {
   MapScreen({super.key});
   final _mapController = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
        init: MapController(),
        builder: (controller) {
          return  Scaffold(
              appBar: AppBar(
                title: Text("Map View"),
              ),
              body: Container(
                child: Obx(() => GoogleMap(
                  compassEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  trafficEnabled: true,
                  initialCameraPosition: _mapController.initialLocation.value,
                  gestureRecognizers: Set()
                    ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer()))
                    ..add(Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer()))
                    ..add(Factory<HorizontalDragGestureRecognizer>(
                            () => HorizontalDragGestureRecognizer()))
                    ..add(Factory<ScaleGestureRecognizer>(
                            () => ScaleGestureRecognizer())),
                  // mapToolbarEnabled: true,
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) async {
                    _mapController.mapController = controller;
                  },


                )),
              )
          );
        });
  }
}
