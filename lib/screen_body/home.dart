import 'package:bool_chain_v2/screen_body/book_info.dart';
import 'package:flutter/material.dart';
import 'package:bool_chain_v2/data/books.dart';
//import 'package:bool_chain_v2/screen_body/book_info.dart';
// import 'package:bool_chain_v2/screens/home_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250.0,
            mainAxisSpacing: 7.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 0.85,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: (index % 2 == 0)
                    ? EdgeInsets.fromLTRB(20, 5, 0, 0)
                    : EdgeInsets.fromLTRB(0, 5, 20, 0),
                child: Column(
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            // BuildContext context,
                            MaterialPageRoute(
                              builder: (context) => BookInfo(index: index),
                            ),
                          ); // widget.selectedIndex = 5;
                        },
                        child: Hero(
                          tag: index,
                          child: Container(
                            height: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/test.jpg'),
                                  fit: BoxFit.scaleDown),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.teal[100 * (1 % 9)],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      books[index],
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ],
                ),
              );
            },
            childCount: books.length,
          ),
        ),
      ],
    );
  }
}
