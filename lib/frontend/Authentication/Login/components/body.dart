import 'package:book_barn/backend/services/Authentication/authentication_service.dart';
import 'package:book_barn/backend/functions/validators.dart';
import 'package:book_barn/frontend/Authentication/Login/components/background.dart';
import 'package:book_barn/frontend/Authentication/SignUp/SignUpScreen.dart';
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
import 'package:form_field_validator/form_field_validator.dart';

import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String email;
  String password;

  Future<void> submit() async {
    final form = _formKey.currentState;
    try {
      if (form.validate()) {
        progressIndicator(context);
        await Provider.of<AuthProvider>(context, listen: false)
            .login(email, password);
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
          onTap: () => () {
            Navigator.pop(context);
            dissmissProgressIndicator(context);
          },
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
    return Background(
      child: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOGIN",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/image2.svg",
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: size.height * 0.03),
                    Column(
                      children: [
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
                      ],
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      press: submit,
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
