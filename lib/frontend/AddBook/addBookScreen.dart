import 'dart:convert';
import 'dart:io';

import 'package:book_barn/backend/models/posts.dart';
import 'package:book_barn/backend/services/Api/api_services.dart';
import 'package:book_barn/frontend/AddBook/uplaodPhotoScreen.dart';
import 'package:book_barn/frontend/Widgets/alertDialog.dart';
import 'package:book_barn/frontend/Widgets/progressIndicator.dart';
import 'package:http/http.dart' as http;
import 'package:book_barn/frontend/Home/homeSreen.dart';
import 'package:book_barn/frontend/Widgets/multiLinesInput.dart';
import 'package:book_barn/frontend/Widgets/customContainer.dart';
import 'package:book_barn/frontend/Widgets/rounded_button.dart';
import 'package:book_barn/frontend/Widgets/rounded_input_field.dart';
import 'package:book_barn/frontend/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:book_barn/frontend/values/sizes.dart';
import 'package:book_barn/frontend/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key key}) : super(key: key);

  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  ApiServices apiServices = ApiServices();
  //File _file;

  /*  Future cameraPicker() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _file = File(myfile.path);
    });
    uploadImage();
  }

  Future uploadImage() async {
    if (_file == null) return null;

    String base64 = base64Encode(_file.readAsBytesSync());
    String imageName = _file.path.split('/').last;
    print(base64);
    print(imageName); // i need this
  }

  String state = ""; */

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController content = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController categoryController = TextEditingController();
    TextEditingController price = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    Future<void> submit() async {
      final form = _formKey.currentState;
      try {
        if (form.validate()) {
          //progressIndicator(context);
          print("Validated");
          await Provider.of<ApiServices>(context, listen: false)
              .addBook(new Post(
            title: title.text.trim().toString(),
            content: content.text.trim().toString(),
            address: address.text.trim().toString(),
            price: price.text.trim().toString(),
            category: categoryController.text.trim().toString(),
          ));

          print("Book Added!!");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => UploudImageScreen()),
              (Route<dynamic> route) => false);
          dissmissProgressIndicator(context);
        } else {
          print("fill all of the input please");
          /*  dissmissProgressIndicator(context);
          return onAlertButtonPressed(
            context: context,
            title: "Error",
            desc: "Please Fill All Of The Inputs",
            type: AlertType.error,
            buttonText: "Try again",
            onTap: () => Navigator.pop(context),
          ); */
        }
      } on DioError catch (e) {
        dissmissProgressIndicator(context);
        if (e.response.statusCode == 404) {
          print(e.message);
          /* return onAlertButtonPressed(
            context: context,
            title: "Error",
            desc: "Please Fill All Of The Inputs",
            type: AlertType.error,
            buttonText: "Try again",
            onTap: () => Navigator.pop(context),
          ); */
        } else if (e.response.statusCode == 401) {
          print(e.message);

          /*   return onAlertButtonPressed(
            context: context,
            title: "Error",
            desc: "Please Fill All Of The Inputs",
            type: AlertType.error,
            buttonText: "Try again",
            onTap: () => Navigator.pop(context),
          ); */
        }
        print(e.message);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: kPrimaryColor,
                    ),
                    Text(
                      "Add Book",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                RoundedInputField(
                  controller: title,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a name';
                    }
                    //title = value.trim();
                  },
                  icon: Icon(
                    Icons.label_important_rounded,
                    color: kPrimaryColor,
                  ),
                  hintText: "Title",
                ),
                RoundedInputField(
                  controller: content,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a name';
                    }
                    //content = value.trim();
                  },
                  icon: Icon(
                    Icons.description_rounded,
                    color: kPrimaryColor,
                  ),
                  isDescription: true,
                  hintText: "Descreption",
                ),
                RoundedInputField(
                  controller: address,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a name';
                    }
                    //address = value.trim();
                  },
                  icon: Icon(
                    Icons.location_city_rounded,
                    color: kPrimaryColor,
                  ),
                  hintText: "City",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*  RoundedInputField(
                      controller: categoryController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a name';
                        }
                        //categoryController = value.trim();
                      },
                      icon: Icon(
                        Icons.category_rounded,
                        color: kPrimaryColor,
                      ),
                      isSmall: true,
                      hintText: "Category",
                    ), */
                    RoundedInputField(
                      controller: price,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a name';
                        }
                        // price = value.trim();
                      },
                      icon: Icon(
                        Icons.attach_money,
                        color: kPrimaryColor,
                      ),
                      isSmall: true,
                      hintText: "Price",
                    ),
                  ],
                ),
                /*     Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomContainer(
                        child: Center(
                          child: _file == null
                              ? Text("No Image Selected")
                              : Image.file(_file),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () async {
                          cameraPicker();
                        },
                        child: CustomContainer(
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/camera.svg",
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ), */
                RoundedButton(
                  press: submit,
                  color: kPrimaryColor,
                  text: "Add Book",
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
