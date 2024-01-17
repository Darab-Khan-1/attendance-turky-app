import 'package:flutter/material.dart';

class KText extends StatelessWidget {
  KText({
    Key? key,
    required this.text,
    this.maxLine,
    this.textAlign,
    this.textDirection,
    this.textOverflow = TextOverflow.ellipsis,
    this.color,
    this.fontFamily = 'Poppins',
    this.fontSize = 12,
    this.fontWeight = FontWeight.bold,
    this.letterSpacing,
    this.textDecoration,
    this.wordSpacing,
  }) : super(key: key);

  final String text;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? textOverflow;
  final int? maxLine;
  Color? color = Color(0xff000000);
  final FontWeight? fontWeight;
  final double? fontSize, letterSpacing, wordSpacing;
  final TextDecoration? textDecoration;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        textDirection: textDirection,
        overflow: textOverflow,
        maxLines: maxLine,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: fontFamily,
      ),);
  }
}