import 'package:flutter/material.dart';
import 'package:app_alianzademo/pages/HomePage.dart';
import 'package:app_alianzademo/pages/InitPage.dart';
import 'package:app_alianzademo/database/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Future<bool> isLogin() async {
    var users = await user.isUserEmpty();
    if (users) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
        future: isLogin(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return HomePage();
          } else {
            return InitPage();
          }
        });
  }
}
