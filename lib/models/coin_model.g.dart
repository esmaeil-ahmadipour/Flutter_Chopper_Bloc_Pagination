// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) {
  return Coin (
    name: json['CoinInfo']['Name'] as String,
    fullName: json['CoinInfo']['FullName'] as String,
    price:( json['RAW']['USD']['PRICE'] as num).toDouble()  ,
  );
}

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'name': instance.name,
      'fullName': instance.fullName,
      'price': instance.price,
    };
