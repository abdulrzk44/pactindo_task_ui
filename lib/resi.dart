import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pactindo_task_ui/database/db_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResiPage extends StatelessWidget {
  ResiPage({Key? key}) : super(key: key);

  final CrudUser _crudUser = new CrudUser();

  late String noKtp;
  late String email;
  late String phoneNumber;
  late String otpCode;
  late String username;
  late String password;
  late String mpin;

  void savePref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("username", username);
    preferences.setString("password", password);
  }

  final List<String> fieldData = [
    "Nomor Ktp",
    "Email",
    "Nomor Telepon",
    "Kode OTP",
    "Username",
    "Password",
    "MPIN"
  ];

  Future<String> getPrefUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("username") ?? "";
  }

  Future<String> getPrefPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("password") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    noKtp = arguments[0];
    email = arguments[1];
    phoneNumber = arguments[2];
    otpCode = arguments[3];
    username = arguments[4];
    password = arguments[5];
    mpin = arguments[6];
    // _crudUser.openDB();

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
              ElevatedButton(
                onPressed: () {
                  _crudUser.insert({
                    "no_ktp": noKtp,
                    "email": email,
                    "no_telepon": phoneNumber,
                    "kode_otp": otpCode,
                    "username": username,
                    "password": password,
                    "mpin": mpin,
                  });
                  savePref();
                  getPrefUsername().then((value) => print('USERNAME : $value'));

                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Selanjutnya'),
              ),
            ],
          );
        },
      ),
    );
  }
}
