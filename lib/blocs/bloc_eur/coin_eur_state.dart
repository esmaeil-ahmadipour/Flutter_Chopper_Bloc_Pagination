
import 'package:chopperblocpagination/models/coin_model_eur.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CoinEurState {}

class InitialCoinEurState extends CoinEurState {}
class LoadingCoinEurState extends CoinEurState{}
class LoadedCoinEurState extends CoinEurState{
  final List<CoinEur> coins;

  LoadedCoinEurState({this.coins});

}
class ErrorCoinEurState extends CoinEurState{
  final String error;

  ErrorCoinEurState({this.error});


}


