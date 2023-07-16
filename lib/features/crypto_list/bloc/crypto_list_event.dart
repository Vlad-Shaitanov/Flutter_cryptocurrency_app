part of 'crypto_list_bloc.dart';// Файл является честью указанного файла

class CryptoListEvent {}

class LoadCryptoList extends CryptoListEvent {
  LoadCryptoList({
    this.completer
});
  final Completer? completer;
}