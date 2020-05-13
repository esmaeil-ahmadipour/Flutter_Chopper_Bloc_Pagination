import 'package:chopperblocpagination/models/coin_model_eur.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CoinEurEvent {}

class AppStarted extends CoinEurEvent {}

class RefreshCoins extends CoinEurEvent {
}

class LoadMoreCoins extends CoinEurEvent {
  final List<CoinEur> coins;

  LoadMoreCoins({@required this.coins});
}
