import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_alianzademo/pages/HomePage.dart';
import 'package:app_alianzademo/pages/InitPage.dart';
import 'package:app_alianzademo/pages/AuthPage.dart';
import 'package:app_alianzademo/pages/LoginPage.dart';
import 'package:app_alianzademo/pages/RegisterPage.dart';

import 'package:app_alianzademo/services/auth.dart';
import 'package:app_alianzademo/services/notifications.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Auth())],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'auth',
      routes: {
        'auth': (_) => AuthPage(),
        'home': (_) => HomePage(),
        'init': (_) => InitPage(),
        'login': (_) => LoginPage(),
        'register': (_) => RegisterPage(),
      },
      scaffoldMessengerKey: Notifications.messengerKey,
    );
  }
}
