import 'package:auto_size_text/auto_size_text.dart';
import 'package:book_barn/backend/Provider/posts_provider.dart';
import 'package:book_barn/frontend/Widgets/appBarWidget.dart';
import 'package:flutter/material.dart';

Widget spendingsListWidget(PostsDataProvider data, BuildContext context) {
  var reversedList = data.postsList.reversed.toList();
  Size size = MediaQuery.of(context).size;
  return Column(
    children: [
      CustomBarWidget(),
      SizedBox(
        height: 40,
      ),
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: reversedList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                child: AspectRatio(
                  aspectRatio: 3 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xDDF2F2F2),
                        borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      onTap: () {
                        print(
                          reversedList[index].id,
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: 1 / 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    reversedList[index].photo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AutoSizeText(
                                      reversedList[index].title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    AutoSizeText(
                                      reversedList[index].category,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    AutoSizeText(
                                      reversedList[index].user,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          AutoSizeText(
                            "${reversedList[index].price.toString()} \$",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                backgroundColor: Colors.green[200]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    ],
  );
}
