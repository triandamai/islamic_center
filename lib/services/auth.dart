import 'package:islamic_center/models/SharedCurrentUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class sharedservice {
  Future<currentUser> getCurrentUser();

  Future<bool> setCurrentUser(currentUser user);

  Future<bool> sigOutCurrentUser();
}

class serviceAuth implements sharedservice {
  final String KEY_DIPLAYNAME = "displayName";
  final String KEY_UID = "uid";
  final String KEY_EMAIL = "email";
  final String KEY_PHOTOURL = "photoUrl";
  final String KEY_LOGINSTATUS = "loginStatus";

  @override
  Future<currentUser> getCurrentUser() async {
    // TODO: implement getCurrentUser
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      bool CheckUID = prefs.containsKey(KEY_UID);
      bool ChekStatus = prefs.containsKey(KEY_LOGINSTATUS);
      if (CheckUID || ChekStatus) {
        return await currentUser(
          uid: prefs.getString(KEY_UID),
          displayName: prefs.getString(KEY_DIPLAYNAME),
          email: prefs.getString(KEY_EMAIL),
          photoUrl: prefs.getString(KEY_PHOTOURL),
          loginStatus: prefs.getBool(KEY_LOGINSTATUS),
        );
      } else {
        return await currentUser(
          uid: "",
          loginStatus: false,
        );
      }
    } catch (e) {
      print("Islamic Center ${e.toString()}");
    }
  }

  @override
  Future<bool> sigOutCurrentUser() async {
    // TODO: implement removeCurrentUser
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      bool CheckUID = prefs.containsKey(KEY_UID);
      bool ChekStatus = prefs.containsKey(KEY_LOGINSTATUS);
      if (CheckUID || ChekStatus) {
        prefs.setString(KEY_UID, "");
        prefs.setBool(KEY_LOGINSTATUS, false);
      }
    } catch (e) {
      print("Islamic Center ${e.toString()}");
    }
    return true;
  }

  @override
  Future<bool> setCurrentUser(currentUser user) async {
    // TODO: implement setCurrentUser
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString(KEY_DIPLAYNAME, user.displayName);
      prefs.setString(KEY_UID, user.uid);
      prefs.setString(KEY_EMAIL, user.email);
      prefs.setBool(KEY_LOGINSTATUS, true);
      prefs.setString(KEY_PHOTOURL, user.photoUrl);
    } catch (e) {
      print("Islamic center : ${e.toString()}");
    }
    return true;
  }
}
