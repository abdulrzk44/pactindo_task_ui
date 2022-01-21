import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberPage extends StatelessWidget {
  PhoneNumberPage({Key? key}) : super(key: key);

  final TextEditingController _inputController = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    String noKtp = arguments[0];
    String email = arguments[1];
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
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  phoneNumber = value;
                  if (value!.length < 10 || value.length > 15) {
                    return 'Nomor telepon tidak valid';
                  }
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
                      otpCode = phoneNumber!.substring(phoneNumber!.length - 6);
                      Navigator.pushNamed(context, '/otp', arguments: [
                        noKtp, email, phoneNumber, otpCode]);
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
