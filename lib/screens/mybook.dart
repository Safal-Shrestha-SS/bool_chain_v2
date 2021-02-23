import 'package:bool_chain_v2/screen_body/navigation_sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'everyBook.dart';

class MyBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Posted Books"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('books').snapshots(),
          // ignore: missing_return
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              child: ListView(
                children: snapshot.data.documents.map((document) {
                  if (userUID == document["bookOwner"]) {
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
                              colors: [Colors.blue, Colors.lightBlueAccent]),
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
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, _) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document["bookName"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text("Author",
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black)),
                                    Text(document['bookAuthor'],
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.black)),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    FlatButton(
                                      color: Colors.white,
                                      child: Text("Delete"),
                                      onPressed: () async {
                                        await Firestore.instance
                                            .collection('books')
                                            .document('${document.documentID}')
                                            .delete();
                                      },
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
      ),
    );
  }
}
