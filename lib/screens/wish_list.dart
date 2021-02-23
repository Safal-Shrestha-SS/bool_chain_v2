import 'package:bool_chain_v2/screen_body/navigation_sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'everyBook.dart';

class WishList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Wished Books"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(userUID)
              .snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
            final list = snapshots.data['wishList'].toList();
            return Container(
              child: StreamBuilder(
                stream: Firestore.instance.collection('books').snapshots(),
                // ignore: missing_return
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    child: ListView(
                      children: snapshot.data.documents.map((document) {
                        if (list.contains(document.documentID)) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(35.0),
                                  bottomRight: Radius.circular(35.0)),
                            ),
                            elevation: 8.0,
                            margin: new EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.blue,
                                      Colors.lightBlueAccent
                                    ]),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(35.0),
                                    bottomRight: Radius.circular(35.0)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FlatButton(
                                        child: Image.network(document['image']),
                                        onPressed: () {
                                          var bookId = document.documentID;
                                          Navigator.of(context).push(
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  EverybookInfo(bookId),
                                              transitionDuration:
                                                  Duration(milliseconds: 500),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  _) {
                                                return ScaleTransition(
                                                  scale: animation,
                                                  alignment: Alignment.center,
                                                  child: _,
                                                );
                                              },
                                            ),
                                          );
                                        }),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(7.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            document["bookName"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text("Author",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black)),
                                          Text(document['bookAuthor'],
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black)),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Center(
                                            child: Tooltip(
                                              message:
                                                  'Click if you have received the book',
                                              child: FlatButton(
                                                color: Colors.white,
                                                child: Text(
                                                  "Book Received",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                onPressed: () async {},
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Tooltip(
                                              message:
                                                  'Click if you want to cancel the book',
                                              child: FlatButton(
                                                color: Colors.white,
                                                child: Text(
                                                  "Book Cancelled",
                                                  style:
                                                      TextStyle(fontSize: 11),
                                                ),
                                                onPressed: () async {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        } else
                          return Center();
                      }).toList(),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
