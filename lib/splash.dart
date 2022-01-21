import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pactindo_task_ui/feature/confirm_mpin.dart';
import 'package:pactindo_task_ui/feature/email.dart';
import 'package:pactindo_task_ui/feature/eula.dart';
import 'package:pactindo_task_ui/feature/home.dart';
import 'package:pactindo_task_ui/feature/ktp.dart';
import 'package:pactindo_task_ui/feature/login.dart';
import 'package:pactindo_task_ui/feature/mpin.dart';
import 'package:pactindo_task_ui/feature/otp.dart';
import 'package:pactindo_task_ui/feature/password.dart';
import 'package:pactindo_task_ui/feature/phone.dart';
import 'package:pactindo_task_ui/feature/username.dart';
import 'package:pactindo_task_ui/resi.dart';

import 'data/database/db_user.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final CrudUser _crudUser = CrudUser();

  bool isDbExist = false;

  @override
  void initState() {
    super.initState();
    _crudUser.checkDB().then((value) => isDbExist = value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          bool lightMode =
              MediaQuery.of(context).platformBrightness == Brightness.light;
          return Scaffold(
            backgroundColor:
            lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
            body: Center(
                child: lightMode
                    ? Image.asset('assets/images/splash.png')
                    : Image.asset('assets/images/splash_dark.png')),
          );
        } else {
          // Loading is done, return the app:
          return ValueListenableBuilder(
            builder: (context, value, g) {
              return MaterialApp(
                title: "PACTINDO Route",
                initialRoute: isDbExist ? '/login' : '/eula',
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
      },
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
    await Future.delayed(const Duration(seconds: 5));
  }
}
