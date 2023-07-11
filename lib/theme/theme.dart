import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  // This is the theme of your application.
  dividerColor: Colors.white54, // Цвет разделителя у списка
  scaffoldBackgroundColor: const Color.fromARGB(250, 31, 31, 31), // Фон для все экранов сразу
  primarySwatch: Colors.yellow, // Дефолтный цвет, если он не задан для каких-то элементов
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0, //Убираем тень у шапки
      backgroundColor: Color.fromARGB(250, 31, 31, 31), //Цвет шапки
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      )
  ),
  // В теме возможно нужно убрать const
  textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20
      ),
      labelSmall: TextStyle(
          color: Color.fromRGBO(24,233, 111, 0.6),
          fontWeight: FontWeight.w700,
          fontSize: 14
      )
  ),
);