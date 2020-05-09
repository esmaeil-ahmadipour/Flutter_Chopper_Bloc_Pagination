import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:chopperblocpagination/models/coin_model.dart';
import 'package:chopperblocpagination/services/api_services.dart';
import './bloc.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final int limit;
  final String tsym;
  final int page;
  List<Coin> coins = [];

  CoinBloc({this.limit, this.tsym, this.page});

  @override
  CoinState get initialState => InitialCoinState();

  @override
  Stream<CoinState> mapEventToState(
    CoinEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is RefreshCoins) {
      yield* _getCoins(coins: []);
    } else if (event is LoadMoreCoins) {
      yield* _mapLoadMoreCoinsState(event);
    }
  }

  Stream<CoinState> _getCoins({List<Coin> coins, int page}) async* {
    try {
      List<Coin> newCoinList = coins + await getTopCoins(page: page);
      yield LoadedCoinState(coins: newCoinList);
    } catch (error) {
      yield ErrorCoinState();
    }
  }

  Stream<CoinState> _mapAppStartedToState() async* {
    print("Status : AppStarted /  _mapAppStartedToState");
    yield LoadingCoinState();
    yield* _getCoins(coins: []);
  }

  Stream<CoinState> _mapLoadMoreCoinsState(LoadMoreCoins event) async* {
    final int nextPage = event.coins.length ~/ limit;
    yield* _getCoins(coins: event.coins, page: nextPage);
  }

  Future<List<Coin>> getTopCoins({int page}) async {
    List<Coin> coins = [];
    try {
      final Response response =
          await ApiService.create().getResult(limit, tsym, page);

      print("Status Code Recieved :  ${response.statusCode}");
      print("Status Body : ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> data =response.body;
        List<dynamic> coinList = data['Data'];
        coinList.forEach(
              (json) => coins.add(Coin.fromJson(json)),
        );
      }
      return coins;
    } catch (error) {
      throw error;
    }
  }
}
