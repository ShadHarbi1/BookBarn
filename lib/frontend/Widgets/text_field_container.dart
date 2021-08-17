import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final bool isPrice;
  const TextFieldContainer({
    Key key,
    this.child,
    this.isPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(0xDDF2F2F2),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
