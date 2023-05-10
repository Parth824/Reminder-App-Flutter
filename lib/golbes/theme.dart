import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../controoler/theme_controller.dart';

const Color primerClr = Color(0xfff6a237);
const Color garyClr = Color(0xfff1f1f1);
const Color bulClr = Color(0xff3f414e);
const Color backClr = Color(0xff3f414e);
const Color whileClr = Color(0xffeeeeee);
const Color gryClr = Color(0xff9a9b9e);

class Themes {
  static final ligth = ThemeData(
    backgroundColor: Colors.white,
     primaryColor: whileClr,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    shadowColor: Colors.grey,
    buttonColor: backClr,
  );
  static final drak = ThemeData(
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
    primaryColor: backClr,
    buttonColor: garyClr,
    iconTheme: IconThemeData(color: Colors.white),
    shadowColor: bulClr,
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


