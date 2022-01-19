import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pactindo_task_ui/database/db_user.dart';

class ResiPage extends StatelessWidget {
  ResiPage({Key? key}) : super(key: key);

  final CrudUser _crudUser = new CrudUser();

  final List<String> fieldData = [
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
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    String noKtp = arguments[0];
    String email = arguments[1];
    String phoneNumber = arguments[2];
    String otpCode = arguments[3];
    String username = arguments[4];
    String password = arguments[5];
    String mpin = arguments[6];

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
                  child: Text(arguments[index]),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/login');
                _crudUser.insert({"no_ktp":noKtp, "email":email, "no_telepon":phoneNumber, "kode_otp":otpCode, "username":username, "password":password, "mpin":mpin,});
              }, child: Text('Selanjutnya'),),
            ],
          );
        },
      ),
    );
  }
}
