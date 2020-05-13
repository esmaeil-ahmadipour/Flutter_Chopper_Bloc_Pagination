import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coin_model_eur.g.dart';

@JsonSerializable(nullable: false)
class CoinEur  {
  final String name;
  final String fullName;
  final double price;

  const CoinEur(
      {@required this.name, @required this.fullName, @required this.price});

  factory CoinEur.fromJson(Map<String, dynamic> json) => _$CoinEurFromJson(json);

  Map<String, dynamic> toJson() => _$CoinEurToJson(this);
}
