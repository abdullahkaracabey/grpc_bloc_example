import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Snack {
  static showInfoSnack(BuildContext context, String text, {Duration? duration}) {
    SnackBar snackBar = SnackBar(
        duration: duration ?? Duration(seconds: 4),
        content: Text(
          text,
          style: GoogleFonts.firaSans(
              fontWeight: FontWeight.w800, fontSize: 14.0, color: Colors.white),
        ));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}