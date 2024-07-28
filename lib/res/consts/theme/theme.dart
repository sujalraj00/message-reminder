import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:message_reminder/res/consts/texttheme.dart';

import '../t_colors.dart';
import 'custom_theme/elevated_button_theme.dart';
import 'custom_theme/outlined_button_theme.dart';
import 'custom_theme/text_field_theme.dart';

class TAppTheme{
  TAppTheme._();

  // light theme
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.blue,
      textTheme: TTextTheme.lightTextTheme,
     // chipTheme: TChipTheme.lightChipTheme,
     // appBarTheme: TAppBarTheme.lightAppBarTheme,
     // checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
     // bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme
  );

  //dark theme
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: TColors.black,
      primaryColor: Colors.blue,
      textTheme: TTextTheme.darkTextTheme,
      // chipTheme: TChipTheme.darkChipTheme,
      // appBarTheme: TAppBarTheme.darkAppBarTheme,
      // checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
      // bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme
  );


}