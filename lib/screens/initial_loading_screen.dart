import 'package:bool_chain_v2/screens/home_screen.dart';
import 'package:bool_chain_v2/screens/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitialLoadingScreen extends StatefulWidget {
  static const String id = 'initial_loading_screen';
  @override
  _InitialLoadingScreenState createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  Future<bool> isLoggedIN() async {
    if (await FirebaseAuth.instance.currentUser() != null)
      return true;
    else
      return false;
  }

  bool check;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 4;
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 500),
            tween: Tween<double>(begin: 0, end: 1),
            curve: Curves.bounceOut,
            builder: (context, value, child) {
              return Center(
                child: Hero(
                  tag: 'lofo',
                  child: Text(
                    'Book_Chain',
                    style: TextStyle(
                        inherit: false,
                        fontSize: 30 * value,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
            onEnd: () async {
              check = await isLoggedIN();
              if (check) {
                print('logged in');
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      HomeScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, _) {
                    return ScaleTransition(
                      scale: animation,
                      alignment: Alignment.center,
                      child: _,
                    );
                  },
                ));
              } else {
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      LogInPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, _) {
                    return ScaleTransition(
                      scale: animation,
                      alignment: Alignment.center,
                      child: _,
                    );
                  },
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
