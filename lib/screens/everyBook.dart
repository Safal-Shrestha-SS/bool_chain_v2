import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

var _bookStore = Firestore.instance;

class EverybookInfo extends StatelessWidget {
  final String bookId;
  EverybookInfo(this.bookId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _bookStore.collection("books").document(bookId).snapshots(),
        builder: (BuildContext context, snapshot) {
          final Timestamp timestamp = snapshot.data['time'] as Timestamp;
          final DateTime dateTime = timestamp.toDate();
          final date = [dateTime.day, dateTime.month, dateTime.year];
          return SingleChildScrollView(
              child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(snapshot.data["image"]),
                        fit: BoxFit.scaleDown),
                    color: Colors.teal[100 * (1 % 9)],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              children: [
                                Text("Posted on : "),
                                Text(date[2].toString() +
                                    " / " +
                                    date[1].toString() +
                                    " / " +
                                    date[0].toString())
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FlatButton(
                              color: Colors.blue,
                              child: Text(
                                "Talk",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.book),
                            title: Text('Book Name'),
                            subtitle: Text("${snapshot.data['bookName']}"),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.book),
                            title: Text('Book Description'),
                            subtitle:
                                Text("${snapshot.data['bookDescription']}"),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Book Author'),
                            subtitle: Text("${snapshot.data['bookAuthor']}"),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Text(
                            "Rating",
                            style: TextStyle(fontSize: 25),
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: snapshot.data['bookRating'],
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 25,
                            itemBuilder: (context, snapshot) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (double value) {
                              print(value);
                            },
                          ),
                          Text(
                            snapshot.data["bookRating"].toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
