import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pactindo_task_ui/model/ktp_model.dart';

import 'email.dart';

class KtpPage extends StatelessWidget {
  KtpPage({Key? key}) : super(key: key);

  TextEditingController _inputController = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<KtpModel> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/data/dummy_ktp.json');
    KtpModel ktpModel = KtpModel.fromJson(jsonDecode(jsonText));
    return ktpModel;
  }

  @override
  Widget build(BuildContext context) {
    String? noKTP;
    loadJsonData().then((valueKtp) {
      noKTP = valueKtp.noKTP;
    });

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff58220),
          title: Text("Validasi KTP"),
          centerTitle: true,
          leading: Container(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Masukan Nomor KTP',
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _inputController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  enabled: true,
                  validator: (value) {
                    if (value!.length < 15) {
                      return 'Nomor KTP tidak valid';
                    } else if (value != noKTP) {
                      return 'Nomor KTP tidak cocok';
                    }
                    return null;
                  },
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _inputController,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: value.text.isNotEmpty
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Nomor KTP Valid')),
                            );
                            Navigator.pushNamed(context, EmailPage.routes,
                                arguments: noKTP);
                            // _inputController.dispose();
                          }
                        }
                      : null,
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
