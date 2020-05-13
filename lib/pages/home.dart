import 'package:chopperblocpagination/blocs/bloc.dart';
import 'package:chopperblocpagination/blocs/coin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CoinBloc coinBloc;
  @override
  void initState() {
    super.initState();
    coinBloc = CoinBloc(page: 0, tsym: 'USD', limit: 50);
    coinBloc.add(AppStarted());
  }

  @override
  void dispose() {
    coinBloc.close();
    super.dispose();
  }

  @override
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinBloc, CoinState>(
        bloc: coinBloc,
        builder: (context, CoinState state) {
          return Container(
            color: Colors.black,
            width: double.infinity,
            child: _buildBody(state),
          );
        });
  }

  _buildBody(CoinState state) {
    if (state is LoadingCoinState) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme
              .of(context)
              .primaryColor),
        ),
      );
    } else if (state is LoadedCoinState) {
      return RefreshIndicator(
        color: Theme
            .of(context)
            .accentColor,
        onRefresh: () async {
          coinBloc.add(RefreshCoins());
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
    } else if (state is ErrorCoinState) {
      return Center(
        child: Text(
          'Error loading coins!\nPlease check your connections.',
          style: TextStyle(
            color: Theme
                .of(context)
                .accentColor,
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  bool _onScrollNotification(ScrollNotification notif, LoadedCoinState state) {
    if (notif is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      coinBloc.add(LoadMoreCoins(coins: state.coins));
    }
    return false;
  }
}
