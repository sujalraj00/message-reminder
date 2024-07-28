
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:message_reminder/res/consts/font.dart';
import 'package:get/get.dart';

class AppStyles{

  TextStyle regular({Color? color,
    FontWeight fontWeight =FontWeight.normal,
    String? fontfamily =AppFonts.regular,
    double ? size =14.0
  }) {
    return TextStyle(
      fontFamily: fontfamily,
      fontSize: size,
      fontWeight: fontWeight,
      color: color
    );
  }


  TextStyle bold({Color? color,
    FontWeight ? fontWeight,
    String? fontfamily =AppFonts.bold,
    double? size =14.0
  }) {
    return TextStyle(
        fontFamily: fontfamily,
        fontSize: size,
        fontWeight: fontWeight,
        color: color
    );
  }

  TextStyle semibold(
      {Color? color,
        FontWeight? fontWeight,
        String? fontfamily = AppFonts.semibold,
        double? size = 14.0}) {
    return TextStyle(
        fontWeight: fontWeight,
        fontSize: size,
        color: color,
        fontFamily: fontfamily);
  }

  TextStyle get subHeadingStyle{
    return GoogleFonts.lato (
        textStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          color: Get.isDarkMode? Colors.grey[400] : Colors.grey
        )
    );
  }
  TextStyle get headingStyle{
    return GoogleFonts.lato (
        textStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode? Colors.white : Colors.black
        )
    );
  }

  TextStyle get titleStyle {
    return GoogleFonts.lato(
      textStyle:TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color:  Get.isDarkMode ? Colors.white : Colors.black
      )
    );
  }


  TextStyle get subTitleStyle {
    return GoogleFonts.lato(
        textStyle:TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color:  Get.isDarkMode ? Colors.grey[100] : Colors.grey[600]
        )
    );
  }

}