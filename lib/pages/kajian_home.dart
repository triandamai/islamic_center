import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:islamic_center/components/detail_kajian.dart';
import 'package:islamic_center/models/kajianModel.dart';
import 'package:islamic_center/services/auth.dart';

final sharedservice auth = new serviceAuth();
final GoogleSignIn _googleSignIn = GoogleSignIn();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final String judul, isi, gambar, tag;
  List<kajianModel> list = [
    kajianModel(
        "Kajian Bersama Ustadz Abdul",
        "loremipsu  dolor sit amet amet lorem ipsum",
        "assets/images/kajian.jpg",
        "satu"),
    kajianModel(
        "Kajian Bersama Ustadz Abdul",
        "loremipsu  dolor sit amet amet lorem ipsum",
        "assets/images/kajian.jpg",
        "dua"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Text(
                        "Cari kajian..",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.mic),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: null,
          )
        ],
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, div) => Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 10),
            child: Divider(
              color: Colors.grey,
              height: .15,
            ),
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailKajian(list[index])));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 2,
                              ),
                              Flexible(
                                child: Text(
                                  "Masjid Agung Purwokerto",
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Flexible(
                          flex: 1,
                          child: Icon(Icons.more_horiz),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: SizedBox(
                        height: 300,
                        width: 400,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Hero(
                            tag: list[index].tag.toString(),
                            child: Image.asset(
                              "assets/images/kajian.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Kajian Tahsin Bersama Ustazah..",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              child: Text(
                            "Lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              child: Text(
                            "Baca Selengkapnya..",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.blue,
                            ),
                            textAlign: TextAlign.left,
                          )),
                        ],
                      ),
                    ),
                    //comment like and share
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.thumb_up,
                                  color: Colors.pink[500],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("1000 Suka"),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.message,
                                  color: Colors.grey[500],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("400 Komentar"),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  color: Colors.grey[500],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("30 Berbagi"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
