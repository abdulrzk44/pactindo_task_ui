import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:pactindo_task_ui/data/database/db_user.dart';
import 'package:pactindo_task_ui/data/repository/login_repository.dart';
import 'package:pactindo_task_ui/feature/login/login_bloc.dart';
import 'package:pactindo_task_ui/feature/login/login_event.dart';

import '/model/user.dart';
import 'login_state.dart';

class LoginBuilder extends StatelessWidget {
  const LoginBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          LoginBloc(loginRepository: LoginRepository()),
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc? _bloc;
  final CrudUser _crudUser = CrudUser();

  bool passwordVisible = false;

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _inputController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<LoginBloc>(context);
    _crudUser.checkDB().then((value) {
      print("VALUEEE : $value");
    });
    _crudUser.getData().then((value) {
      value.forEach((element) {
        User user = User.fromJson(element);
        print(user.username!);
        print(user.password!);
        print(user.toJson());
      });
    });
  }

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: BlocListener(
          bloc: _bloc,
          listener: (BuildContext context, state) {
            if (state is DefaultLoginLoading) {
              Loader.show(context,
                  isAppbarOverlay: true,
                  isBottomBarOverlay: false,
                  progressIndicator: CircularProgressIndicator(),
                  themeData:
                      Theme.of(context).copyWith(accentColor: Colors.black38),
                  overlayColor: Color(0x99E8EAF6));
            } else if (state is DefaultLoginLoaded) {
              String username = state.response[0];
              String password = state.response[1];
              Loader.hide();
              if (_inputController.text == username &&
                  _inputController2.text == password) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Login Sukses"),
                  ),
                );
                Navigator.pushNamed(context, '/home');
              } else {
                print('USERNAMEEEE : $username');
                print('PASWORDDDDD : $password');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Login Gagal"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } else if (state is DefaultLoginFailed) {
              Loader.hide();
              errorDialog(context, state.error);
            } else if (state is BiometricLoginLoading) {
              Loader.show(context,
                  isAppbarOverlay: true,
                  isBottomBarOverlay: false,
                  progressIndicator: Text(''),
                  themeData:
                      Theme.of(context).copyWith(accentColor: Colors.black38),
                  overlayColor: Color(0x99E8EAF6));
            } else if (state is BiometricLoginLoaded) {
              Navigator.pushNamed(context, '/home');
              Loader.hide();
            } else if (state is BiometricLoginFailed) {
              Loader.hide();
              // errorDialog(context, state.error);
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/pactindo_logo.png',
                    ),
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ID',
                            style: TextStyle(fontSize: 17),
                          ),
                          TextFormField(
                            controller: _inputController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.person_fill),
                            ),
                            validator: (value) {
                              if (value!.length < 5) {
                                return 'Username tidak valid';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Text(
                            'Password',
                            style: TextStyle(fontSize: 17),
                          ),
                          TextFormField(
                            controller: _inputController2,
                            obscureText: !passwordVisible,
                            decoration: InputDecoration(
                              prefixIcon: Icon(CupertinoIcons.lock),
                              suffixIcon: IconButton(
                                color: Colors.grey,
                                splashRadius: 1,
                                icon: Icon(passwordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                onPressed: togglePassword,
                              ),
                            ),
                            validator: (value) {
                              if (value!.length < 5) {
                                return 'Password tidak valid';
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        child: Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          minimumSize: Size.fromHeight(50),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _bloc!.add(DefaultLogin());
                          }
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'atau masuk dengan sidik jari',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _bloc!.add(BiometricLogin());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.orange, // <-- Button color
                      onPrimary: Colors.red,
                    ),
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void errorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Message"),
        content: Column(
          children: <Widget>[
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 35,
              width: 120,
              decoration: BoxDecoration(
                color: Color(0xff00767a),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Center(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
