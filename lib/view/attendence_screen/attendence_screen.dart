import 'package:attendence_app/Widgets/buttons/k_elevated_button.dart';
import 'package:attendence_app/Widgets/form_fields/k_text.dart';
import 'package:attendence_app/controller/driver_status_controller/driver_status_controller.dart';
import 'package:attendence_app/view/attendence_screen/all_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colors.dart';
class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverStatusController>(
        init: DriverStatusController(),
        builder: (controller) {
          return  Scaffold(
            appBar: AppBar(
              title: const Text('Attendance'),
            ),
            body: Container(
              child: controller.isloading.value
                  ? const Center(child: CircularProgressIndicator())
                  :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.driverStatusModel.value.data!.checkIn == ""
                      ?Container():
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KText(text: "Checked In at:", fontSize: 20),
                      const Gap(10),
                      Text(DateFormat('hh:mm a').format(DateTime.parse(controller.driverStatusModel.value.data!.checkIn!))),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    indent: MediaQuery.of(context).size.width * 0.2,
                    endIndent: MediaQuery.of(context).size.width * 0.2,
                    thickness: 1,
                  ),
                  const Gap(20),
                  controller.driverStatusModel.value.data!.checkOut == ""
                      ?Container():
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          KText(text: "Checked Out at:", fontSize: 20),
                          const Gap(10),
                          Text(DateFormat('hh:mm a').format(DateTime.parse(controller.driverStatusModel.value.data!.checkOut!))),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        indent: MediaQuery.of(context).size.width * 0.2,
                        endIndent: MediaQuery.of(context).size.width * 0.2,
                        thickness: 1,
                      ),
                    ],
                  ),
                  const Gap(100),
                  controller.driverStatusModel.value.data!.online == 0
                      ? CheckButton(title: "Check In", onPressed: () {
                    controller.checkIn();
                  })
                      : CheckButton(title: "Check Out", onPressed: () {
                    controller.checkOut();
                  }),
                  // Gap(20),
                  // CheckButton(title: "Check Out", onPressed: () {}),
                ],
              ),
            ),
            floatingActionButton: KFloatingButton(
              lable: "View Details",
              ontap: () {
                Get.to(AllAttendanceScreen());
              },
            ),
          );
        });
  }
}