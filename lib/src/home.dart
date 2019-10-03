import 'dart:convert';
import 'package:ant_icons/ant_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamic_center/pages/kajian_home.dart';
import 'package:islamic_center/pages/kajian_kamera.dart';
import 'package:islamic_center/pages/kajian_map.dart';
import 'package:islamic_center/pages/kajian_notif.dart';
import 'package:islamic_center/pages/kajian_profile.dart';
import 'package:islamic_center/services/API.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_center/models/userModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final API api = new Controller();
  int _currentIndex = 0;

  String name;
  String photo;
  String email;

  @override
  void initState() {
    // TODO implement initState
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    await api.getcurrentUser().then((FirebaseUser user) {
      if (user == null) {
      } else {
        api.gett("cekuser/${user.uid}").then((http.Response res) {
          print(res.body);
        });
      }
    });
    await api.getcurrentUser().then((FirebaseUser user) {
      if (user == null) {
      } else {
        api.gett("users/${user.uid}").then((http.Response res) {
          var data = jsonDecode(res.body);
          setState(() {
            this.name = data["data"][0]["nama"];
            this.email = data["data"][0]["email"];
            this.photo = data["data"][0]["foto"];
          });
          print(data);
          print(data["data"][0]["uid"]);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      HomePage(),
      Kajian(),
      Camera(),
      Email(),
      User(
        nama: name,
        email: email,
        foto: photo,
      ),
    ];

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
                icon: Icon(AntIcons.home_outline),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: Icon(AntIcons.environment_outline),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: Icon(AntIcons.camera_outline),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: Icon(AntIcons.mail_outline),
                title: Text(""),
              ),
              BottomNavigationBarItem(
                icon: Icon(AntIcons.user),
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
