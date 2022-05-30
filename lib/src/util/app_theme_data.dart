import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    const bottomBorderColor = Color(0xFF98DFBE);
    return ThemeData(
        colorScheme: colorScheme,
        textTheme: _textTheme,
        buttonTheme: ButtonThemeData(
            buttonColor: colorScheme.secondary,
            textTheme: ButtonTextTheme.normal,
            colorScheme:
                colorScheme.copyWith(secondary: colorScheme.onSecondary),
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: colorScheme.secondary,
            side: BorderSide(color: colorScheme.secondary, width: 1),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF20B972)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: colorScheme.secondary,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                textStyle: _textTheme.button!.copyWith(color: Colors.black))),
        iconTheme: IconThemeData(color: colorScheme.primary),
        scaffoldBackgroundColor: colorScheme.background,
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          contentTextStyle: _textTheme.bodyText1,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle:
              _textTheme.bodyText1!.copyWith(color: colorScheme.primary),

          hintStyle: _textTheme.bodyText1!.copyWith(color: colorScheme.primary),
          // contentPadding:
          //     const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2),
          prefixStyle: TextStyle(color: colorScheme.secondary),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: bottomBorderColor),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: bottomBorderColor),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: bottomBorderColor),
          ),
        ));
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF12663F),
    primaryVariant: Color(0xFF0d4e30),
    secondary: Color(0xFFCEF55C),
    secondaryVariant: Color(0xFF92ae41),
    background: Color(0xFFF8F9FD),
    surface: Color(0xFFF8F9FD),
    onPrimary: Color(0XFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onBackground: Color(0xFF000000),
    error: Color(0xFFB00020),
    onError: Color(0xFFFFFFFF),
    onSurface: Color(0xFF000000),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: const Color(0xFF112742),
    primaryVariant: const Color(0xFFFB33F00),
    secondary: const Color(0xFFCEF55C),
    secondaryVariant: const Color(0xFF9F3800),
    background: const Color(0xFFFCF6F3),
    surface: Color(0xFFFEFDFD),
    onPrimary: Color(0XFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onBackground: Color(0xFF000000),
    error: Color(0xFFB00020),
    onError: Color(0xFFFFFFFF),
    onSurface: Color(0xFF000000),
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _extraBold = FontWeight.w800;
  static const _bold = FontWeight.w700;
  static const _black = FontWeight.w900;

  // static final TextTheme _textTheme = GoogleFonts.robotoTextTheme();
  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.sourceSansPro(fontSize: 32, fontWeight: _bold),
    headline2: GoogleFonts.sourceSansPro(fontSize: 28, fontWeight: _bold),
    headline3: GoogleFonts.sourceSansPro(fontSize: 24, fontWeight: _regular),
    headline4: GoogleFonts.sourceSansPro(fontSize: 32, fontWeight: _regular),
    headline5: GoogleFonts.sourceSansPro(),
    headline6: GoogleFonts.sourceSansPro(),
    subtitle1: GoogleFonts.sourceSansPro(),
    subtitle2: GoogleFonts.sourceSansPro(),
    bodyText1: GoogleFonts.sourceSansPro(fontSize: 18, fontWeight: _semiBold),
    bodyText2: GoogleFonts.sourceSansPro(fontSize: 18, fontWeight: _regular),
    caption: GoogleFonts.sourceSansPro(),
    button: GoogleFonts.sourceSansPro()
        .copyWith(fontSize: 16, fontWeight: _semiBold),
    overline: GoogleFonts.sourceSansPro(),
  );
}
