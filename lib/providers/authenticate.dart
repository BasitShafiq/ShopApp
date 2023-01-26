import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/screens/user_product_screen.dart';
import 'dart:convert';
import '../models/deleteException.dart';

class Authenticator with ChangeNotifier {
  late String? token = null;
  late DateTime? expiryTime;
  late String? userId;
  late Timer? authTimer = null;
  bool get isAuth {
    if (getToken != null) {
      print("User is Authenticated!");
      return true;
    }
    print("Loggog Out");
    return false;
  }

  String? get getUserId {
    return userId;
  }

  String? get getToken {
    print("Token return");
    if (token != null &&
        expiryTime != null &&
        expiryTime!.isAfter(DateTime.now())) {
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
      autoLogOut();
      final pref = await SharedPreferences.getInstance();
      final data = json.encode({
        'userToken': token,
        'userId': userId,
        'expiryTime': expiryTime!.toIso8601String()
      });
      pref.setString('UserData', data);
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
      autoLogOut();
      final pref = await SharedPreferences.getInstance();
      final data = json.encode({
        'userToken': token,
        'userId': userId,
        'expiryTime': expiryTime!.toIso8601String()
      });
      pref.setString('UserData', data);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> autoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('UserData')) {
      return false;
    }
    final data = pref.getString('UserData');
    final extractedData = json.decode(data!);
    final exp = DateTime.parse(extractedData['expiryTime']);
    if (exp.isBefore(DateTime.now())) {
      return false;
    }
    token = extractedData['userToken'];
    userId = extractedData['userId'];
    expiryTime = exp;
    notifyListeners();
    autoLogOut();
    return true;
  }

  Future<void> logOut() async {
    userId = null;
    token = null;
    expiryTime = null;
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    notifyListeners();
  }

  void autoLogOut() {
    if (authTimer != null) {
      authTimer!.cancel();
    }
    final expTime = expiryTime!.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: expTime), logOut);
  }
}
