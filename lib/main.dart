import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:islamic_center/services/auth.dart';
import 'package:islamic_center/splash.dart';
import 'package:islamic_center/src/daftar.dart';
import 'package:islamic_center/src/home.dart';
import 'package:islamic_center/src/login.dart';
import 'package:islamic_center/src/pick_camera.dart';

void main() => runApp(MyApp());

bool get isAndroid =>
    foundation.defaultTargetPlatform == TargetPlatform.android;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainApp();
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routes = {
      '/': (context) => Splash(
            auth: new serviceAuth(),
          ),
      '/login': (context) => LoginPage(),
      '/daftar': (context) => Register(),
      '/home': (context) => Home(),
      '/camera': (context) => CameraScreen(),
      // '/detail_kajian': (context) => DetailKajian(),
    };
    if (isAndroid) {
      //jika android
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: routes,
      );
    } else {
      //jika ios
      return CupertinoApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(primaryColor: Colors.blue),
        initialRoute: isLogin ? '/' : '/login',
        routes: routes,
      );
    }
  }
}
