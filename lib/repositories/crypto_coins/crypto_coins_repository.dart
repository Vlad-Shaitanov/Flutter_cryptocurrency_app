import 'package:crypto_coins_list/repositories/models/crypto_coin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

final dio = Dio();

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {

    final response = await dio.get("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ADA,XRP,ETH,DOGE,AAVE,UNI,DOT,YFI,MKR,LINK,COMP,LUNA,BNB,AVAX&tsyms=USD,EUR");
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data["RAW"] as Map<String, dynamic>;

    final dataList = dataRaw.entries.map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'];
      final price = usdData["PRICE"];
      final imageUrl = usdData["IMAGEURL"];
      return CryptoCoin(
          name: e.key,
          priceInUSD: price,
          imageUrl: 'https://cryptocompare.com/$imageUrl',
      );
    }).toList();

    debugPrint(dataList.toString());
    return dataList;
  }
}


