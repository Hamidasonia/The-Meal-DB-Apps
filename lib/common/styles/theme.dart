import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:submission_dicoding_pemula/common/styles/color.dart';

ThemeData tdMain(BuildContext context) => ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: hBlack,
      unselectedWidgetColor: Colors.grey,
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme.apply(
              bodyColor: Colors.blue,
              displayColor: Colors.black,
            ),
      ),
      primaryColor: Colors.blue,
      colorScheme: const ColorScheme.dark(primary: Colors.blue),
      primaryColorDark: Colors.blueGrey,
      dividerColor: Colors.blue,
      appBarTheme: AppBarTheme(
        color: hBlack,
        iconTheme: const IconThemeData(color: Colors.lightBlueAccent),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: const TextStyle(color: Colors.black),
        hoverColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
    );
