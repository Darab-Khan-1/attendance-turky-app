import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const ExpandableText({required this.text, required this.style});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Text(
        widget.text,
        style: widget.style,
        overflow: _isExpanded ? null : TextOverflow.ellipsis,
      ),
    );
  }
}
