import 'package:chopperblocpagination/pages/home.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  
  @override  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "USD", icon: Icon(Icons.flag)),
                Tab(text: "EUR",icon: Icon(Icons.outlined_flag)),
              ],
              indicatorColor:Colors.black,
               indicatorWeight:5.0,
               isScrollable :false,
            ),
            title: Text(
              "Online Pagination", style: TextStyle(color: Colors.purple),),           // backgroundColor: Colors.red,
           ),
          body: TabBarView(
            children: [
              HomePage(),
              HomePage(),
            ],
          ),
        ),
    );
  }
}
