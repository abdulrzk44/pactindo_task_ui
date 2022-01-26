import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pactindo_task_ui/data/repository/check_account_repository.dart';
import 'package:pactindo_task_ui/feature/splash_screen/splash_screen_bloc.dart';
import 'package:pactindo_task_ui/feature/splash_screen/splash_screen_event.dart';
import 'package:pactindo_task_ui/feature/splash_screen/splash_screen_state.dart';

class SplashScreenBuilder extends StatelessWidget {
  const SplashScreenBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          SplashScreenBloc(checkaccountRepository: CheckAccountRepository()),
      child: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  static const String routes = "/splash_screen";

  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // final CrudUser _crudUser = CrudUser();
  SplashScreenBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<SplashScreenBloc>(context);
    _bloc!.add(CheckUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
      body: BlocListener(
        bloc: _bloc,
        listener: (BuildContext context, state) {
          if (state is CheckUserLoading) {
          } else if (state is CheckUserLoaded) {
            if (state.response! == true) {
              Navigator.pushNamed(context, '/login');
            } else {
              Navigator.pushNamed(context, '/eula');
            }
          } else if (state is CheckUserFailed) {}
        },
        child: Center(
            child: lightMode
                ? Image.asset('assets/images/splash.png')
                : Image.asset('assets/images/splash_dark.png')),
      ),
      /* FutureBuilder(
        future: _crudUser.getData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) { 
          if (snapshot.hasData) {
            if (snapshot.data != null || snapshot.data != []) {
              Navigator.pushNamed(context, '/login');
            } else {
              Navigator.pushNamed(context, '/eula');
            }
          }
          return Center(
            child: lightMode
                ? Image.asset('assets/images/splash.png')
                : Image.asset('assets/images/splash_dark.png'));
         },
      ), */
    );
  }
}
