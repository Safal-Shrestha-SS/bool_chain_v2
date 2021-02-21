import 'package:bool_chain_v2/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var uid;

  @override
  Widget build(BuildContext context) {
    var a = Provider.of<FirebaseAuthService>(context);
    (a.getCurrentUser()).then((value) => {uid = value.uid});
    return Scaffold(body: Container());
  }
}
