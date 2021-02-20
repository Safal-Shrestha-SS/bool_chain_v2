import 'package:bool_chain_v2/screens/log_in_screen.dart';
import 'package:bool_chain_v2/screens/mybook.dart';
import 'package:bool_chain_v2/screens/upload_book.dart';
import 'package:bool_chain_v2/services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bool_chain_v2/screen_body/userInformation.dart';
import 'aboutBookShare.dart';

var userUID;
String userName;
final _firestore = Firestore.instance;

class Navigation extends StatelessWidget {
  final FirebaseAuthService _auth = FirebaseAuthService();

  Future getdocumentId() async {
    var user = (await _auth.getCurrentUser());
    userUID = user.uid;
    var af = await _firestore.collection('users').document(user.uid).get();
    print(user.email);
    var afa = af.data['userName'];
    userName = afa;
    print(afa);

    return afa;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  Text(
                    "Book Share",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  CircleAvatar(
                    child: Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.blue,
                    ),
                    radius: 30,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: getdocumentId(),
                      builder: (context, snapshot) {
                        return Text('$userName');
                      }),
                ],
              )),
          ListTile(
            leading: Icon(
              Icons.file_upload,
              color: Colors.black,
            ),
            title: Text(
              "Upload Book",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    UploadBook(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, _) {
                  return ScaleTransition(
                    scale: animation,
                    alignment: Alignment.center,
                    child: _,
                  );
                },
              ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            title: Text(
              "User Information",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserInformation(userUID)),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.content_copy,
              color: Colors.black,
            ),
            title: Text(
              "About BookShare",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AboutApp(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, _) {
                  return ScaleTransition(
                    scale: animation,
                    alignment: Alignment.center,
                    child: _,
                  );
                },
              ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.attach_file,
              color: Colors.black,
            ),
            title: Text(
              "About Us",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.speaker_group,
              color: Colors.black,
            ),
            title: Text(
              "Contact",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.book,
              color: Colors.black,
            ),
            title: Text(
              "My Books",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MyBook(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, _) {
                  return ScaleTransition(
                    scale: animation,
                    alignment: Alignment.center,
                    child: _,
                  );
                },
              ));
            },
          ),
          Consumer<FirebaseAuthService>(
            builder: (context, fire, child) {
              return GestureDetector(
                onTap: () async {
                  fire.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LogInPage.id, (Route<dynamic> route) => false);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 15, top: 13),
                  child: Row(
                    children: [
                      Icon(
                        Icons.cancel,
                      ),
                      SizedBox(width: 34),
                      Text(
                        'Log Out',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 17),
          GestureDetector(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Container(
              padding: EdgeInsets.only(top: 13),
              child: Row(
                children: [
                  SizedBox(width: 15),
                  Icon(Icons.close),
                  SizedBox(width: 34),
                  Text('Exit Book Share',
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
