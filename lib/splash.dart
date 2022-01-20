import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pactindo_task_ui/database/db_user.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final CrudUser _crudUser = CrudUser();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _crudUser.openDB();
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
