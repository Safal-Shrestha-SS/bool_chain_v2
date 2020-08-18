import 'package:flutter/material.dart';
import 'package:bool_chain_v2/screen_body/top_app_bar.dart';
import 'package:bool_chain_v2/screen_body/navigation_sidebar.dart';
import 'package:bool_chain_v2/screen_body/home.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(child: Navigation()),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              TopAppBar1(),
            ];
          },
          body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
            Container(
              color: Colors.red,
              child: ListView.builder(
                itemExtent: 250.0,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(5.0),
                    color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
                    child: Center(
                      child: Text(index.toString()),
                    ),
                  ),
                ),
              ),
            ),
            Home(),
          ]),
        ),
      ),
    );
  }
}
