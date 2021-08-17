import 'package:book_barn/frontend/Widgets/text_field_container.dart';
import 'package:book_barn/frontend/values/constants.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final bool isSmall;
  final bool isDescription;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final TextInputType type;
  final Function validate;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.controller,
    this.type,
    this.validate,
    this.isSmall,
    this.isDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: isDescription == true ? 200 : 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: isSmall == true ? size.width * 0.4 : size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(0xDDF2F2F2),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) => validate(value),
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: Padding(padding: EdgeInsets.all(0.0), child: icon),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
