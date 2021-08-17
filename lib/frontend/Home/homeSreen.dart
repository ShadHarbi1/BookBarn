import 'package:book_barn/backend/Provider/posts_provider.dart';
import 'package:book_barn/backend/models/posts.dart';
import 'package:book_barn/frontend/Home/components/mainHomeView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/HomeScreen';
  final List<Post> posts;
  const HomeScreen({Key key, this.posts}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    Provider.of<PostsDataProvider>(context, listen: false).getPostsList();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PostsDataProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: mainView(data, context),
        ),
      ),
    );
  }
}
