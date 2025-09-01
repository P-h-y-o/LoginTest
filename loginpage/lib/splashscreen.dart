import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loginpage/apiservice.dart';
import 'package:loginpage/homepage.dart';
import 'package:loginpage/loginpage.dart';
import 'package:loginpage/product_model.dart';
import 'package:loginpage/user_model.dart';
import 'package:loginpage/user_singleton.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            Center(
              child: TextButton(
                child: Text('Retry'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _checkLogin();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    UserModel? user;

    final box = Hive.box<UserModel>('userBox');
    user = box.get('currentuser');
    print('user$user');
    if (user != null) {
      CurrentUserSingleton().setUser(user);
      print(user);
      final tokenResponse = await Apiservice.refreshToken(
        user.accessToken,
        user.refreshToken,
      );
      if (tokenResponse['success'] == false) {
        _showErrorDialog('${tokenResponse['message']}');
      } else {
        final saveuser = UserModel(
          id: user.id,
          userName: user.userName,
          email: user.email,
          phoneNumber: user.phoneNumber,
          accessToken: tokenResponse['access_token'],
          refreshToken: tokenResponse['refresh_token'],
        );
        await box.put('currentuser', saveuser);
        await Hive.openBox<Product>('favorite_${saveuser.id}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or App Icon
            Image.asset('assets/images/img5.jpg', height: 120),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
