import 'dart:developer';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  void initState() {
    _loadCryptoCoins();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        // Here we take the value from the CryptoListScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: _cryptoCoinsList == null
          ? const Center(
              child:
                  CircularProgressIndicator()) // Если данных нет, выводим лоадер, иначе список
          : ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemCount:
                  _cryptoCoinsList!.length, // Сколько будет элементов в списке
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, i) {
                final coin = _cryptoCoinsList![i];

                return CryptoCoinTile(coin: coin);
              },
            ),
    );
  }

  // Приватная функция
  Future<void> _loadCryptoCoins() async => {
        // По нажатию на кнопку делаем запрос на валюты и записываем в приватную переменную
        _cryptoCoinsList = await GetIt.I<AbstractCoinsRepository>().getCoinsList(),
        // Обновляем стейт для отрисовки новых данных
        setState(() {})
      };
}
