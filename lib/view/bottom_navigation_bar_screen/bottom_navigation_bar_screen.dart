
import 'dart:async';
import 'package:attendence_app/controller/driver_status_controller/driver_status_controller.dart';
import 'package:attendence_app/view/attendence_screen/attendence_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Widgets/navigationBar/navigationBar.dart';
import '../../constants/colors.dart';
import '../map_view/map_view.dart';
import '../profile_screen/profile_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;

  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DriverStatusController().onInit();
  }

  final List _widgetOptions = [
    ///------------ Name of The Screens/View ------------------- ///
MapScreen(),
    AttendanceScreen(),
    ProfileScreen(),
  ];

  _onItemTapped(var index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _oncancelTapped(var index) {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Close the app when the back button is pressed
      onWillPop: () async {
        // Close the app when the back button is pressed
        SystemNavigator.pop();
        return Future.value(false); // Return false to allow the app to close
      },
      child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: CustomAnimatedBottomBar(
            containerHeight: 60,
            backgroundColor: kWhiteColor,
            selectedIndex: _selectedIndex,
            showElevation: true,
            itemCornerRadius: 10,
            curve: Curves.easeIn,
            onItemSelected: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            onTap: () {
                   _onItemTapped(_selectedIndex);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: const Icon(
                  Icons.insights_outlined,
                  size: 30,
                ),
                title: Text(
                  "Google Map",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15),
                ),
                activeColor: kMainColor,
                inactiveColor: kBlackColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  size: 28,
                ),
                title: Text(
                  'attendance',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                activeColor: kMainColor,
                inactiveColor: kBlackColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const Icon(
                  Icons.account_circle_rounded,
                  size: 34,
                ),
                title: Text(
                  'Profile',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15),
                ),
                activeColor: kMainColor,
                inactiveColor: kBlackColor,
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }
}