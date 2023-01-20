import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/deleteException.dart';

class Authenticator with ChangeNotifier {
  late String? token = null;
  late DateTime expiryTime;
  late String userId;
  bool isAuth() {
    if (getToken != null) {
      print("User is Authenticated!");
      return true;
    }
    return false;
  }

  String get getUserId {
    return userId;
  }

  String? get getToken {
    print("Token return");
    if (token != null &&
        expiryTime != null &&
        expiryTime.isAfter(DateTime.now())) {
      return token;
    }
    return null;
  }

  Future<void> SignUp(String? email, String? password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCYZC2Ha_KhG2u3PW11ULYoOlV7CBFMBOM';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'returnSecureToken': true,
            'email': email,
            'password': password,
          },
        ),
      );

      if (json.decode(response.body)['error'] != null) {
        throw DeleteException(json.decode(response.body)['error']['message']);
      }
      final res = json.decode(response.body);
      print(res);
      userId = res['loacalId'];
      token = res['idToken'];
      expiryTime = DateTime.now().add(
        Duration(
          seconds: int.parse(res['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String? email, String? password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCYZC2Ha_KhG2u3PW11ULYoOlV7CBFMBOM';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'returnSecureToken': true,
            'email': email,
            'password': password,
          }));

      if (json.decode(response.body)['error'] != null) {
        throw DeleteException(json.decode(response.body)['error']['message']);
      }
      final res = json.decode(response.body);
      print(res);
      userId = res['localId'];
      token = res['idToken'];
      expiryTime = DateTime.now().add(
        Duration(
          seconds: int.parse(res['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
