import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        // Here we take the value from the CryptoListScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: const Icon(Icons.arrow_back, color: Colors.white,),
      ),
      body: ListView.separated(

        itemCount: 15, // Сколько будет элементов в списке
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context , i) {
          const coinName = "Bitcoin";

          return const CryptoCoinTile(coinName: coinName);
        },
      ),
    );
  }
}
