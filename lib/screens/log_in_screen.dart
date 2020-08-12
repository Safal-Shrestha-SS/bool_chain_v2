import 'package:bool_chain_v2/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'package:bool_chain_v2/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LogInPage extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String email, password;
  bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      dismissible: true,
      inAsyncCall: spinner,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          child: Material(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'lofo',
                    child: Text(
                      'Book_Chain',
                      style: TextStyle(
                          inherit: false,
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 250,
                      decoration: kcontainerDecoration,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                        decoration: kformDecoration.copyWith(
                          errorMaxLines: 1,
                          hintText: "Enter your email",
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      height: 30,
                      width: 250,
                      decoration: kcontainerDecoration,
                      child: TextField(
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                        decoration: kformDecoration.copyWith(
                          errorMaxLines: 1,
                          hintText: "Enter your password",
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30.0),
                    child: Consumer<FirebaseAuthService>(
                        builder: (context, fire, child) {
                      return MaterialButton(
                        onPressed: () async {
                          setState(() {
                            spinner = true;
                          });
                          bool fa = await fire.signIN(
                              email: email, password: password);
                          if (fa == true) {
                            setState(() {
                              spinner = false;
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          } else {
                            setState(() {
                              spinner = false;
                            });
                          }
                        },
                        minWidth: 250.0,
                        height: 25.0,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
