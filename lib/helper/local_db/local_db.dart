import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DBHelper {
  Future<bool> checkUserLogedIn() async {
    /// =================== Open BOX ======================
    await Hive.openBox('users');

    var users = Hive.box(
      'users',
    );
    // Logger().e("dd");
    if (users.get('token') == null) {
      debugPrint("hive ");
    } else {
      debugPrint("hive >>>>>>>>> ${users.get('token')})");
    }
    return users.get('token') != null;
  }

  /// ====================== Get Token ====================

  Future<String> getToken() async {
    var users = Hive.box(
      'users',
    );
    // Logger().e("dd");
    if (users.get('token') == null) {
      debugPrint("Token null");
    }
    return users.get('token');
  }

  /// ====================== Get User ID ==================

  Future<String> getUserId() async {
    var users = Hive.box(
      'users',
    );
    // Logger().e("dd");
    if (users.get('id') == null) {
      debugPrint("hive ");
    } else {
      debugPrint("hive >>>>>>>>> ${users.get('id')}");
    }
    return users.get('id');
  }

  /// ====================== Get User Role ==================

  Future<String> getUserRole() async {
    var users = Hive.box(
      'users',
    );
    // Logger().e("dd");
    if (users.get('role') == null) {
      debugPrint("User Role Error ==========>>>>>>> ${users.get('role')}");
    } else {
      debugPrint("User Role Success ==========>>>>>>>>> ${users.get('role')}");
    }
    return users.get('role');
  }

  /// ====================== Save User Information ==================

  Future storeTokenUserdata({
    String? token,
    String? image,
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? deviceToken,
    String? role,
  }) async {
    Box? users = Hive.box('users');

    users.put("token", token);
    users.put("id", id);
    users.put("email", email);
    users.put("name", name);
    users.put("image", image);
    users.put("mobile", mobile);
    users.put("deviceToken", deviceToken);
    users.put("role", role);

    debugPrint(users.get('token'));

    return "done";
  }

  Future userUpdata({String? name, String? email, String? mobile}) async {
    Box? users = Hive.box('users');
    users.put("email", email);
    users.put("name", name);
    users.put("mobile", mobile);
    return "done";
  }

  Future onbordingDone() async {
    Box? users = Hive.box('users');
    users.put("onBording", true);
    return "done";
  }

  Future<bool> onbordingCheck() async {
    Box? users = Hive.box('users');
    return users.get("onBording") != null;
  }
}
