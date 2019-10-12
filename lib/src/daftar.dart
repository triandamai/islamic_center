import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamic_center/services/API.dart';
import 'package:dio/dio.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final API api = new Controller();

  @override
  void initState() {
    // TODO implement initState
    super.initState();
    api.getcurrentUser().then((FirebaseUser user) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    //TODO :: daftar=> navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: IconButton(
                              alignment: Alignment.center,
                              icon: Icon(Icons.arrow_back),
                              iconSize: 20,
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            "Kembali",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'SourceSans',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //TODO :: daftar=> header
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Lengkapi data diri di bawah ini!",
                            style: TextStyle(
                              fontFamily: 'SourceSans',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    //TODO :: daftar=> label form nama
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Nama Lengkap",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //TODO :: daftar=> form nama
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "Trian damai",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: Colors.black38,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //TODO :: daftar=> label form emal
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Alamat E-mail",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //TODO :: daftar=> form email
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "triandamai@gmail.com",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: Colors.black38,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //TODO :: daftar=> label form no hp
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Nomor Handphone",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //TODO :: daftar=> form no hp
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        style: TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: "081xxxxxxxxx",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[200],
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 2,
                            ),
                          ),
                        ),
                        cursorColor: Colors.black38,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    //TODO :: daftar=> button bottom
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height - 480),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'SourceSans',
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        'Dengan masuk atau mendaftar, anda menyetujui ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontFamily: 'SourceSans',
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Ketentuan Layanan',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blueAccent,
                                      fontFamily: 'SourceSans',
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' dan ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontFamily: 'SourceSans',
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Kebijakan Privasi',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blueAccent,
                                      fontFamily: 'SourceSans',
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(color: Colors.green),
                            child: Center(
                              child: Text(
                                "Daftar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
