import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/providers/auth.dart';

class SharedPrefs with ChangeNotifier {
  late SharedPreferences prefs;

  bool _isLogin = false;

  bool get isLogin {
    return _isLogin;
  }

  Future<void> addUser({
    required String username,
    required String password,
    
    required BuildContext context,
  }) async {
    
    prefs = await SharedPreferences.getInstance();
   
    await Provider.of<Auth>(context,listen: false).signUp( password: password, username: username);
    String newUser = jsonEncode(
      {
        'password': password,
        'username': username,
      },
    );
    await prefs.setString('user', newUser);
    notifyListeners();
  }

  Future<void> getUser() async {
    prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    _isLogin = userData != null;
    notifyListeners();
  }

  Future<void> logOut() async {
    prefs = await SharedPreferences.getInstance();
    bool a = await prefs.remove('user');
    _isLogin = !a;

    notifyListeners();
  }
}
