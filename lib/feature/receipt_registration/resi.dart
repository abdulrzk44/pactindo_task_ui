import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:pactindo_task_ui/data/repository/registration_repository.dart';
import 'package:pactindo_task_ui/feature/receipt_registration/resi_bloc.dart';
import 'package:pactindo_task_ui/feature/receipt_registration/resi_event.dart';
import 'package:pactindo_task_ui/feature/receipt_registration/resi_state.dart';
import 'package:pactindo_task_ui/model/user.dart';

class ResiBuilder extends StatelessWidget {
  const ResiBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          ResiBloc(registrationRepository: RegistrationRepository()),
      child: ResiPage(args: ModalRoute.of(context)!.settings.arguments as List),
    );
  }
}

class ResiPage extends StatefulWidget {
  final List? args;
  ResiPage({Key? key, this.args}) : super(key: key);

  @override
  _ResiPageState createState() => _ResiPageState();
}

class _ResiPageState extends State<ResiPage> {
  ResiBloc? _bloc;
  User user = User();
  List arguments = [];

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ResiBloc>(context);
    arguments = widget.args!;
    initData();
  }

  String username(){
    return arguments[4];
  }

  String password(){
    return arguments[5];
  }

  initData() {
    String noKtp = arguments[0];
    String email = arguments[1];
    String phoneNumber = arguments[2];
    String otpCode = arguments[3];
    String username = arguments[4];
    String password = arguments[5];
    String mpin = arguments[6];
    user = User(
        email: email,
        noKtp: noKtp,
        noTelepon: phoneNumber,
        kodeOtp: otpCode,
        username: username,
        password: password,
        mpin: mpin);
  }

  // final CrudUser _crudUser = new CrudUser();
  //
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff58220),
        title: Text("Resi".toUpperCase()),
        centerTitle: true,
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (BuildContext context, state) {
          if (state is SubmitResiLoading) {
            Loader.show(context,
                isAppbarOverlay: true,
                isBottomBarOverlay: false,
                progressIndicator: CircularProgressIndicator(),
                themeData: Theme.of(context)
                    .copyWith(accentColor: Colors.black38),
                overlayColor: Color(0x99E8EAF6));
          } else if (state is SubmitResiLoaded) {
            Loader.hide();
            _bloc!.add(PrefResi(username: username(), password: password()));
          } else if (state is SubmitResiFailed) {
            Loader.hide();
            errorDialog(context, state.error);
            _bloc!.add(PrefResi(username: username(), password: password()));
          } else if (state is SubmitSharePrefsLoading) {
            Loader.show(context,
                isAppbarOverlay: true,
                isBottomBarOverlay: false,
                progressIndicator: CircularProgressIndicator(),
                themeData: Theme.of(context)
                    .copyWith(accentColor: Colors.black38),
                overlayColor: Color(0x99E8EAF6));
          } else if (state is SubmitSharePrefsLoaded) {
            Loader.hide();
            Navigator.pushNamed(context, '/login');
          } else if (state is SubmitSharePrefsFailed) {
            Loader.hide();
            errorDialog(context, state.error);
          }
        },
        child: ListView.builder(
          itemCount: fieldData.length + 1,
          itemBuilder: (context, index) {
            if (index == fieldData.length) {
              return ElevatedButton(
                onPressed: () {
                  _bloc!.add(SubmitResi(user: user));
                  // _crudUser.insert({"no_ktp":noKtp, "email":email, "no_telepon":phoneNumber, "kode_otp":otpCode, "username":username, "password":password, "mpin":mpin,});
                },
                child: Text('Selanjutnya'),
              );
            }
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
              ],
            );
          },
        ),
      ),
    );
  }

  void errorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Message"),
        content: Column(
          children: <Widget>[
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 35,
              width: 120,
              decoration: BoxDecoration(
                color: Color(0xff00767a),
                borderRadius: BorderRadius.circular(17),
              ),
              child: Center(
                child: Text(
                  "Ok",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
