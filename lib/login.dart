import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biometrics/flutter_biometrics.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisible = false;
  String _publicKey = 'Not retrieved/Not set';
  String _signature = 'Unknown';
  String _payload = 'Zmx1dHRlcl9iaW9tZXRyaWNz';

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  Future<void> createKeys() async {
    var biometrics = FlutterBiometrics();
    String publicKey = await biometrics.createKeys(
        reason: 'Please authenticate to create public/private key pair');

    setState(() {
      _publicKey = publicKey;
    });

    if (!mounted) return;
  }

  Future<void> sign() async {
    var biometrics = FlutterBiometrics();
    String signature = await biometrics.sign(
        payload: _payload,
        reason: 'Please authenticate to sign specified payload');

    setState(() {
      _signature = signature;
      Navigator.pushNamed(context, '/home',
          arguments: _username);
    });

    if (!mounted) return;
  }

  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _inputController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _username = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
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
                            } else if (value != _username) {
                              return 'Username tidak valid';
                            }
                            Navigator.pushNamed(context, '/home',
                                arguments: _username);
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
                            } else if (value != _username) {
                              return 'Password tidak valid';
                            }
                            Navigator.pushNamed(context, '/home',
                                arguments: _username);
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
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _inputController,
                    builder: (context, value, child) {
                      return ElevatedButton(
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
                        onPressed: value.text.isNotEmpty
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Nomor KTP Valid')),
                                  );
                                  // _inputController.dispose();
                                }
                              }
                            : null,
                      );
                    },
                  ),
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
                  onPressed: sign,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Colors.orange, // <-- Button color
                    onPrimary: Colors.red,
                  ), child: SizedBox(height: 50,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}