import 'package:flutter/material.dart';

class Themes {
  static const primaryDarkColor = Color(0xff15B86C);
  static const darkForegroundColor = Color(0xfffffcfc);
  static const darkMainTextColor = Color(0xffffffff);

  static const primaryLightColor = Color(0xff14A662);
  static const lightForegroundColor = Color(0xffffffff);
  static const lightMainTextColor = Color(0xff161F1B);

  static ThemeData dark(BuildContext context) => ThemeData(
        primaryColor: Colors.green,
        colorScheme: const ColorScheme.dark(
          primary: primaryDarkColor,
          secondary: Colors.greenAccent,
          surface: Color(0xff181818),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryDarkColor,
            foregroundColor: darkForegroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        cardTheme: const CardTheme(
            color: Color(0xff282828),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true, fillColor: Color(0xFF282828)),
        dividerColor: const Color(0xff6E6E6E),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: primaryDarkColor,
            unselectedItemColor: Color(0xffc6c6c6)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryDarkColor,
          foregroundColor: darkForegroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: darkMainTextColor,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: darkMainTextColor,
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: darkMainTextColor,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: darkMainTextColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: darkMainTextColor,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: darkMainTextColor,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xffc6c6c6),
          ),
          labelSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff6d6d6d),
          ),
        ),
        useMaterial3: true,
      );

  static ThemeData light(BuildContext context) => ThemeData(
        primaryColor: Colors.green,
        colorScheme: const ColorScheme.light(
          primary: primaryLightColor,
          secondary: Colors.greenAccent,
          surface: Color(0xFFF6F7F9),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryLightColor,
            foregroundColor: lightForegroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        cardTheme: const CardTheme(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side: BorderSide(color: Color(0xffD1DAD6), width: 1))),
        inputDecorationTheme: const InputDecorationTheme(
            filled: true, fillColor: lightForegroundColor),
        dividerColor: const Color(0xffD1DAD6),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color(0xff14A662),
            unselectedItemColor: Color(0xff3A4640)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLightColor,
          foregroundColor: const Color(0xfffffcfc),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: lightMainTextColor,
          ),
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: lightMainTextColor,
          ),
          headlineSmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: lightMainTextColor,
          ),
          titleLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: lightMainTextColor,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: lightMainTextColor,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: lightMainTextColor,
          ),
          labelMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff3A4640),
          ),
          labelSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff9E9E9E),
          ),
        ),
        useMaterial3: true,
      );
}
