import 'package:flutter/material.dart';
import 'package:bool_chain_v2/screen_body/navigation_sidebar.dart';

class MyBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          drawer: Drawer(
            child: Navigation(),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 1.0,
                pinned: true,
                floating: true,
                snap: true,
                title: Text('My Books'),
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(text: "My uploads"),
                    Tab(
                      text: "History",
                    ),
                    Tab(
                      text: "Review",
                    )
                  ],
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(children: [
                  Container(
                    color: Colors.red,
                    child: ListView.builder(
                      itemExtent: 250.0,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(10.0),
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(5.0),
                          color:
                              index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
                          child: Center(
                            child: Text(index.toString()),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blueGrey,
                    child: ListView.builder(
                      itemExtent: 250.0,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(10.0),
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(5.0),
                          color:
                              index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
                          child: Center(
                            child: Text(index.toString()),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    child: ListView.builder(
                      itemExtent: 250.0,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.all(10.0),
                        child: Material(
                          elevation: 4.0,
                          borderRadius: BorderRadius.circular(5.0),
                          color:
                              index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
                          child: Center(
                            child: Text(index.toString()),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              )
            ],
          )),
    );
  }
}
