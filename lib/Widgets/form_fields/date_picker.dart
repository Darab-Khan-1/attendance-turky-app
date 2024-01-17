
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../constants/colors.dart';



class InputDateSelectionTextField extends StatefulWidget {
  TextEditingController controller;
  final String hintText;
  final bool isValidationRequired;
  final Function(String)? onChange;
  InputDateSelectionTextField({
    Key? key,
    this.onChange,
    required this.controller,
    required this.hintText,
    this.isValidationRequired = false,

  }): super(key: key) {
    // set initial value to controller here
  }

  @override
  State<InputDateSelectionTextField> createState() =>
      _InputDateSelectionTextFieldState();
}

class _InputDateSelectionTextFieldState
    extends State<InputDateSelectionTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(widget.isValidationRequired){
          if (value == null || value.isEmpty) {
            return "Select Date";
          }
        }
      },
      controller: widget.controller,
      cursorColor: kBlackColor,
      onChanged: widget.onChange,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      ), //editing controller of this TextField
      decoration: InputDecoration(
        prefixIcon: Icon(MdiIcons.calendar), //icon of text field
        // labelText: "Enter Date", //label text of field
        errorBorder: outlineInputBorder,
        labelStyle:  TextStyle(color:kMainColor,fontSize: 12.0),
        focusedErrorBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputActiveBorderBlue,
        prefixIconColor: kBlackColor,
        contentPadding: EdgeInsets.only(left: 10,right: 20),
        border: InputBorder.none,
        //fillColor: const Color.fromARGB(255, 251, 250, 249),
        fillColor: Colors.transparent,
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: kMainColor,
          fontSize: 12,
        ),
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: kBlackColor.withOpacity(0.5),
                    onPrimary: Colors.white,
                    surface: kDarkGreyColor,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: Colors.white,
                ),
                child: child!,
              );
            },
            initialDate: DateTime.now(),
            firstDate: DateTime(
                2000), //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime(2101),
        initialDatePickerMode: DatePickerMode.day
        );

        if (pickedDate != null) {
          // print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          //  print(formattedDate); //formatted date output using intl package =>  2021-03-16
          //you can implement different kind of Date Format here according to your requirement

          setState(() {
            widget.controller.text =
                formattedDate; //set output date to TextField value.
          });
        } else {
          print("Date is not selected");
        }
      },

    );
  }
  final OutlineInputBorder outlineInputActiveBorderBlue = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide:   BorderSide(color: kMainColor,width: 2), // Green border color
  );
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: kMainColor));
}
