import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/log_in_screen.dart';
import 'screens/initial_loading_screen.dart';
import 'services/firebase_auth_service.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
  timeDilation = 0.00050;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //timeDilation = 6;

    return ChangeNotifierProvider<FirebaseAuthService>(
      create: (context) => FirebaseAuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Color(0xffc7a4e5),
          textTheme: TextTheme(
            // bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black54),
          ),
        ),
        initialRoute: InitialLoadingScreen.id, //HomeScreen(selected: 0),
        routes: {
          InitialLoadingScreen.id: (context) => InitialLoadingScreen(),
          LogInPage.id: (context) => LogInPage(),
          HomeScreen.id: (context) => HomeScreen(),
        },
      ),
    );
  }
}
