import 'package:chopperblocpagination/blocs/bloc_eur/bloc.dart';
import 'package:chopperblocpagination/blocs/bloc_eur/coin_eur_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EurPage extends StatefulWidget {
  @override
  _EurPageState createState() => _EurPageState();
}

class _EurPageState extends State<EurPage> {
  CoinEurBloc coinEurBloc;
  @override
  void initState() {
    super.initState();
    coinEurBloc = CoinEurBloc(page: 0, tsym: 'EUR', limit: 50);
    coinEurBloc.add(AppStarted());
  }

  @override
  void dispose() {
    coinEurBloc.close();
    super.dispose();
  }

  @override
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinEurBloc, CoinEurState>(
        bloc: coinEurBloc,
        builder: (context, CoinEurState state) {
          return Container(
            color: Colors.black,
            width: double.infinity,
            child: _buildBody(state),
          );
        });
  }

  _buildBody(CoinEurState state) {
    if (state is LoadingCoinEurState) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme
              .of(context)
              .primaryColor),
        ),
      );
    } else if (state is LoadedCoinEurState) {
      return RefreshIndicator(
        color: Theme
            .of(context)
            .accentColor,
        onRefresh: () async {
          coinEurBloc.add(RefreshCoins());
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) =>
              _onScrollNotification(notification, state),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.coins.length,
            itemBuilder: (BuildContext context, int index) {
              if (index.isOdd) return new Divider(color: Colors
                  .purple); // notice color is added to style divider

              final coin = state.coins[index];
              return ListTile(
                leading: Column(
                  children: <Widget>[
                    Text(
                      '${++index}',
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                title: Text(
                  coin.fullName,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  coin.name,
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: Text(
                  '\$ ${coin.price.toStringAsFixed(4)}',
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .accentColor,
                      fontWeight: FontWeight.w600),
                ),
              );
            },
          ),
        ),
      );
    } else if (state is ErrorCoinEurState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Error loading coins!\nPlease check your connections.',
            style: TextStyle(
              color: Theme
                  .of(context)
                  .accentColor,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
          RaisedButton(
            child: Text('Retry'),
            onPressed:(){
              coinEurBloc.add(RefreshCoins());
            } ,
          ),
        ],

      );
    }
  }

  bool _onScrollNotification(ScrollNotification notif, LoadedCoinEurState state) {
    if (notif is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      coinEurBloc.add(LoadMoreCoins(coins: state.coins));
    }
    return false;
  }
}
