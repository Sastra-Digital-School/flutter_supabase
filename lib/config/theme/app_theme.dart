import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final fontFamily = GoogleFonts.poppins().fontFamily;

  // 🎨 Shared Colors
  static const primaryColor = Color(0xFF3B4D99); // Blue
  static const secondaryColor = Color(0xFF4D67E8);
  static const errorColor = Colors.redAccent;
  static const Color textColor = Color(0xFF000000);

  // 🌞 Light Theme Colors
  static const backgroundLight = Color.fromARGB(255, 230, 234, 239);
  static const inputFillLight = Color(0xFFEDEFF5);
  static const textColorLight = Color(0xFF2D2E33);
  static const hintColorLight = Color(0xFF8A8A8E);
  static const borderColorLight = Color(0xFFDADCE0);

  // 🌚 Dark Theme Colors
  static const backgroundDark = Color(0xFF1A1C2D);
  static const inputFillDark = Color(0xFF2B2D42);
  static const textColorDark = Color(0xFFEFEFF1);
  static const hintColorDark = Color(0xFF9FA0A4);
  static const borderColorDark = Color(0xFF3C3F58);

  static TextTheme? textTheme = GoogleFonts.poppinsTextTheme().copyWith(
    bodyLarge: TextStyle(color: textColor, fontSize: 16),
    bodyMedium: TextStyle(
      color: textColor.withValues(alpha: 0.85),
      fontSize: 14,
    ),
    labelLarge: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w600,
      fontSize: 13,
    ),
    titleLarge: TextStyle(
      color: textColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  );

  // 🌞 Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(backgroundColor: backgroundLight),
      scaffoldBackgroundColor: backgroundLight,
      primaryColor: primaryColor,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFillLight,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColorLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColorLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        hintStyle: TextStyle(color: hintColorLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textTheme: textTheme,
    );
  }
}
