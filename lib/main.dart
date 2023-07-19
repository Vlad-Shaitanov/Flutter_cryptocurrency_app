import 'dart:async';

import 'package:crypto_coins_list/crypto_coins_list_app.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = TalkerFlutter.init(); // Инициализация логгера
  GetIt.I.registerSingleton(talker); // Регистрация инстанса логгера
  GetIt.I<Talker>().debug('Talker started...');

  // Заводим новый инстанс Дио и добавляем к нему логгирование
  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker, // Если нужно логгирование для разных платформ
      settings: const TalkerDioLoggerSettings(
          printResponseData: false, // В данном случае мы отключили передачу респонса в лог
      ),
    ),

  );

  // Подключили логгирование для стейт-менеджера Bloc
  Bloc.observer = TalkerBlocObserver(
      talker: talker, // Если нужно логгирование для разных платформ
      settings: const TalkerBlocLoggerSettings(
        printEventFullData: false, // Не показывать полные данные
        printStateFullData: false, // Не показывать полное состояние
      ),
  );

  // Для работы с DependencyInjection
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
      () => CryptoCoinsRepository(dio: dio));
  // GetIt регистрирует LazySingleton с типом AbstractCoinsRepository с реализацией CryptoCoinsRepository
  // LazySingleton - означает, что инстанс создастся при первом обращении к нему,а не сразу (экономия ресурсов)

  // Так мы сможем увидеть внутренние ошибки флаттера (например неправильная верстка) в толкере
  FlutterError.onError = (details) => GetIt.I<Talker>().handle(details.exception, details.stack);


  // Метод позволяет запускать приложение в отдельной зоне, в которой в колбэке будут доступны все ошибки и стактрейсы
  runZonedGuarded(
          () => runApp(const CryptoCurrenciesListApp()),
          (e, st) => GetIt.I<Talker>().handle(e, st)
  );
}
