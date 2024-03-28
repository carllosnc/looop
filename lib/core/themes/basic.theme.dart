import 'package:flutter/material.dart';

appTheme({required bool isLight}) => ThemeData(
      useMaterial3: true,
      brightness: isLight ? Brightness.light : Brightness.dark,
      colorSchemeSeed: Colors.grey,
      fontFamily: 'SFProDisplay',
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      //remove border from drawer header
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: Colors.grey,
        floatingLabelStyle: TextStyle(
          color: Colors.blue[800],
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.3),
            width: 1,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: Colors.white,
        dayPeriodTextColor: Colors.black,
        hourMinuteTextColor: Colors.black,
        helpTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        hourMinuteColor: Colors.black.withOpacity(0.1),
        dayPeriodColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
