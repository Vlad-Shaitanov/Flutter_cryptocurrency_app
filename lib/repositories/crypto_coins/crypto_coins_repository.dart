import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  CryptoCoinsRepository({
    required this.dio,
    required this.cryptoCoinsBox,
  });

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {

    var dataList = <CryptoCoin>[];

    try {
      dataList = await _fetchCoinsListFromApi();
      final cryptoCoinsMap = {for (var e in dataList) e.name: e}; // К каждому имени криптовалюты будет привязано значение

      debugPrint(dataList.toString());
      cryptoCoinsBox.putAll(cryptoCoinsMap); // Каждый раз будут записываться данные. Если такие значения и ключи уже есть, то данные обновятся
    }catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      dataList = cryptoCoinsBox.values.toList(); // Если данные не подгрузились, вернем данные из кэша(базы)
    }

    dataList.sort((a, b) => b.details.priceInUSD.compareTo(a.details.priceInUSD));
    return dataList;
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ADA,XRP,ETH,DOGE,AAVE,UNI,DOT,YFI,MKR,LINK,COMP,LUNA,BNB,AVAX&tsyms=USD,EUR");
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data["RAW"] as Map<String, dynamic>;

    final dataList = dataRaw.entries.map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'];
      final details = CryptoCoinDetail.fromJson(usdData);

      return CryptoCoin(
        name: e.key,
        details: details
      );
    }).toList();
    return dataList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(currencyCode);
      // Если все ок, записываем  в базу обновленное значение для этой валюты
      cryptoCoinsBox.put(currencyCode, coin);

      return coin;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);

      // Достаем из базы значение одной валюты, если оно есть
      return cryptoCoinsBox.get(currencyCode)!;
    }
  }

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetail.fromJson(usdData);

    return CryptoCoin(
      name: currencyCode,
      details: details
    );
  }
}
