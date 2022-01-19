import 'package:flutter/material.dart';
import 'package:pactindo_task_ui/confirm_mpin.dart';
import 'package:pactindo_task_ui/database/db_user.dart';
import 'package:pactindo_task_ui/password.dart';
import 'package:pactindo_task_ui/phone.dart';
import 'package:pactindo_task_ui/resi.dart';
import 'package:pactindo_task_ui/splash.dart';
import 'package:pactindo_task_ui/username.dart';

import 'email.dart';
import 'eula.dart';
import 'home.dart';
import 'ktp.dart';
import 'login.dart';
import 'mpin.dart';
import 'otp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(home: Splash());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.

              primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (context, value, g) {
        return MaterialApp(
          title: title,
          initialRoute: '/eula',
          debugShowCheckedModeBanner: false,
          routes: {
            '/home': (ctx) => HomePage(),
            '/eula': (ctx) => EulaPage(),
            '/ktp': (ctx) => KtpPage(),
            '/email': (ctx) => EmailPage(),
            '/phone': (ctx) => PhoneNumberPage(),
            '/otp': (ctx) => OtpPage(),
            '/username': (ctx) => UsernamePage(),
            '/password': (ctx) => PasswordPage(),
            '/mpin': (ctx) => MpinPage(),
            '/confirm_mpin': (ctx) => ConfirmMpinPage(),
            '/resi': (ctx) => ResiPage(),
            '/login': (ctx) => LoginPage(),
          },
        );
      },
      valueListenable: ValueNotifier(1),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  //init Database

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 2));
  }
}
