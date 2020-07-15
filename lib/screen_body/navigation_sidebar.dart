import 'package:bool_chain_v2/screens/log_in_screen.dart';
import 'package:bool_chain_v2/screens/my_books.dart';
import 'package:bool_chain_v2/screens/upload_book.dart';
import 'package:bool_chain_v2/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

var ktextStyle = TextStyle(
  fontSize: 20,
);

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Color(0xf1cf7500),
      child: Padding(
          padding: EdgeInsets.zero,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10.0),
                Text(
                  'BookChain',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 10.0),
                CircleAvatar(
                  radius: 35,
                ),
                Text('Okarin'),
                Divider(
                  color: Colors.white38,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyBooks()));
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.book),
                        SizedBox(width: 7),
                        Text('My Books', style: ktextStyle),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadBook()));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.cloud_upload),
                        SizedBox(width: 7),
                        Text('Upload Book', style: ktextStyle),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.notifications),
                      SizedBox(width: 7),
                      Text('Notification', style: ktextStyle),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.bookmark),
                      SizedBox(width: 7),
                      Text('Wishlist', style: ktextStyle),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.settings_applications),
                      SizedBox(width: 7),
                      Text('Setting', style: ktextStyle),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  child: Row(
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(width: 7),
                      Text('Account', style: ktextStyle),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Consumer<FirebaseAuthService>(
                  builder: (context, fire, child) {
                    return GestureDetector(
                      onTap: () {
                        fire.signOut();

                        Navigator.of(context).pushNamedAndRemoveUntil(
                            LogInPage.id, (Route<dynamic> route) => false);
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.all_out,
                            ),
                            SizedBox(width: 7),
                            Text('Log Out', style: ktextStyle),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 7),
                GestureDetector(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.close),
                        SizedBox(width: 7),
                        Text('Exit Book_Chain', style: ktextStyle),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  child: Text('Help & feedback',
                      style: ktextStyle, textAlign: TextAlign.start),
                ),
                SizedBox(height: 7),
                Container(
                  child: Text(
                    'Abount BookChain',
                    style: ktextStyle,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
