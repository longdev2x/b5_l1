import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static void showToast(String msg ,{Toast toastLength = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      toastLength: toastLength
    );
  }
}
