// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_model_eur.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinEur _$CoinEurFromJson(Map<String, dynamic> json) {
  return CoinEur(
    name: json['CoinInfo']['Name'] as String,
    fullName: json['CoinInfo']['FullName'] as String,
    price:( json['RAW']['EUR']['PRICE'] as num).toDouble()  ,
  );
}

Map<String, dynamic> _$CoinEurToJson(CoinEur instance) => <String, dynamic>{
      'name': instance.name,
      'fullName': instance.fullName,
      'price': instance.price,
    };
