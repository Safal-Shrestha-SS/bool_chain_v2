import 'package:flutter/material.dart';
import 'package:bool_chain_v2/data/books.dart';

class TopAppBar1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 1.0,
      pinned: true,
      floating: true,
      snap: true,
      title: Row(
        children: <Widget>[
          Text(
            'Book_Chain',
            style: TextStyle(fontSize: 20.0),
          ),
          Flexible(child: SizedBox(width: double.infinity)),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Add new entry',
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
          ),
          IconButton(
            icon: Icon(Icons.portrait),
            tooltip: 'Add new entry',
            onPressed: () {/* ... */},
          ),
        ],
      ),
      bottom: TabBar(
        tabs: <Widget>[
          Tab(text: "home"),
          Tab(
            text: "back",
          )
        ],
      ),
    );
  }
}

class TopAppBar2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 1.0,
      pinned: false,
      floating: true,
      snap: false,
      title: Row(
        children: <Widget>[
          Text(
            'Book_Chain',
            style: TextStyle(fontSize: 20.0),
          ),
          Flexible(child: SizedBox(width: double.infinity)),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Add new entry',
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
          ),
          IconButton(
            icon: Icon(Icons.portrait),
            tooltip: 'Add new entry',
            onPressed: () {/* ... */},
          ),
        ],
      ),
    );
  }
}

//Search Operations Below

class Search extends SearchDelegate<String> {
  final history = ['Nepal', 'India', 'Corona', 'PaniPuri'];
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  //to display after search text
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  //to display before search
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  //to do after search is done
  Widget buildResults(BuildContext context) {
    return Container(
      height: 100,
      child: Card(color: Colors.red, child: Text(query)),
    );
  }

  @override
  //to provide suggestion for faster search
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? history
        : books
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
          showResults(context);
        },
        leading: Icon(Icons.book),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
