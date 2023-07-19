import 'package:crypto_coins_list/router/router.dart';
import 'package:crypto_coins_list/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        // Здесь прописывается обсервер для отслеживания навигации по приложению
        // В данном случае обсервер - инстанс логгера Talker
        TalkerRouteObserver(GetIt.I<Talker>())
      ],
      title: 'Crypto currency list',
      theme: darkTheme,
      // Навигация в приложении
      routes: routes,
      // home: const CryptoListScreen(title: 'Crypto currency list'),
      // Использовать, если нет поля routes
    );
  }
}