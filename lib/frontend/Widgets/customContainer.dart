import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.2,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xDDF2F2F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
