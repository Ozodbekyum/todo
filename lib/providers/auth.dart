import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> signUp({
    required String password,
    required String username,
  }) async {
    Uri url = Uri(
      scheme: 'https',
      host: 'diyorbekmajidov.pythonanywhere.com',
      path: 'createuser/',
    );
       
    String userData = jsonEncode({
      'username': username,
      'password': password,
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: userData,
    );
    print(response.body);
  }
}
