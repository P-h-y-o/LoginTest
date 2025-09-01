import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loginpage/homepage.dart';
import 'package:loginpage/loginpage.dart';
import 'package:loginpage/product_model.dart';
import 'package:loginpage/signuppage.dart';
import 'package:loginpage/splashscreen.dart';
import 'package:loginpage/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('userBox');
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('favorites');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashScreen(),
        '/home': (context) => Home(),
        '/signuppage': (context) => Signuppage(),
        '/login': (context) => Loginpage(),
        //   '/homescreen': (context) => HomeScreen(),
      },
    );
  }
}
