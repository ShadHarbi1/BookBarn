import 'dart:io';
import 'package:book_barn/frontend/Home/homeSreen.dart';
import 'package:dio/dio.dart';
import 'package:book_barn/backend/services/Api/api_services.dart';
import 'package:book_barn/backend/services/Authentication/authentication_service.dart';
import 'package:book_barn/frontend/Widgets/customContainer.dart';
import 'package:book_barn/frontend/Widgets/rounded_button.dart';
import 'package:book_barn/frontend/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class UploudImageScreen extends StatefulWidget {
  const UploudImageScreen({Key key}) : super(key: key);

  @override
  _UploudImageScreenState createState() => _UploudImageScreenState();
}

class _UploudImageScreenState extends State<UploudImageScreen> {
  File _file;
  ApiServices apiServices = ApiServices();
  Future cameraPicker() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _file = File(myfile.path);
    });
  }

  String state = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
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
            ),
            RoundedButton(
              press: () async {
                if (_file == null) return null;
                //String base64 = base64Encode(_file.readAsBytesSync());
                String fileName = _file.path.split('/').last;
                String token = await AuthProvider().getToken();
                String id = await apiServices.getBookID();

                final apiUrl =
                    "https://bookstore-31351.herokuapp.com/api/v1/posts/$id/photo";

                FormData formData = FormData.fromMap({
                  "file": await MultipartFile.fromFile(_file.path,
                      filename: fileName,
                      contentType: MediaType('image', 'png')),
                  "type": "image/png"
                });
                var response = await Dio().put(apiUrl,
                    data: formData,
                    options: Options(headers: {
                      "Accept": "application/json",
                      "Content-Type": "multipart/form-data",
                      'Authorization': 'Bearer $token',
                    }));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);
                return response.data;
              },
              color: kPrimaryColor,
              text: "Add Book",
            )
          ],
        ),
      ),
    );
  }
}
