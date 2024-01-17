import 'package:flutter/material.dart';
import 'colors.dart';


class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: kWhiteColor,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: kPrimaryColor,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          textStyle: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(fontWeight: FontWeight.w600, ),
          minimumSize: const Size(double.infinity, 55),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side:  BorderSide(color: kPrimaryColor),
          backgroundColor: kWhiteColor,
          foregroundColor: kWhiteColor,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: kBlackColor, fontWeight: FontWeight.w600, ),
          // minimumSize: const Size(100, 55),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: kMainColor),
          borderRadius: BorderRadius.circular(8),

        ),
        focusedErrorBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputActiveBorder,
        errorBorder: outlineInputBorder,
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: kMainColor,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: kWhiteColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: kWhiteColor),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: kWhiteColor,
        contentTextStyle: TextStyle(
          color: kBlackColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
final OutlineInputBorder outlineInputActiveBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide:   BorderSide(color: kMainColor,width: 2), // Green border color
);
final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: kMainColor,width: 1));