import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coin_model.g.dart';

@JsonSerializable(nullable: false)
class Coin  {
  final String name;
  final String fullName;
  final double price;

  const Coin(
      {@required this.name, @required this.fullName, @required this.price});

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
