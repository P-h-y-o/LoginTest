import 'package:flutter/material.dart';
import 'package:loginpage/loginpage.dart';
import 'package:loginpage/signuppage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("sdf");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (context) => Signuppage(),
        '/login': (context) => Loginpage(),
      },
    );
  }
}
