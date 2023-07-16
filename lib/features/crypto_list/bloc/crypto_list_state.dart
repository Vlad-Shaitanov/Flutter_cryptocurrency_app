part of 'crypto_list_bloc.dart'; // Файл является честью указанного файла

abstract class CryptoListState extends Equatable {}

/* Для тек стейтов, у которых нет полей, можно возвращать пропсы пустым списком*/
class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  CryptoListLoaded({
    required this.coinsList
  });

  final List<CryptoCoin> coinsList;

  @override
  List<Object?> get props => [coinsList];
}

class CryptoListLoadingFailure extends CryptoListState {
  CryptoListLoadingFailure({this.exception});// Конструктор

  final Object? exception;

  @override
  List<Object?> get props => [exception];

}