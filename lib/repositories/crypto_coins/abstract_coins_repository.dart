import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin.dart';


/*В Dart нет интерфейсов, поэтому в нем используется альтернаятива
в виде абстрактных классов */




abstract class AbstractCoinsRepository {
  // Здесь мы будем описывать какие методы есть у крипторепозитория
  // Что принимают методы и что возвращают

  Future<List<CryptoCoin>> getCoinsList();
}