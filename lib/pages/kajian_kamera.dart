import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:islamic_center/services/auth.dart';

final sharedservice auth = new serviceAuth();
final GoogleSignIn _googleSignIn = GoogleSignIn();

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
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
        child: Text("Kamera"),
      ),
    );
  }
}
