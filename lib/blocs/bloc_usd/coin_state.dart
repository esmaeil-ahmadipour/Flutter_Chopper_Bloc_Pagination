import 'package:chopperblocpagination/models/coin_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CoinState {}

class InitialCoinState extends CoinState {}
class LoadingCoinState extends CoinState{}
class LoadedCoinState extends CoinState{
  final List<Coin> coins;

   LoadedCoinState({this.coins});

}
class ErrorCoinState extends CoinState{
final String error;

ErrorCoinState({this.error});


}
