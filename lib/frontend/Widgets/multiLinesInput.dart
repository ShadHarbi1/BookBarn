import 'package:book_barn/frontend/Widgets/customContainer.dart';
import 'package:book_barn/frontend/Widgets/text_field_container.dart';
import 'package:book_barn/frontend/values/constants.dart';
import 'package:flutter/material.dart';

class MultiLinesInputField extends StatelessWidget {
  final String hintText;
  final TextStyle hintStyle;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final TextInputType type;
  final Function validate;
  const MultiLinesInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
    this.type,
    this.validate,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLength: null,
        maxLines: null,
        expands: true,
        validator: (value) => validate(value),
        cursorColor: kPrimaryColor,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          hintStyle: hintStyle,
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
