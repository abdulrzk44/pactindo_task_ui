import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  static const String routes = "/email";

  EmailPage({Key? key}) : super(key: key);

  final TextEditingController _inputController = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    String? noKtp = arguments as String;
    String email = "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff58220),
        title: Text("Email"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Email',
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextFormField(
                controller: _inputController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _inputController,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () {
                    email = value.text;
                    Navigator.pushNamed(context, '/phone',
                        arguments: [noKtp, email]);
                  },
                  child: const Text('Next'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
