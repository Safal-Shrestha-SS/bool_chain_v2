import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bool_chain_v2/screens/forgot_password.dart';
import 'package:bool_chain_v2/screens/sign_up.dart';
import 'package:bool_chain_v2/services/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';
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
  String _error;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      dismissible: true,
      inAsyncCall: spinner,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).primaryColor,
              Colors.transparent
            ])),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
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
                  SizedBox(
                    height: 24.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 35,
                        width: 250,
                        decoration: kcontainerDecoration,
                        child: Center(
                          child: TextField(
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                            decoration: kformDecoration.copyWith(
                              hintText: "Enter your email",
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Container(
                        height: 35,
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
                      ),
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
                            try {
                              await fire.signIn(email, password);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            } catch (e) {
                              setState(() {
                                _error = e.message;
                                print('hello error');
                                spinner = false;
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Error: $_error"),
                                  action: SnackBarAction(
                                    label: 'OK',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                ));
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          child: Text("Forgot password?"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          }),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        child: Text("Sign Up"),
                        onTap: () {
                          print('nsasdfghjk');
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RotateAnimatedTextKit(
                        text: ["READ  ", "SHARE", "ENJOY"],
                        textStyle:
                            TextStyle(fontSize: 20.0, fontFamily: "Horizon"),
                        textAlign: TextAlign.start,
                        alignment: Alignment.center,
                        repeatForever: true,
                      ),
                      SizedBox(width: 10),
                      Text('Book')
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
