import 'package:book_barn/backend/Provider/api_base_provider.dart';
import 'package:book_barn/backend/Provider/posts_provider.dart';
import 'package:book_barn/frontend/Home/components/homeListView.dart';
import 'package:flutter/material.dart';

Widget mainView(PostsDataProvider data, BuildContext context) {
  if (data.state == UISTATE.LOADING)
    return Center(
      child: CircularProgressIndicator(),
    );
  else if (data.state == UISTATE.SUCCESS) {
    return SingleChildScrollView(child: spendingsListWidget(data, context));
  } else {
    return Center(
      child: Text(data.uiErrorMessage),
    );
  }
}
