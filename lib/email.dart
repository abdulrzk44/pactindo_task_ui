import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  static const String routes = "/email";
  EmailPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            Text('Email', style: TextStyle(fontSize: 25),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextFormField(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/phone');
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}