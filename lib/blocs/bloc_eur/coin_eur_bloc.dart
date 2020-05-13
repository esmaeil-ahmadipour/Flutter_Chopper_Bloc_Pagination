import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:chopperblocpagination/models/coin_model_eur.dart';
import 'package:chopperblocpagination/services/api_services.dart';
import './bloc.dart';

class CoinBloc extends Bloc<CoinEurEvent, CoinEurState> {
  final int limit;
  final String tsym;
  final int page;
  List<CoinEur> coins = [];

  CoinBloc({this.limit, this.tsym, this.page});

  @override
  CoinEurState get initialState => InitialCoinEurState();

  @override
  Stream<CoinEurState> mapEventToState(
      CoinEurEvent event,
      ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is RefreshCoins) {
      yield* _getCoins(coins: []);
    } else if (event is LoadMoreCoins) {
      yield* _mapLoadMoreCoinsState(event);
    }
  }

  Stream<CoinEurState> _getCoins({List<CoinEur> coins, int page}) async* {
    try {
      List<CoinEur> newCoinList = coins + await getTopCoins(page: page);
      yield LoadedCoinEurState(coins: newCoinList);
    } catch (error) {
      yield ErrorCoinEurState();
    }
  }

  Stream<CoinEurState> _mapAppStartedToState() async* {
    print("Status : AppStarted /  _mapAppStartedToState");
    yield LoadingCoinEurState();
    yield* _getCoins(coins: []);
  }

  Stream<CoinEurState> _mapLoadMoreCoinsState(LoadMoreCoins event) async* {
    final int nextPage = event.coins.length ~/ limit;
    yield* _getCoins(coins: event.coins, page: nextPage);
  }

  Future<List<CoinEur>> getTopCoins({int page}) async {
    List<CoinEur> coins = [];
    try {
      final Response response =
      await ApiService.create().getResult(limit, tsym, page);

      print("Status Code Recieved :  ${response.statusCode}");
      print("Status Body : ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> data =response.body;
        List<dynamic> coinList = data['Data'];
        coinList.forEach(
              (json) => coins.add(CoinEur.fromJson(json)),
        );
      }
      return coins;
    } catch (error) {
      throw error;
    }
  }
}
