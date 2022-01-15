import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_barn/backend/controllers/ApiRequests/api_error_handling.dart';
import 'package:book_barn/backend/models/posts.dart';
import 'package:book_barn/backend/services/Authentication/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:either_option/either_option.dart';
import 'package:dio/dio.dart';

class ApiServices extends ChangeNotifier {
  File _file;

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
    final apiUrl = "https://bookstore-31351.herokuapp.com/api/v1/posts";
    String token = await AuthProvider().getToken();

    FormData formData = FormData.fromMap({
      "title": post.title,
      "content": post.content,
      "address": post.address,
      "price": post.price,
    });

    final response = await Dio().post(apiUrl,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            'Authorization': 'Bearer $token',
          },
        ),
        data: formData);
    if (response.statusCode == 201) {
      final responseBody = response.data["data"];
      storeBookData(responseBody);

      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future bookPhotoUplaod() async {
    if (_file == null) return null;
    String base64 = base64Encode(_file.readAsBytesSync());
    String image = _file.path.split('/').last;
    String token = await AuthProvider().getToken();
    String id = await getBookID();

    final apiUrl =
        "https://bookstore-31351.herokuapp.com/api/v1/posts/$id/photo";

    FormData formData = FormData.fromMap({
      "file": base64,
    });
    var response = await Dio().put(apiUrl,
        data: formData,
        options: Options(headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token',
        }));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print(response.statusMessage);
    }
  }

  storeBookData(response) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('id', response['_id']);
  }

  Future<String> getBookID() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String id = storage.getString('id');
    print(id);
    return id;
  }
}
