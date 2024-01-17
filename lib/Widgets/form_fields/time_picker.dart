import 'package:flutter/material.dart';

import '../../constants/colors.dart';


class TimePickerTextField extends StatefulWidget {
  final TextEditingController controller;

  TimePickerTextField({required this.controller});

  @override
  _TimePickerTextFieldState createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.controller.text = selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: 'Select Time',
            contentPadding: EdgeInsets.only(left: 10,right: 20),
            errorStyle: const TextStyle(color: Colors.red),
            errorBorder: outlineInputBorder,
            labelStyle:  TextStyle(color:kMainColor,fontSize: 12.0),
            focusedErrorBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputActiveBorderBlue,
            suffixIcon: GestureDetector(
              onTap: () => _selectTime(context),
              child: Icon(Icons.access_time),
            ),
          ),
          readOnly: true,
          onTap: () => _selectTime(context),
        ),
      ],
    );
  }
}
final OutlineInputBorder outlineInputActiveBorderBlue = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide:   BorderSide(color: kMainColor,width: 2), // Green border color
);
final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: kMainColor,width: 1));