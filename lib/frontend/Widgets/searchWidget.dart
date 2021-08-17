import 'package:book_barn/frontend/values/constants.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  Search({Key key}) : super(key: key);
  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: kPrimaryLightGreyColor,
        primaryColorDark: kPrimaryLightGreyColor,
      ),
      child: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
          child: TextFormField(
            decoration: InputDecoration(
                fillColor: kPrimaryLightGreyColor,
                contentPadding: EdgeInsets.symmetric(vertical: 3),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
                hintText: "Search your coffee",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        BorderSide(width: 1.0, color: Colors.grey[400])),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: kPrimaryLightGreyColor, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                )),
          ),
        ),
      ),
    );
  }
}
