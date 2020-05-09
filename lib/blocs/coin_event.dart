import 'package:chopperblocpagination/models/coin_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CoinEvent {}

class AppStarted extends CoinEvent {}

class RefreshCoins extends CoinEvent {
}

class LoadMoreCoins extends CoinEvent {
  final List<Coin> coins;

  LoadMoreCoins({@required this.coins});
}
