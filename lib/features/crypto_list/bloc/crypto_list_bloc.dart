import 'dart:async';

import 'package:crypto_coins_list/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Файлы-части, текущего файла
part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository): super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try{
        if(state is! CryptoListLoaded){
          // Если на экране нет загруженного списка с криптовалютами, то вернем стейт загрузки
          emit(CryptoListLoading());
        }
        final coinsList = await coinsRepository.getCoinsList();// Получили список криптовалют
        emit(CryptoListLoaded(coinsList: coinsList));// Возвращаем значение в стейт
      }catch (e){
        emit(CryptoListLoadingFailure(exception: e));
      }finally{
        event.completer?.complete();
      }
    });
  }

  final AbstractCoinsRepository coinsRepository;
}