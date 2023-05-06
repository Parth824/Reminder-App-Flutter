import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../controoler/theme_controller.dart';

const Color primerClr = Color(0xfff6a237);
const Color garyClr = Color(0xfff1f1f1);
const Color bulClr = Color(0xff3f414e);

class Themes {
  static final ligth = ThemeData(
    backgroundColor: Colors.white,
    // primaryColor: primerClr,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
  );
  static final drak = ThemeData(
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.white),
  );
}

TextStyle Hedering(BuildContext context) {
  return GoogleFonts.lato(
    color: Provider.of<ThemeController>(context).themeModel.isdark
        ? Colors.white
        : Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}
