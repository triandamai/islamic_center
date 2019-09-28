import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamic_center/pages/kajian_home.dart';
import 'package:islamic_center/pages/kajian_kamera.dart';
import 'package:islamic_center/pages/kajian_map.dart';
import 'package:islamic_center/pages/kajian_notif.dart';
import 'package:islamic_center/pages/kajian_profile.dart';
import 'package:islamic_center/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    Kajian(),
    Camera(),
    Email(),
    User(),
  ];

  sharedservice auth = new serviceAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_enhance),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.android),
                title: Text(""),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
