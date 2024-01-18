import 'dart:convert';

import 'package:attendence_app/controller/attendance_controller/attendance_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllAttendanceScreen extends StatefulWidget {
  AllAttendanceScreen({super.key});

  @override
  State<AllAttendanceScreen> createState() => _AllAttendanceScreenState();
}

class _AllAttendanceScreenState extends State<AllAttendanceScreen> {
  final controller = Get.put(AttendanceController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.getAllAttendance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Attendance'),
      ),
      body: Obx(() => Container(
            padding: const EdgeInsets.all(10),
            child: controller.isloading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: controller.allAttendance.value.data!.length,
                    itemBuilder: (context, index) {
                      var data = controller.allAttendance.value.data![index];
                      var time = jsonDecode(data.hours!);
                      var hours = time['hours'];
                      var minutes = time['minutes'];
                      var checkIn = DateFormat('hh:mm a')
                          .format(DateTime.parse(data.checkIn!));
                      var checkOut = DateFormat('hh:mm a')
                          .format(DateTime.parse(data.checkOut!));
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                              DateFormat('dd-MMM-yyyy').format(DateTime.parse(data.checkIn!)),
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Row(
                            children: [
                              _buildColumn("Check in", checkIn),
                              const VerticalDivider(
                                color: Colors.black,
                                thickness: 1,
                                indent: 1,
                                endIndent: 1,
                              ),
                              _buildColumn("Check out", checkOut),
                            ],
                          ),
                          trailing: _buildColumn("Duration", "$hours:$minutes"),
                          // Add any other properties or widgets you want to display
                        ),
                      );
                    },
                  ),
          )),
    );
  }

  Widget _buildColumn(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue)),
        Gap(4),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
