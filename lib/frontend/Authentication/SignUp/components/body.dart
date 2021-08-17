import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:book_barn/backend/services/Authentication/authentication_service.dart';
import 'package:book_barn/backend/functions/validators.dart';
import 'package:book_barn/frontend/Authentication/Login/loginScreen.dart';
import 'package:book_barn/frontend/Authentication/SignUp/components/background.dart';
import 'package:book_barn/frontend/Home/homeSreen.dart';
import 'package:book_barn/frontend/Widgets/alertDialog.dart';
import 'package:book_barn/frontend/Widgets/already_have_an_account_check.dart';
import 'package:book_barn/frontend/Widgets/progressIndicator.dart';
import 'package:book_barn/frontend/Widgets/rounded_button.dart';
import 'package:book_barn/frontend/Widgets/rounded_input_field.dart';
import 'package:book_barn/frontend/Widgets/rounded_password_field.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String name;
  String email;
  String password;
  String message = '';
  bool isLoading = false;
  Map response = new Map();

  Future<void> submit() async {
    final form = _formKey.currentState;
    try {
      if (form.validate()) {
        progressIndicator(context);
        await Provider.of<AuthProvider>(context, listen: false)
            .register(name, email, password);
        print("logged in");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
        dissmissProgressIndicator(context);
      } else {
        dissmissProgressIndicator(context);
        return onAlertButtonPressed(
          context: context,
          title: "Error",
          desc: "Please Fill All Of The Inputs",
          type: AlertType.error,
          buttonText: "Try again",
          onTap: () => Navigator.pop(context),
        );
      }
    } on DioError catch (e) {
      dissmissProgressIndicator(context);
      if (e.response.statusCode == 404) {
        return onAlertButtonPressed(
          context: context,
          title: "Error",
          desc: "Please Fill All Of The Inputs",
          type: AlertType.error,
          buttonText: "Try again",
          onTap: () => Navigator.pop(context),
        );
      } else if (e.response.statusCode == 401) {
        return onAlertButtonPressed(
          context: context,
          title: "Error",
          desc: "Please Fill All Of The Inputs",
          type: AlertType.error,
          buttonText: "Try again",
          onTap: () => Navigator.pop(context),
        );
      }
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading == true
        ? Center(child: CircularProgressIndicator())
        : Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "SIGN UP",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/image3.svg",
                    height: size.height * 0.25,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      RoundedInputField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          name = value.trim();
                          return Validator.nameValidator(value);
                        },
                        hintText: "Your Name",
                      ),
                      RoundedInputField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          email = value.trim();
                          return Validator.emailValidator(value);
                        },
                        hintText: "Your Email",
                      ),
                      RoundedPasswordField(
                        controller: passwordController,
                        validator: (value) {
                          password = value.trim();
                          return Validator.passwordValidator(value);
                        },
                      ),
                      RoundedButton(text: "SIGNUP", press: submit)
                    ]),
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
