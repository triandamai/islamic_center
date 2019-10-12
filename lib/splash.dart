import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:islamic_center/models/SharedCurrentUser.dart';
import 'package:islamic_center/services/auth.dart';

class Splash extends StatefulWidget {
  final sharedservice auth;
  Splash({this.auth});
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.auth.getCurrentUser().then((currentUser user) {
    //   if (user != null) {
    //     if (user.loginStatus) {
    //       Navigator.pushReplacementNamed(context, '/home');
    //     } else {
    //       Navigator.pushReplacementNamed(context, '/login');
    //     }
    //   } else {
    //     Navigator.pushReplacementNamed(context, '/login');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
