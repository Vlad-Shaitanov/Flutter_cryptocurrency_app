import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_coin_details.g.dart'; // Сгенерированный файл и часть основной модели

@HiveType(typeId: 1)
@JsonSerializable() // Аннотация сообщает, что для класса надо сгенерировать DTO
class CryptoCoinDetail extends Equatable {
  const CryptoCoinDetail({
    required this.priceInUSD,
    required this.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.hight24Hour,
    required this.low24Hours,
  });

  @HiveField(0) // Аннотация для hive, означающая поле
  @JsonKey(name: 'TOSYMBOL') // Переименование поля при генерации DTO
  final String toSymbol;

  @HiveField(1)
  @JsonKey(name: 'LASTUPDATE', toJson: _dateTimeToJson, fromJson: _dateTimeFromJson) // Пример кастомной (де)сереализации, когда поле конвертируется в неподходящий формат и нужно это исправить
  final DateTime lastUpdate;

  @HiveField(2)
  @JsonKey(name: 'HIGH24HOUR')
  final double hight24Hour;

  @HiveField(3)
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hours;

  @HiveField(4)
  @JsonKey(name: 'PRICE')
  final double priceInUSD;

  @HiveField(5)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  String get fullImageUrl => 'https://www.cryptocompare.com/$imageUrl';// Получение полного пути для картинок, чтобы не было краша

  /// Connect the generated [_$CryptoCoinDetailFromJson] function to the `fromJson`
  /// factory.
  factory CryptoCoinDetail.fromJson(Map<String, dynamic> json) => _$CryptoCoinDetailFromJson(json);

  /// Connect the generated [_$CryptoCoinDetailToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CryptoCoinDetailToJson(this);


  static int _dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;
  static DateTime _dateTimeFromJson(int milliseconds) => DateTime.fromMillisecondsSinceEpoch(milliseconds);

  @override
  List<Object?> get props => [
    toSymbol,
    lastUpdate,
    hight24Hour,
    low24Hours,
    priceInUSD,
    imageUrl
  ];
}