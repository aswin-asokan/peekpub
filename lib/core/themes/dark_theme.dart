import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkmode = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Color(0xff154467),
    onPrimary: Color(0xff97a6b2),
    secondary: Color(0xff242b32),
    onSecondary: Color(0xffb9babc),
    tertiary: Color(0xff2a3c50),
    onTertiary: Color(0xff696c6e),
    surface: Color(0xff1c2834),
    onSurface: Color(0xffffffff),
    surfaceTint: Color(0xffffffff),
  ),
  scaffoldBackgroundColor: Color(0xff131316),
  textTheme: TextTheme(
    //used on title
    titleLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w300,
      fontSize: 26,
      color: Color(0xffffffff),
    ),
    titleMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Color(0xffffffff),
    ),
    titleSmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: Color(0xff696c6e),
    ),
    labelMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color(0xff97a6b2),
    ),
    labelSmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Color(0xff97a6b2),
    ),
    bodyLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w300,
      fontSize: 26,
      color: Color(0xffffffff),
    ),
    //used on search
    bodyMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Color(0xff696c6e),
    ),
    bodySmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Color(0xffffffff),
    ),
  ),
);
