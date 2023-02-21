import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddFetchTodo with ChangeNotifier {
  
  Future<void> addTodo() async {
    // final prefs = await SharedPreferences.getInstance();
    // final Map userData = jsonDecode(prefs.getString('user')!);
    Uri url = Uri.parse('https://diyorbekmajidov.pythonanywhere.com/add/');
    final String basicAuth = base64Encode(utf8.encode("ogabek12:qazcdewsx"));
    
    // final String basicAuth = base64Encode(utf8.encode("${userData['username']}:${userData['password']}"));
    print(basicAuth);
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'title': 'nimadur',
            'description': 'a12',
          },
        ),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Basic $basicAuth",
        },
      );
      print(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getTodo() async {
    // final prefs = await SharedPreferences.getInstance();
    // final Map userData = jsonDecode(prefs.getString('user')!);
    Uri url = Uri.parse('https://diyorbekmajidov.pythonanywhere.com/get/');

    final String basicAuth = base64Encode(utf8.encode("ogabek12:qazcdewsx"));
    // final String basicAuth = base64Encode(utf8.encode("${userData['username']}:${userData['password']}"));
   
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "authorization": "Basic ogabek12:qazcdewsx",
        },
      );
      print(response.body);
    } catch (_) {
      rethrow;
    }
  }
}
