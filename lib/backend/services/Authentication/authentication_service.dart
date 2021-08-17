import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _status = Status.Uninitialized;
  String _token;

  final dio = Dio();

  Status get status => _status;
  String get token => _token;

  final String api = "https://bookstore-31351.herokuapp.com/api/v1/auth";

  initAuthProvider() async {
    getToken().then((value) {
      String token = value;
      if (token != null) {
        _token = token;
        _status = Status.Authenticated;
      } else {
        _status = Status.Unauthenticated;
      }
      notifyListeners();
    });
  }

  //Login user
  Future<bool> login(String email, String password) async {
    _status = Status.Authenticating;

    notifyListeners();

    final url = "$api/login";

    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final response = await dio.post(url, data: body);

    if (response.statusCode == 200) {
      Map apiResponse = response.data;
      print(apiResponse);
      _status = Status.Authenticated;
      _token = apiResponse['token'];
      await storeUserData(apiResponse);
      notifyListeners();
      return true;
    }
    if (response.statusCode == 401 || response.statusCode == 400) {
      _status = Status.Unauthenticated;
      // Alert dialog

      notifyListeners();
      return false;
    }
    _status = Status.Unauthenticated;
    // Alert dialog

    notifyListeners();
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    _status = Status.Authenticating;

    notifyListeners();

    final url = "$api/register";

    Map body = {
      'name': name,
      'email': email,
      'password': password,
    };

    final response = await dio.post(url, data: body);

    if (response.statusCode == 200) {
      Map apiResponse = response.data;
      print(apiResponse);
      _status = Status.Authenticated;
      _token = apiResponse['token'];
      await storeUserData(apiResponse);
      notifyListeners();
      return true;
    }
    if (response.statusCode == 401 || response.statusCode == 400) {
      _status = Status.Unauthenticated;
      // Alert dialog

      notifyListeners();
      return false;
    }
    _status = Status.Unauthenticated;
    // Alert dialog

    notifyListeners();
    return false;
  }

/*   Future<bool> passwordReset(String email) async {
    final url = "$api/forgotpassword";

    Map<String, String> body = {
      'email': email,
    };

    final response = await dio.post(url, data: body);

    if (response.statusCode == 200) {
      _notification = NotificationText('Reset sent. Please check your inbox.',
          type: 'info');
      notifyListeners();
      return true;
    }

    return false;
  } */

  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', apiResponse['token']);
  }

  Future<String> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String token = storage.getString('token');
    return token;
  }

  //User ID
  Future<String> getUserId() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String userID = storage.getString('userID');
    return userID;
  }

  logOut() async {
    final url = "$api/logout";
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      _status = Status.LoggedOut;
      SharedPreferences storage = await SharedPreferences.getInstance();
      await storage.clear();
      print("Logged out successfuly");
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }
}
