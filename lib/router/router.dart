import 'package:crypto_coins_list/features/crypto_coin/crypto_coin.dart';
import 'package:crypto_coins_list/features/crypto_list/crypto_list.dart';

final routes = {
  "/coin": (context) => const CryptoCoinScreen(),
  "/": (context) => const CryptoListScreen(title: "Crypto currency list"), // Дефолтный роут(главная страница приложения)
};