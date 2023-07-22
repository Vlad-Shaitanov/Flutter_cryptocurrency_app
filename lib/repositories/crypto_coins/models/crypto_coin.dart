// Модель
import 'package:crypto_coins_list/repositories/crypto_coins/models/crypto_coin_details.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'crypto_coin.g.dart'; // Сгенерированный файл является частью текущего

@HiveType(typeId: 2)  // Нужно, чтобы не было пересечений по typeId на уровне классов и HiveField внутри класса
class CryptoCoin extends Equatable {
  const CryptoCoin({
    required this.name,
    required this.details,
  });

  @HiveField(0) // Поле будет иметь тип name
  final String name;

  @HiveField(1) // Поле будет иметь тип CryptoCoinDetail
  final CryptoCoinDetail details;


  @override
  List<Object?> get props => [name, details];
}
