import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';

progressIndicator(BuildContext context) {
  ArsProgressDialog progressDialog = ArsProgressDialog(context,
      blur: 2,
      backgroundColor: Color(0x33000000),
      animationDuration: Duration(milliseconds: 500));
  return progressDialog.show();
}

dissmissProgressIndicator(BuildContext context) {
  ArsProgressDialog progressDialog = ArsProgressDialog(context,
      blur: 2,
      backgroundColor: Color(0x33000000),
      animationDuration: Duration(milliseconds: 500));
  return progressDialog.dismiss();
}
