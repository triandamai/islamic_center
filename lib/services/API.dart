import 'dart:io';
import 'package:flutter/painting.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

final String BASE_URL2 = "http://islamic-center.projeku.site/";
final String BASE_URL = "http://192.168.100.229:4000/";
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final GoogleSignIn googleSignIn = new GoogleSignIn();
final FacebookLogin facebookSignIn = new FacebookLogin();

abstract class API {
  Future<http.Response> gett(String url);
  Future<http.Response> post(String url, body);
  Future<FirebaseUser> facebookLogin();
  Future<FirebaseUser> getcurrentUser();
  Future<FirebaseUser> signInwithgoogle();
  Future<http.Response> put(String url, body);
  Future<http.Response> uploadImgaeUser(String url, body);
}

class Controller implements API {
  @override
  Future<http.Response> uploadImgaeUser(
    String url,
    body,
  ) async {
    // TODO implement uploadImgaeUser

    // List<int> imageBytes = await file.readAsBytes();
    // String base64 = base64Encode(imageBytes);
    print(body);
    return await http.post(BASE_URL2 + url, body: body);
  }

  @override
  Future<http.Response> put(String url, body) async {
    // TODO implement put
    return await http.put(BASE_URL2 + url,
        headers: {'Content-Type': 'application/json'},
        body: JsonCodec().encode(body));
  }

  @override
  Future<FirebaseUser> signInwithgoogle() async {
    // TODO implement signInwithgoogle
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser fireUser = await _firebaseAuth.currentUser();
    return fireUser;
  }

  @override
  Future<FirebaseUser> facebookLogin() async {
    // TODO implement facebookLogin
    //my code
    final FirebaseAuth _fAuth = FirebaseAuth.instance;
    //end my code

    final FacebookLoginResult result =
        await facebookSignIn.logIn(['email', 'user_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        // TODO Handle this case.
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: "${result.accessToken}");
        return (await _fAuth.signInWithCredential(credential)).user;
        //Token: ${accessToken.token}
        print("${result.accessToken} dan ${result.status}");
        break;
      case FacebookLoginStatus.cancelledByUser:
        // TODO Handle this case.
        print("cancel by user ${result.status}");
        break;
      case FacebookLoginStatus.error:
        // TODO Handle this case.
        print("cancel by user ${result.status}");
        break;
    }
    return null;
  }

  @override
  Future<FirebaseUser> getcurrentUser() async {
    // TODO implement getcurrentUser
    return await FirebaseAuth.instance.currentUser();
  }

  @override
  Future<http.Response> gett(String link) async {
    // TODO implement cekUser
    // make GET request
    String url = BASE_URL2 + link;
    http.Response response = await http.get(url);
    // sample info available in response
    // int statusCode = response.statusCode;
    // Map<String, String> headers = response.headers;
    // String contentType = headers['content-type'];
    // String json = response.body;

    return response;
  }

  @override
  Future<http.Response> post(String url, body) async {
    // TODO implement simpanUser

    return await http.post(BASE_URL2 + url,
        headers: {'Content-Type': 'application/json'},
        body: JsonCodec().encode(body));
  }
}
