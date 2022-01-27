import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController tabController = PageController();
  int _selectedTab = 0;

  void onTappedTab(int index) {
    setState(() {
      _selectedTab = index;
    });
    tabController.jumpToPage(index);
  }

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
      body: PageView(
        controller: tabController,
        children: [
          Beranda(),
          Info(),
          Histori(),
          Akun(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Histori'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        currentIndex: _selectedTab,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: onTappedTab,
      ),
    );
  }
}

class Beranda extends StatelessWidget {
  Beranda({Key? key}) : super(key: key);

  final List<Color> myColor = [
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    print("CONTEXXXX = $context");
    return Column(
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
            // padding: EdgeInsets.only(bottom: 32),
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
                  physics: NeverScrollableScrollPhysics(),
                  // primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 4,
                  children: List.generate(8, (index) {
                    final List<String> gridText = [
                      'Rekening Saya',
                      'Transfer',
                      'Pembelian',
                      'Pembayaran',
                      'Favorit',
                      'Transaksi Terjadwal',
                      'Layanan Islami',
                      'Semua Menu'
                    ];
                    return InkWell(
                      onTap: () {
                        if (gridText[index] == 'Semua Menu') {
                          showCupertinoModalBottomSheet(
                            expand: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => MenuBottomSheet(),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, Random().nextInt(255),
                              Random().nextInt(255), Random().nextInt(255)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(gridText[index]),
                      ),
                    );
                  }),
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
    );
  }
}

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
            color: Colors.transparent,
            child: Scaffold(
              backgroundColor: CupertinoTheme.of(context)
                  .scaffoldBackgroundColor
                  .withOpacity(0.95),
              extendBodyBehindAppBar: true,
              body: CustomScrollView(
                physics: ClampingScrollPhysics(),
                controller: ModalScrollController.of(context),
                slivers: <Widget>[
                  SliverSafeArea(
                    bottom: false,
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 318,
                        child: ListView(
                          padding: EdgeInsets.all(12).copyWith(
                              right:
                                  MediaQuery.of(context).size.width / 2 - 100),
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          physics: PageScrollPhysics(),
                          children: <Widget>[],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(height: 1),
                  ),
                  sliverContactsSection(context),
                  SliverToBoxAdapter(
                    child: Divider(height: 1),
                  ),
                  SliverSafeArea(
                    top: false,
                    sliver: SliverPadding(
                        padding: EdgeInsets.only(
                      bottom: 20,
                    )),
                  )
                ],
              ),
            )));
  }

  Widget sliverContactsSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 132,
        padding: EdgeInsets.only(top: 12),
      ),
    );
  }
}

class Info extends StatelessWidget {
  Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        'Tab Info',
        style: new TextStyle(fontSize: 40),
      )),
    );
  }
}

class Histori extends StatelessWidget {
  Histori({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        'Tab History',
        style: new TextStyle(fontSize: 40),
      )),
    );
  }
}

class Akun extends StatelessWidget {
  Akun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        'Tab Akun',
        style: new TextStyle(fontSize: 40),
      )),
    );
  }
}
