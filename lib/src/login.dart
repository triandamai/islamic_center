import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamic_center/helper/drawline.dart';
import 'package:islamic_center/icons/my_custom_icon_icons.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:http/http.dart' as http;
import 'package:islamic_center/services/API.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final API api = new Controller();

  bool inputCodeOTP = false;
  bool isValid = false;
  bool TimeOut = false;

  String nomerhp = "";
  String verifikasiId;

  String codeOtp;

  Timer _timer;
  int seconds;
  DateTime onBackPressed;

  @override
  void initState() {
    super.initState();

    api.getcurrentUser().then((FirebaseUser user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });

    setState(() {
      inputCodeOTP = true;
      isValid = false;
      TimeOut = false;
    });

    // Get the current time
    var now = DateTime.now();
    // Get a 2-minute interval
    var twoHours = now.add(Duration(minutes: 2)).difference(now);
    // Get the total number of seconds, 2 minutes for 120 seconds
    seconds = twoHours.inSeconds;
    // startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.symmetric(
                horizontal: 0,
              ),
              child: inputCodeOTP ? _loginScreen(context) : _otpScreen(context),
            ),
          ),
        ),
        onWillPop: onWillPop,
      ),
    );
  }

  Widget _loginScreen(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Logo Muslim Center",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSans',
                ),
              )
            ],
          ),
          SizedBox(
            height: 280,
            width: 300,
            child: Image.asset("assets/images/header_splas.png"),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Selamat Datang di Muslim Center",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSans',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Lorem ipsum dolor sit amet Lorem ipsum dolor amet lorem ipsum  lorem ipsum dolor sit amet ",
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'SourceSans',
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 0),
                    padding:
                        EdgeInsets.only(left: 20, right: 10, top: 0, bottom: 0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        if (val.length <= 10) {
                          setState(() {
                            nomerhp = "+62$val";
                            isValid = false;
                          });
                        } else {
                          setState(() {
                            nomerhp = "+62$val";
                            isValid = true;
                          });
                        }
                      },
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'SourceSans',
                        color: Colors.grey[700],
                      ),
                      decoration: InputDecoration(
                          hintText: "8345457xx", border: InputBorder.none),
                      cursorColor: Colors.grey,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 0, left: 15, top: 20),
                      child: IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.arrow_forward),
                        color: isValid ? Colors.white : Colors.black38,
                        onPressed: () async {
                          if (isValid) {
                            print("TextField is valid");
                            _VerifyNomer();
                            setState(() {
                              inputCodeOTP = false;
                            });
                          } else {
                            print("tidak valid");
                          }
                        },
                      ),
                      decoration: BoxDecoration(
                        color: isValid ? Color(0xffef0049) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Text(
                "Belum Punya Akun ?",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'SourceSans',
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/daftar');
                },
                child: Text(
                  "Daftar",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontFamily: 'SourceSans',
                  ),
                ),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomPaint(painter: Drawhorizontalline(true)),
                  Text(
                    "Atau",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'SourceSans',
                    ),
                  ),
                  CustomPaint(painter: Drawhorizontalline(false))
                ],
              )),
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    api.facebookLogin().then((FirebaseUser user) {
                      if (user != null) {
                        Fluttertoast.showToast(
                            msg: "Berhasil Login",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pushReplacementNamed(context, "/home");
                      } else {
                        Fluttertoast.showToast(
                            msg: "Gagal Login",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 35, right: 35),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[800]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          MyCustomIcon.facebook,
                          size: 15,
                          color: Colors.white,
                        ),
                        Text(
                          "Facebook",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SourceSans',
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () async {
                    api.signInwithgoogle().then((FirebaseUser user) async {
                      assert(user.uid == user.uid);

                      if (user != null) {
                        Map<String, String> headers = {
                          "Content-type": "application/json",
                          'Accept': 'application/json',
                        };

                        api
                            .gett("cekuser/${user.uid}")
                            .then((http.Response res) {
                          print(res.body);
                          if (res.statusCode == 200) {
                            var status = jsonDecode(res.body);

                            if (status["success"] == true) {
                              Fluttertoast.showToast(
                                  msg: "Login berhasil",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIos: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              if (status["data"] == 4) {
                                //belum ada di db
                                Navigator.pushReplacementNamed(
                                    context, "/updateuser");
                              } else if (status["data"] == 3) {
                                //sudah ada semua
                                Navigator.pushReplacementNamed(
                                    context, "/home");
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Gagal Login",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIos: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pushReplacementNamed(
                                  context, "/updateuser");
                            }
                          }
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Login Gagal Silahkan Coba Kembali",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    });
                  },
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 35, right: 35),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          MyCustomIcon.google,
                          size: 15,
                          color: Colors.red,
                        ),
                        Text(
                          "Google",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SourceSans',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'SourceSans',
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Dengan masuk atau mendaftar, anda menyetujui ',
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _otpScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    inputCodeOTP = true;
                  });
                },
                borderRadius: BorderRadius.circular(20),
                child: IconButton(
                  alignment: Alignment.center,
                  icon: Icon(Icons.arrow_back),
                  iconSize: 20,
                  onPressed: () {
                    setState(() {
                      inputCodeOTP = true;
                    });
                  },
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
          height: 250,
          width: 300,
          child: Image.asset("assets/images/otp_image.png"),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Masukkan Kode OTP",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceSans',
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Kami Telah mengirimkan Kode OTP ke nomor anda $nomerhp",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'SourceSans',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 25, right: 25, bottom: 0),
          child: PinPut(
            onSubmit: (String val) {
              codeOtp = val;
            },
            autoFocus: false,
            fieldsCount: 6,
            clearButtonIcon: Icon(Icons.content_copy),
            inputDecoration: InputDecoration(
              counterText: "",
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black38,
                  width: 2,
                ),
              ),
            ),
            actionButtonsEnabled: false,
            textStyle: TextStyle(fontSize: 15),
            spaceBetween: 10,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              onTap: () {
                _settingModalBottomSheet(context);
              },
              child: TimeOut ? Text("Metode Lain") : Text(""),
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                  height: 10,
                  child: TimeOut
                      ? Text("")
                      : CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                ),
                SizedBox(
                  width: 10,
                ),
                TimeOut
                    ? InkWell(
                        onTap: () {},
                        child: Text("Kirim Ulang"),
                      )
                    : Text(
                        constructTime(seconds),
                        style: TextStyle(color: Colors.red),
                      ),
              ],
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            //TODO :: otp=> button
            Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height),
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
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.currentUser().then((user) {
                        if (user != null) {
                          print("sudah Login");
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          _signWithNumber();
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.red),
                      child: Center(
                        child: Text(
                          "Masuk",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[300]),
                      child: Text(" "),
                    )
                  ],
                ),
                new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.music_note),
                        title: new Text('Masuk Dengan Google'),
                        onTap: () => {}),
                    new ListTile(
                      leading: new Icon(Icons.videocam),
                      title: new Text('Video'),
                      onTap: () => {},
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  //ketika tombol kembali di pencet
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (inputCodeOTP) {
      if (onBackPressed == null ||
          now.difference(onBackPressed) > Duration(seconds: 2)) {
        onBackPressed = now;
        Fluttertoast.showToast(
            msg: "Tekan lagi untuk keluar",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return Future.value(false);
      }
    } else {
      setState(() {
        inputCodeOTP = true;
      });
      return Future.value(false);
    }
    return Future.value(true);
  }

//verifikasi nomer
  void _VerifyNomer() async {
    startTimer();
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      codeOtp = phoneAuthCredential.toString();
      _auth.signInWithCredential(phoneAuthCredential).then((_) {
        api.getcurrentUser().then((FirebaseUser user) {
          if (user.uid != null) {
            cancelTimer();
            Navigator.pushReplacementNamed(context, '/daftar');
          }
        });
      });
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authEx) {
      print("gagal verifikasi nomer ${authEx.message}");
      Fluttertoast.showToast(
          msg: "Verifikasi Gagal !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    };

    final PhoneCodeSent codeSent =
        (String verId, [int forceResendingToken]) async {
      verifikasiId = verId;
      print("code terkirim : $verId");
      Fluttertoast.showToast(
          msg: "Silahkan Cek Kotak Pesan Anda",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verId) {
      verifikasiId = verId;
      print("time out :" + verId);
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: nomerhp,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _signWithNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verifikasiId, smsCode: codeOtp);
      print(codeOtp);
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;

      final FirebaseUser currUser = await _auth.currentUser();

      assert(user.uid == currUser.uid);

      if (user != null) {
        print("berhasil");
        Fluttertoast.showToast(
            msg: "Login berhasil",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          Navigator.pushReplacementNamed(context, "/home");
        });
      } else {
        print("gagal login");
        Fluttertoast.showToast(
            msg: "Login gagal",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void startTimer() {
    // Set 1 second callback
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      // Update interface
      setState(() {
        // minus one second because it calls back once a second
        seconds--;
      });
      if (seconds == 0) {
        // Countdown seconds 0, cancel timer

        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      setState(() {
        TimeOut = true;
      });
    }
  }

  // Time formatting, converted to the corresponding hh:mm:ss format according to the total number of seconds
  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) +
        ":" +
        formatTime(minute) +
        ":" +
        formatTime(second);
  }

  // Digital formatting, converting 0-9 time to 00-09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    cancelTimer();
    super.dispose();
  }
}
