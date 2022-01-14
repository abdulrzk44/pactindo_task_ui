import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResiPage extends StatelessWidget {
  ResiPage({Key? key}) : super(key: key);

  List<String> fieldData = [
    "Nomor Ktp",
    "Email",
    "Nomor Telepon",
    "Kode OTP",
    "Username",
    "Password",
    "MPIN"
  ];

  @override
  Widget build(BuildContext context) {
    final dataUser = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff58220),
        title: Text("Resi".toUpperCase()),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: fieldData.length,
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding: EdgeInsets.all(5),
                  color: Colors.blue,
                  child: Text(fieldData[index]),
                ),
              ),
              Flexible(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  padding: EdgeInsets.all(5),
                  color: Colors.red,
                  child: Text(dataUser[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
