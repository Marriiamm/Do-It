import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color kDarkGreen = Color(0XFF82C2BD);
const Color kLightBeige = Color(0XFFFFEBBE);
const Color kLightGreen = Color(0xffD5EBED);
const Color kgray = Color(0xffDAE7EF);

const primaryClr = Colors.white;

const Color kdarkClr = Color(0xff003044);
const Color kdarkDo1 = Color(0xffA1B4B3);
const Color kdarkDo2 = Color.fromARGB(255, 83, 174, 168);
const Color kdarkDo3 = Color(0xff1EC88F);
const Color kdarkDod = Color(0xffA9BBBD);
class Themes {
static final lightAppColors =  ThemeData(
        primaryColor: primaryClr,
        scaffoldBackgroundColor: primaryClr,
        brightness: Brightness.light,
        useMaterial3: true,
        
      );
static final darkAppColors =  ThemeData(
        primaryColor: kdarkClr,
        scaffoldBackgroundColor: kdarkClr,
        brightness: Brightness.dark,
        useMaterial3: true,
      );


}
TextStyle get headingStyle {
  return TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: Get.isDarkMode? Colors.white :Colors.black,
    fontFamily: "Exo2",
  );
}

TextStyle get supHeadingStyle {
  return TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: Get.isDarkMode? Colors.white :Colors.black,
    fontFamily: "Exo2",
  );
}

TextStyle get titleStyle {
  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Get.isDarkMode? Colors.white :Colors.black,
    fontFamily: "Exo2",
  );
}
TextStyle get supTitleStyle {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Get.isDarkMode? Colors.white :Colors.black,
    fontFamily: "Exo2",
  );
}