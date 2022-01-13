import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsernamePage extends StatelessWidget {
  UsernamePage({Key? key}) : super(key: key);

  final TextEditingController _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff58220),
        title: Text("Username"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Masukan Username',
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextFormField(
                controller: _inputController,
                validator: (value) {
                  if (value!.length < 8){
                    return 'Minimum 8 karakter';
                  }else if (!validateStructure(value)) {
                    return 'Syarat tidak cocok';
                  }
                  Navigator.pushNamed(context, '/password');
                },
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _inputController,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: value.text.isNotEmpty ? (){
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Username disimpan')),
                      );
                      // _inputController.dispose();
                    }
                  } : null,
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