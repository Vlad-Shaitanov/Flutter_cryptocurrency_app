part of 'crypto_list_bloc.dart'; // Файл является честью указанного файла

class CryptoListState {}

class CryptoListInitial extends CryptoListState {}

class CryptoListLoading extends CryptoListState {}

class CryptoListLoaded extends CryptoListState {
  CryptoListLoaded({
    required this.coinsList
  });

  final List<CryptoCoin> coinsList;
}

class CryptoListLoadingFailure extends CryptoListState {
  CryptoListLoadingFailure({this.exception});// Конструктор

  final Object? exception;

}