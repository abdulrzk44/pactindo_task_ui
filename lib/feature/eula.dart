import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '/model/eula_model.dart';

class EulaPage extends StatefulWidget {
  // final AssetBundle rootBundle = _initRootBundle();
  @override
  _EulaPageState createState() => _EulaPageState();
}

class _EulaPageState extends State<EulaPage> {
  bool isChecked = false;

  String contentBase64 = "";

  initState() {
    super.initState();
  }

  Future<EulaModel> loadJsonData() async {
    /* Jadikan return data dengan model data eula */
    var jsonText = await rootBundle.loadString('assets/data/dummy_html.json');
    String eulaData = jsonText;
    EulaModel eula = EulaModel.fromJson(jsonDecode(eulaData));
    return eula;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xfff58220),
        title: Text("EULA"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        /* Pakai future builder buat get data asynchronous */
        future: loadJsonData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            /* Cek apakah datanya ada atau tidak, kalau ada tampilkan widget webview, kalau tidak tampilkan loading */
            return Container(
              height: MediaQuery.of(context).size.height,
              child: WebView(
                initialUrl:
                    'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(snapshot.data.eulaHtml))}',
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    /* Set state ketika checkbox ditap/dikasih action */
                    setState(() {
                      isChecked = value!;
                    });
                  }),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (isChecked) {
                      /* Kasih validasi kalau checkbox belum diceklis, button gaboleh ada aksi */
                      Navigator.pushNamed(context, '/ktp');
                      setState(() {
                        isChecked = false;
                      });
                      print('I Agree Clicked');
                    }
                  },
                  child: Text(
                    "I Agree",
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
