import 'package:flutter/material.dart';
import 'package:login/GGMap/ui/GGMapPage.dart';
import 'package:login/Home/ui/HomePage.dart';

class HomeSelectPage extends StatefulWidget {
  static const String nameRoute = '/HomeSelectPage';
  const HomeSelectPage({super.key});

  @override
  State<HomeSelectPage> createState() => _HomeSelectPageState();
}

class _HomeSelectPageState extends State<HomeSelectPage> {
  int i = 0;
  final pctl = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            i = value;
          });
        },
        controller: pctl,
        children: const [HomePage(), GGMapPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          backgroundColor: Colors.amber,
          onTap: (value) {
            i = value;
            pctl.animateToPage(value,
                duration: const Duration(milliseconds: 100),
                curve: Curves.linear);
          },
          currentIndex: i,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map')
          ]),
    );
  }
}
