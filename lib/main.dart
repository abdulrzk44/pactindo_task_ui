import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Container> myGrid = List.generate(8, (index) {
    List<String> gridText = [
      'Rekening Saya',
      'Transfer',
      'Pembelian',
      'Pembayaran',
      'Favorit',
      'Transaksi Terjadwal',
      'Layanan Islami',
      'Semua Menu'
    ];
    return Container(
      child: Center(child: Text(gridText[index])),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
            Random().nextInt(255)),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  });
  List<Color> myColor = [
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff58220),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text("Tepat"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              color: Colors.lightBlue[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bandung Wetan, Dzuhur 12:08',
                  ),
                  Text(
                    "11 Sya'ban 1442 H",
                  ),
                ],
              )),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    "Assalamu'alaikum, Muhammad Imam",
                  ),
                ),
                Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 180,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.92,
                      autoPlay: true,
                    ),
                    items: [1, 2, 3, 4, 5]
                        .map((item) => Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 15),
                              child: Center(child: Text(item.toString())),
                              decoration: BoxDecoration(
                                color: myColor[item - 1],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  height: 190,
                  // color: Colors.lightBlue,
                  child: GridView.count(
                    // primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 4,
                    children: myGrid,
                  ),
                ),
                Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 180,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.92,
                      autoPlay: true,
                    ),
                    items: [1, 2, 3, 4, 5]
                        .map((item) => Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 15),
                              child: Center(child: Text(item.toString())),
                              decoration: BoxDecoration(
                                color: myColor[item - 1],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
