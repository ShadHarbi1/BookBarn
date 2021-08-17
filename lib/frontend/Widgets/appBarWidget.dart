import 'package:book_barn/frontend/AddBook/addBookScreen.dart';
import 'package:book_barn/frontend/Widgets/customIcon.dart';
import 'package:book_barn/frontend/values/colors.dart';
import 'package:book_barn/frontend/values/constants.dart';
import 'package:book_barn/frontend/values/sizes.dart';
import 'package:flutter/material.dart';

class CustomBarWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: Center(
              child: Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
          Positioned(
            top: 80.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.0),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 1.0),
                    color: Colors.white),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        print("your menu action here");
                      },
                    ),
                    Expanded(
                      child: Theme(
                        data: ThemeData(
                          primaryColor: kPrimaryLightGreyColor,
                          primaryColorDark: kPrimaryLightGreyColor,
                        ),
                        child: TextFormField(
                          cursorColor: kPrimaryLightGreyColor,
                          decoration: InputDecoration(
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            fillColor: kPrimaryLightGreyColor,
                            hintText: "Search here",
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        print("your menu action here");
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddBook()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  FractionallySizedBox _buildSearchButton(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.SIZE_20,
            horizontal: Sizes.SIZE_20,
          ),
          decoration: BoxDecoration(
            color: kPrimaryLightGreyColor,
            borderRadius: BorderRadius.circular(Sizes.SIZE_30),
          ),
          child: Row(
            children: [
              CustomIcon(name: 'search', size: Sizes.SIZE_24),
              Padding(
                padding: const EdgeInsets.only(left: Sizes.SIZE_16),
                child: Text(
                  "Search",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: AppColors.black50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
