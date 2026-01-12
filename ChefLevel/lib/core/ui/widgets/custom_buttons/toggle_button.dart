// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;

  const AnimatedToggle({
    super.key,
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFE2E2E2),
    this.buttonColor = const Color(0xFFFF2700),
  });
  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

const double width = 180.0;
const double height = 36.0;
const double phoneAlign = -1;
const double emailAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black;

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;

  late double xAlign;
  late Color phoneColor;
  late Color emailColor;

  @override
  void initState() {
    super.initState();
    xAlign = phoneAlign;
    phoneColor = selectedColor;
    emailColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: Duration(milliseconds: 300),
            child: Container(
              width: width * 0.5,
              height: height,
              decoration: BoxDecoration(
                color: widget.buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = phoneAlign;
                phoneColor = selectedColor;
                emailColor = normalColor;
              });
              widget.onToggleCallback(xAlign);
            },
            child: Align(
              alignment: Alignment(-1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  widget.values[0],
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: xAlign == -1 ? selectedColor : normalColor,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = emailAlign;
                emailColor = selectedColor;
                phoneColor = normalColor;
              });
              widget.onToggleCallback(xAlign);
            },
            child: Align(
              alignment: Alignment(1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  widget.values[1],
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: xAlign == -1 ? normalColor : selectedColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
