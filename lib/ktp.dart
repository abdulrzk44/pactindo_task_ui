import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pactindo_task_ui/model/ktp_model.dart';

class KtpPage extends StatelessWidget {
  KtpPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  Future<KtpModel> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/data/dummy_ktp.json');
    KtpModel ktpModel = KtpModel.fromJson(jsonDecode(jsonText));
    return ktpModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff58220),
        title: Text("Validasi KTP"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Masukan Nomor KTP',
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: TextFormField(
                validator: (value) {
                  loadJsonData().then((valueKtp){
                    String? noKTP = valueKtp.noKTP;
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value != noKTP) {
                      return 'Nomor KTP tidak valid';
                    }
                    Navigator.pushNamed(context, '/email');
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('No KTP Valid')),
                  // );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
