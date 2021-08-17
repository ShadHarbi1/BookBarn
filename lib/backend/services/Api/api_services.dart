import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_barn/backend/controllers/ApiRequests/api_error_handling.dart';
import 'package:book_barn/backend/models/posts.dart';
import 'package:book_barn/backend/services/Authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:either_option/either_option.dart';
import 'package:dio/dio.dart';

class ApiServices extends ChangeNotifier {
  Future<Either<String, List<Post>>> getPostsList() async {
    var url =
        Uri.tryParse("https://bookstore-31351.herokuapp.com/api/v1/posts");
    try {
      var response = await http.get(url);
      final List responseBody = jsonDecode(response.body)["data"];

      return Right(PostsList.fromJson(responseBody).postsLists);
    } catch (e) {
      print(e);
      return Left(ApiErrorHandling.getDioException(e));
    }
  }

  Future addBook(Post post) async {
    final apiUrl =
        Uri.parse("https://bookstore-31351.herokuapp.com/api/v1/posts");
    String token = await AuthProvider().getToken();

    Map<String, dynamic> data = {
      "title": post.title,
      "content": post.content,
      "address": post.address,
      "price": post.price,
    };

    final response = await http.post(apiUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token',
        },
        body: data);
    if (response.statusCode == 201) {
      print(response);
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

/*   PostStatus _status = PostStatus.UnSent;

  final dio = Dio();

  PostStatus get status => _status;

  final url = "https://bookstore-31351.herokuapp.com/api/v1/posts"; */
/* 
  Future<bool> addBook2(String title, String content, String address,
      String category, String price) async {
    String token = await AuthProvider().getToken();
    _status = PostStatus.Sending;
    Map body = {
      "title": title,
      "content": content,
      "address": address,
      "category": category,
      "price": price,
    };

    final response = await dio.post(url,
        data: body,
        options: Options(headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token',
        }));
    if (response.statusCode == 201) {
      Map apiResponse = response.data;
      print(apiResponse);
      _status = PostStatus.Sent;
      notifyListeners();
      return true;
    }
    if (response.statusCode == 401 || response.statusCode == 400) {
      _status = PostStatus.Fail;
      // Alert dialog

      notifyListeners();
      return false;
    }
    _status = PostStatus.Fail;
    // Alert dialog

    notifyListeners();
    return false;
  } */
}

/* enum PostStatus {
  UnSent,
  Sending,
  Fail,
  Sent,
} */
