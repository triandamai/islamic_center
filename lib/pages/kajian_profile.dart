import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:islamic_center/services/auth.dart';
import 'package:islamic_center/src/login.dart';
import 'package:islamic_center/services/API.dart';
import 'package:http/http.dart' as http;

final sharedservice auth = new serviceAuth();
final GoogleSignIn _googleSignIn = GoogleSignIn();

class User extends StatefulWidget {
  final String nama;
  final String foto;
  final String email;
  User({this.nama, this.email, this.foto});
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final API api = new Controller();

  String nama;
  String email;
  String photo;

  var gambar = [
    {'gambar': 'assets/images/kajian.jpg'},
    {'gambar': 'assets/images/kajian.jpg'},
    {'gambar': 'assets/images/kajian.jpg'},
    {'gambar': 'assets/images/kajian.jpg'}
  ];

  @override
  void initState() {
    // TODO implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: new Drawer(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "${widget.foto}",
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.width / 5,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Container(
                            child: Text(
                              "${widget.nama}",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Container(
                            child: Text(
                              "${widget.email}",
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(40)),
                            child: Text(
                              "Ganti Profil",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Lorem ipsum dolor sit amet lorewm qadgf djh",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "islamic center.id",
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              ListTile(
                leading: Icon(Icons.star_border),
                title: Text("Disimpan"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text("Validasi Akun"),
                onTap: () {
                  Navigator.pushNamed(context, "/camera");
                },
              ),
              ListTile(
                leading: Icon(Icons.store),
                title: Text("Buka Toko"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.star_border),
                title: Text("Upgrade ke Pro"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings_power),
                title: Text("Log Out(testing)"),
                onTap: () {
                  signOut();
                },
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Pengaturan"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.short_text,
              color: Colors.grey,
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.grey[200]),
          padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.search,
                color: Colors.grey[500],
                size: 12,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Cari..",
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              )
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.grey,
              ),
              onPressed: () => _scaffoldKey.currentState.openDrawer()),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "5",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Postingan",
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "300",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Ikut"),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "4.500",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text("Mengikuti"),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.view_module,
                      color: Colors.red,
                    ),
                    onPressed: null),
                IconButton(
                    icon: Icon(Icons.calendar_view_day), onPressed: null),
                IconButton(icon: Icon(Icons.people), onPressed: null)
              ],
            ),
            Wrap(
                children: gambar.map((data) {
              return new Container(
                padding: EdgeInsets.all(2),
                child: Image.asset(
                  '${data['gambar']}',
                  width: MediaQuery.of(context).size.width / 3 - 10,
                  height: MediaQuery.of(context).size.width / 3 - 10,
                ),
              );
            }).toList())
          ],
        ),
      ),
    );
  }

  void signOut() async {
    await _googleSignIn.signOut().then((_) async {
      await FirebaseAuth.instance.signOut();
      auth.sigOutCurrentUser().then((_) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      });
    });
  }
}
