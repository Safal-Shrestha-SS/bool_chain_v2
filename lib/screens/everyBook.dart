import 'package:bool_chain_v2/screen_body/navigation_sidebar.dart';
import 'package:bool_chain_v2/screens/chat_screen.dart';
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
                              onPressed: () async {
                                var id = '2';
                                // int exist;
                                List<DocumentSnapshot> documentList;
                                documentList = (await _bookStore
                                        .collection('group')
                                        .where('member0', whereIn: [
                                  snapshot.data['bookOwner'],
                                  userUID
                                ]).where('member1', whereIn: [
                                  snapshot.data['bookOwner'],
                                  userUID
                                ]).getDocuments())
                                    .documents;
                                print(userUID);
                                documentList.map((e) => id = e['id']);

                                // await _bookStore
                                //     .collection('group')
                                //     .where('members',
                                //         arrayContains:
                                //             ' ${snapshot.data['bookOwner']}')
                                //     .getDocuments()
                                //     .then((value) async {
                                //   if (value.documents.isNotEmpty) {
                                //     await _bookStore
                                //         .collection('group')
                                //         .where('members',
                                //             arrayContains: '$userUID')
                                //         .getDocuments()
                                //         .then(
                                //           (value) => {
                                //             if (value.documents.isNotEmpty)
                                //               {
                                //                 value.documents
                                //                     .asMap()
                                //                     .forEach((key, value) {
                                //                   id = value.data['id']
                                //                       .toString();
                                //                 })
                                //               }
                                //           },
                                //         );
                                //   }
                                // });
                                if (id == '2') {
                                  await _bookStore.collection('group').add({
                                    'createdAt': FieldValue.serverTimestamp(),
                                    'lastModified':
                                        FieldValue.serverTimestamp(),
                                    'member0':
                                      snapshot.data['bookOwner'],
                                    'member1':  userUID
                                    ],
                                    'recentMessage': [
                                      'Hello!Can we talk about books you uploaded?',
                                      userUID
                                    ],
                                    'sender': userUID
                                  }).then((value) => id = value.documentID);
                                  await _bookStore
                                      .collection('group')
                                      .document(id)
                                      .updateData({'id': id});
                                }
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ChatScreen(
                                      messageId: id,
                                    ),
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
                              },
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
