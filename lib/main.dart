import 'package:flutter/material.dart';
import 'package:pactindo_task_ui/confirm_mpin.dart';
import 'package:pactindo_task_ui/password.dart';
import 'package:pactindo_task_ui/phone.dart';
import 'package:pactindo_task_ui/resi.dart';
import 'package:pactindo_task_ui/username.dart';

import 'email.dart';
import 'eula.dart';
import 'home.dart';
import 'ktp.dart';
import 'mpin.dart';
import 'otp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
          },
        );
      },
      valueListenable: ValueNotifier(1),
    );
  }
}
