import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle textStyle({
    Color color = Colors.black,
    double size = 24,
    FontWeight weight = FontWeight.normal,
  }) {
    return GoogleFonts.lexendDeca(
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }
}
