import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({Key? key}) : super(key: key);

  final TextEditingController _inputController = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    String noKtp = arguments[0];
    String email = arguments[1];
    String phoneNumber = arguments[2];
    String otpCode = arguments[3];
    String username = arguments[4];
    String password = "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff58220),
        title: Text("Password"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Masukan Password',
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextFormField(
                controller: _inputController,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.length < 8){
                    return 'Minimum 8 karakter';
                  }else if (!validateStructure(value)) {
                    return 'Syarat tidak cocok';
                  }
                  password = value;
                  Navigator.pushNamed(context, '/mpin', arguments: [
                    noKtp,
                    email,
                    phoneNumber,
                    otpCode,
                    username,
                    password
                  ]);
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
                        const SnackBar(content: Text('Password disimpan')),
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