import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightmode = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xff4886db),
    onPrimary: Color(0xffe6f9ff),
    secondary: Color(0xfff4f5f6),
    onSecondary: Color(0xfff4f5f6),
    tertiary: Color(0xff2a3c50),
    onTertiary: Color(0xff696c6e),
    surface: Color(0xff1c2834),
    onSurface: Color(0xffffffff),
    surfaceTint: Color(0xff1c2834),
  ),
  scaffoldBackgroundColor: const Color(0xffffffff),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.w300,
      fontSize: 26,
      color: Color(0xffffffff),
    ),
    titleMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Color(0xff000000),
    ),
    titleSmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      color: Color(0xff696c6e),
    ),
    labelMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Color(0xffe6f9ff),
    ),
    labelSmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Color(0xffe6f9ff),
    ),
    bodyLarge: GoogleFonts.outfit(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: Color(0xff000000),
    ),
    bodyMedium: GoogleFonts.outfit(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Color(0xff696c6e),
    ),
    bodySmall: GoogleFonts.outfit(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Color(0xff000000),
    ),
  ),
);
