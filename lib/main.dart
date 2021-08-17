import 'package:book_barn/backend/Provider/posts_provider.dart';
import 'package:book_barn/backend/functions/checkAuthentication.dart';
import 'package:book_barn/backend/services/Api/api_services.dart';
import 'package:book_barn/backend/services/Authentication/authentication_service.dart';
import 'package:book_barn/frontend/AddBook/addBookScreen.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<PostsDataProvider>(
            create: (_) => PostsDataProvider()),
        ChangeNotifierProvider<ApiServices>(create: (_) => ApiServices()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CheckAuth(),
      ),
    );
  }
}
