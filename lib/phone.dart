import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneNumberPage extends StatelessWidget {
  PhoneNumberPage({Key? key}) : super(key: key);

  final TextEditingController _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? phoneNumber;
    String otpCode = "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff58220),
        title: Text("Telepon"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Masukan Nomor Telepon',
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextFormField(
                controller: _inputController,
                validator: (value) {
                  phoneNumber = value;
                  if (value!.length < 10 || value.length > 15) {
                    return 'Nomor telepon tidak valid';
                  }
                  otpCode = phoneNumber!.substring(phoneNumber!.length - 6);
                  Navigator.pushNamed(context, '/otp', arguments: [phoneNumber, otpCode]);
                },
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _inputController,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: value.text.isNotEmpty ? (){
                    if (_formKey.currentState!.validate()) {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('ok')),
                      // );
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
