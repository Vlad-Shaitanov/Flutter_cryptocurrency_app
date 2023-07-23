import 'package:auto_route/auto_route.dart';
import 'package:crypto_coins_list/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_coins_list/features/crypto_list/crypto_list.dart';
import 'package:flutter/material.dart';

import '../repositories/crypto_coins/crypto_coins.dart';

// final routes = {
//   "/coin": (context) => const CryptoCoinScreen(),
//   "/": (context) => const CryptoListScreen(title: "Crypto currency list"), // Дефолтный роут(главная страница приложения)
// };

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CryptoListRoute.page, path: '/'), // Дефолтная страница
    AutoRoute(page: CryptoCoinRoute.page)
  ];
}