import 'package:crypto_coins_list/crypto_coins_list_app.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  // Для работы с DependencyInjection
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(() => CryptoCoinsRepository(dio: Dio()));
  // GetIt регистрирует LazySingleton с типом AbstractCoinsRepository с реализацией CryptoCoinsRepository
  // LazySingleton - означает, что инстанс создастся при первом обращении к нему,а не сразу (экономия ресурсов)
  
  runApp(const CryptoCurrenciesListApp());
}

