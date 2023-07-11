import 'dart:developer';
import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({Key? key}) : super(key: key);

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies(){ // Метод жизненного цикла
    // Вытаскиваем аргументы, переданные при переходе по роуту "/coin"
    final args = ModalRoute.of(context)?.settings.arguments; // Может быть null, поэтому опц.последовательность
    // Проверка на то, переданы ли аргументы и верен ли их формат
    assert(args != null && args is String, "You must provide args!");
    log('isOk');

    coinName = args as String;
    setState(() {}); //Чтобы обновить экран после получения нового заголовка
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(coinName ?? "..."),
      ),
    );
  }
}