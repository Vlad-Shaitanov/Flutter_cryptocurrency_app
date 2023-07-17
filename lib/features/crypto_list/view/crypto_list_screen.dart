import 'dart:async';
import 'dart:developer';
import 'package:crypto_coins_list/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';
import 'package:crypto_coins_list/features/crypto_list/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());// Создали инстанс блока

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());// Передаем ивент
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator(
        /*Виджет обновления приложения. Тянем страницу вниз и
        срабатывает метод на обновление инфы
        */
        onRefresh: () async {
          // Индикатор будет показываться до тех пор, пока запрос не выполнится
          final completer = Completer();// Позволяет отследить, завершен ли асинхронный запрос
          _cryptoListBloc.add(LoadCryptoList(completer: completer));// Передаем ивент
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,// Сообщаем билдеру по какому блоку билдить виджет
          builder: (context, state) {
            if(state is CryptoListLoaded){
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.coinsList!.length, // Сколько будет элементов в списке
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];

                  return CryptoCoinTile(coin: coin);
                },
              );
            }
            if(state is CryptoListLoadingFailure){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      'Please, try again later',
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      /* Если возникла ошибка при загрузке списка валют,
                      то нажимаем кнопку и  запрос отправляется снова
                      */
                      onPressed: (){
                        _cryptoListBloc.add(LoadCryptoList());
                      },
                      child: const Text("Try again"),
                    )
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator()); // Если данных нет, выводим лоадер,
          },
        ),
      )
    );
  }
}
